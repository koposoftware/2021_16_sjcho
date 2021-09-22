package kr.ac.arttech.util;

import java.util.ArrayList;
import java.util.List;

import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;

public class CollaborativeFilteringUtil {
	
	public static List<String> getRecommendArtwork(String memberId) {
		List<String> result = null;
		
		try {
			RConnection conn = new RConnection();
			System.out.println("member id : " + memberId);
			conn.eval("source('C:/art-tech/rscript/collaborative-filtering-model.R')"); //스크립트 실행
			//리스트 받아오기 (try - catch문 사용)
			System.out.println("member id : " + memberId);
			conn.eval("who <- as.numeric(which(pivot_data$MEMBER_ID=='"+ memberId +"'))");
			conn.eval("who_analysis_data = analysis_data[who, ]");
			conn.eval("who_analysis_data[who_analysis_data == 0] <- NA");
			conn.eval("who_matrix_data <- as(as(who_analysis_data, 'matrix'), 'realRatingMatrix')");
			
			RList list = conn.eval("as(predict(recomm_best, who_matrix_data, type = 'topNList', n = 3), 'list')").asList();
			String[] ids = list.at(0).asStrings();
			result = new ArrayList<>();
			
			for(String id : ids) {
				result.add(id);
				System.out.println("id : " + id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
