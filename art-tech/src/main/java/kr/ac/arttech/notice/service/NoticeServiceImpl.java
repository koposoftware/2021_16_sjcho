package kr.ac.arttech.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.ac.arttech.notice.dao.NoticeDAO;
import kr.ac.arttech.notice.vo.NoticeVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	private final NoticeDAO dao;
	
	//전체 list
	@Override
	public List<NoticeVO> getNoticeList() {
		return dao.selectNoticeList();
	}
	
	//select one
	@Override
	public NoticeVO getNotice(String id) {
		return dao.selectNotice(id);
	}
}
