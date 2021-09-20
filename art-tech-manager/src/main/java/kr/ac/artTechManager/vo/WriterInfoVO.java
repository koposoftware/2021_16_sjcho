package kr.ac.artTechManager.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class WriterInfoVO {
	private String id;
	private String writerName;
	private String awardHistory; //수상 이력
	private String writerInfo ; //작가 정보
	private String career ; //전시 이력
	private String fileChanName ; //변경된 파일 이름
	private String filePath ; //파일 경로
	private String orgnFileName ; //원파일명
	private long fileSize; //파일 크기
	private String regDate ; //등록날짜
	
	
}
