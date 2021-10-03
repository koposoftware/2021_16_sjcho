
# install.packages("rJava") 
# install.packages("DBI")
# install.packages("RJDBC")
# install.packages('Rserve','http://www.rforge.net/') #자바 연동
# install.packages("recommenderlab") #협업필터링


#************오라클 연동 lib************
library(rJava)
# Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_291')
# library(DBI)
library(RJDBC)

#************자바 연동 lib************
library(Rserve)
Rserve(FALSE, port=6311, args = '--RS-encoding utf8 --no-svae --slave
       --encoding utf8 --internet2')
Rserve(args = "--RS- encoding utf8")


#************오라클에서 데이터 가져오기************
# 1. Driver Loading
drv<-JDBC(driverClass = "oracle.jdbc.driver.OracleDriver", classPath = "C:\\Users\\whtpw\\Desktop\\ojdbc8.jar")

# 2. Connection
conn <-dbConnect(drv, "jdbc:oracle:thin:@127.0.0.1:1521:xe", "library", "library")

query <- "select * from sj_purchase_info where type != 3
and member_id in (select member_id from 
(select member_id , count(*) as artwork_buy_no from 
(select member_id,artwork_info_id from sj_purchase_info where type != 3 group by member_id,artwork_info_id)
group by member_id) 
where artwork_buy_no >= 5)"

dbGetQuery(conn, query)
raw_data <- data.frame(dbGetQuery(conn, query))


# ************피벗테이블************
raw_data
library(reshape2)
library(caret)
library(recommenderlab)
pivot_data <- dcast(raw_data, MEMBER_ID ~ ARTWORK_INFO_ID, value.var = "PIECE_NO" ,sum)
mode(pivot_data)
pivot_data # 피벗 테이블 데이터


analysis_data <- pivot_data[,-1] #분석에 필요한 데이터(member_id 빼기)
analysis_data[analysis_data == 0] <- NA
analysis_data <- log(analysis_data) #로그변환



#analysis_data<-read.csv('e:/rtest/test.csv')

analysis_data<-analysis_data[,-1]
analysis_data[is.na(analysis_data)==TRUE] <-0
matrix_data <- as(as(analysis_data, "matrix"), 'realRatingMatrix')

eval_sets <- evaluationScheme(data = matrix_data,
                              method = "cross-validation",
                              #train = 0.7,
                              k = 5,
                              goodRating = 3,
                              given = 3)

#k-fold의 데이터 갯수
sapply(eval_sets@runsTrain, length)


recomm_eval <- Recommender(data = getData(eval_sets, "train"),
                           method = "UBCF", 
                           parameter = NULL)

pred_eval <- predict(recomm_eval, 
                     newdata = getData(eval_sets, "known"),
                     n = 3, type = "ratings")


accuracy_eval <- calcPredictionAccuracy(x = pred_eval,
                                        data = getData(eval_sets, "unknown"),
                                        byUser = TRUE)

accuracy_eval <- evaluate(x = eval_sets, 
                          method = "UBCF", n=1:20)


result_vc<-c()

result<-getConfusionMatrix(accuracy_eval)

result[[1]][20,6]


result_vc<-c()

for(i in 1:length(result)){
  result_vc[i]<-result[[i]][20,6]
}

result_vc

best_train<-analysis_data[eval_sets@runsTrain[[which.max(result_vc)]],]
best_train<-as(as(best_train, "matrix"), 'realRatingMatrix')

recomm_best <- Recommender(data = best_train,
                           method = "UBCF", 
                           parameter = NULL)


#모델 저장
#saveRDS(recomm_best, file = 'C:/art-tech/rscript/model.rds')

# who <- as.numeric(which(pivot_data$MEMBER_ID=='member22')) #who : member id의 row
# who_analysis_data = analysis_data[who, ]
# who_analysis_data[who_analysis_data == 0] <- NA
# who_matrix_data <- as(as(who_analysis_data, 'matrix'), 'realRatingMatrix')
# as(predict(recomm_best, who_matrix_data, type = 'topNList', n = 3), 'list') #결과는 list
