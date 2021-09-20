package kr.ac.artTechManager.service;

import java.util.List;

import kr.ac.artTechManager.vo.NoticeVO;

public interface NoticeService {
	public List<NoticeVO> getNoticeList();  //select all
	public boolean addNotice(NoticeVO notice); //insert
	
	public NoticeVO getNotice(String id); //select one
}
