package kr.ac.artTechManager.dao;

import java.util.List;

import kr.ac.artTechManager.vo.NoticeVO;

public interface NoticeDAO {
	public List<NoticeVO> selectNoticeList(); //select all
	public int insertNotice(NoticeVO notice); //insert
	public NoticeVO selectNotice(String id); //select one
}
