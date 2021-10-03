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
library(reshape2)
pivot_data <- dcast(raw_data, MEMBER_ID ~ ARTWORK_INFO_ID, value.var = "PIECE_NO" ,sum)
mode(pivot_data)
pivot_data # 피벗 테이블 데이터

analysis_data <- pivot_data[,-1] #분석에 필요한 데이터(member_id 빼기)
analysis_data[analysis_data == 0] <- NA
analysis_data <- log(analysis_data) #로그변환
analysis_data

# ************협업필터링************
library(recommenderlab)

#협업 필터링을 사용하기 위한 데이터 형태로 바꾸기(realRatingMatrix 형태)
matrix_data <- as(as(analysis_data, "matrix"), 'realRatingMatrix')
matrix_data


rec_UBCF <- readRDS('C:/art-tech/rscript/model.rds')

#해당 id를 가진 사용자의 행번호 추출 (여기부터 자바에서 실행)
 who <- as.numeric(which(pivot_data$MEMBER_ID=='member22')) #who : member id의 row
 who_analysis_data = analysis_data[who, ]
 who_analysis_data[who_analysis_data == 0] <- NA
 who_matrix_data <- as(as(who_analysis_data, 'matrix'), 'realRatingMatrix')
 as(predict(rec_UBCF, who_matrix_data, type = 'topNList', n = 3), 'list') #결과는 list

