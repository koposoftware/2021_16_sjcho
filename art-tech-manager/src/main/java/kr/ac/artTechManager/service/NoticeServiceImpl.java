package kr.ac.artTechManager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.ac.artTechManager.dao.NoticeDAO;
import kr.ac.artTechManager.vo.NoticeVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService{
	private final NoticeDAO dao;
	
	@Override
	public List<NoticeVO> getNoticeList() {
		return dao.selectNoticeList();
	}
	
	//select one
	@Override
	public NoticeVO getNotice(String id) {
		return dao.selectNotice(id);
	}
	
	//insert 
	@Override
	public boolean addNotice(NoticeVO notice) {
		
		boolean result = false;
		if(dao.insertNotice(notice) == 1) {
			result = true;
		}
		return result;
	}
}
