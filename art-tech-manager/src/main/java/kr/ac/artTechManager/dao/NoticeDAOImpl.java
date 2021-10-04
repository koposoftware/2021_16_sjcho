package kr.ac.artTechManager.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.ac.artTechManager.vo.NoticeVO;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NoticeDAOImpl implements NoticeDAO{
	
	private final SqlSession sqlSession;
	
	//select all
	@Override
	public List<NoticeVO> selectNoticeList() {
		return sqlSession.selectList("kr.ac.kopo.manage.notice.selectNoticeList");
	}
	
	//select one
	@Override
	public NoticeVO selectNotice(String id) {
		return sqlSession.selectOne("kr.ac.kopo.manage.notice.selectNotice", id);
	}
	
	//insert
	@Override
	public int insertNotice(NoticeVO notice) {
		return sqlSession.insert("kr.ac.kopo.manage.notice.insertNotice", notice);
	}
}
