package kr.ac.artTechManager.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.ac.artTechManager.vo.MemberVO;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDAOImpl implements MemberDAO {
	
	private final SqlSession sqlSession;
	
	//전체 멤버 정보 list
	@Override
	public List<MemberVO> selectMemberInfoList() {
		return sqlSession.selectList("kr.ac.kopo.manage.member.selectMemberInfoList");
	}
	
	//해당 id의 이름 가져오기
	@Override
	public String selectMemberName(String id) {
		return sqlSession.selectOne("kr.ac.kopo.manage.member.selectMemberName", id);
	}
	
	//남녀 수 
	@Override
	public MemberVO selectGenderNo() {
		return sqlSession.selectOne("kr.ac.kopo.manage.member.selectGenderNo");
	}
	//공동구매 참여/미참여
	@Override
	public MemberVO selectCobuyingParticipation() {
		return sqlSession.selectOne("kr.ac.kopo.manage.member.selectCobuyingParticipation");
	}
}
