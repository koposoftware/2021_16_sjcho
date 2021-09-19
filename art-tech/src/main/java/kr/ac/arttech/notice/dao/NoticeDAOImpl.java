package kr.ac.arttech.notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.ac.arttech.notice.vo.NoticeVO;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NoticeDAOImpl implements NoticeDAO {
	private final SqlSession sqlSession;
	
	//전체 리스트
	@Override
	public List<NoticeVO> selectNoticeList() {
		return sqlSession.selectList("kr.ac.arttech.notice.selectNoticeList");
	}
	
	//select one
	@Override
	public NoticeVO selectNotice(String id) {
		return sqlSession.selectOne("kr.ac.arttech.notice.selectNotice", id);
	}
}
