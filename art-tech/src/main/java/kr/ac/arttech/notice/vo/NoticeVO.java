package kr.ac.arttech.notice.vo;

import lombok.Data;

@Data
public class NoticeVO {
	private String id;
	private String title;
	private String type;
	private String managerId;
	private String content;
	private String regDate;
}
