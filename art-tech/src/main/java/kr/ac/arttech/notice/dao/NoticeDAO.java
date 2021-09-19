package kr.ac.arttech.notice.dao;

import java.util.List;

import kr.ac.arttech.notice.vo.NoticeVO;

public interface NoticeDAO {
	public List<NoticeVO> selectNoticeList(); //전체 리스트
	public NoticeVO selectNotice(String id); //select one
}
