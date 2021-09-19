package kr.ac.arttech.notice.service;

import java.util.List;

import kr.ac.arttech.notice.vo.NoticeVO;

public interface NoticeService {
	public List<NoticeVO> getNoticeList(); //전체 리스트
	public NoticeVO getNotice(String id); //select one

}
