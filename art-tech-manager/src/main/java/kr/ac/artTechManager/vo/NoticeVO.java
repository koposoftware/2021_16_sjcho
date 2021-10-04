package kr.ac.artTechManager.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeVO {
	private String id;
	private String title;
	private String type; //1.공지 2.이벤트
	private String managerId;
	private String content;
	private String regDate;
}
