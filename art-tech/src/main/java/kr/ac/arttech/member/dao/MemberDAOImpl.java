package kr.ac.arttech.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.ac.arttech.member.vo.MemberVO;
import kr.ac.arttech.member.vo.MyGalleryVO;
import kr.ac.arttech.member.vo.MyHistoryVO;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDAOImpl implements MemberDAO {
	
	private final SqlSession sqlSession;
	

	//아이디 중복 확인
	@Override
	public int checkUserId(String userId) {
		return sqlSession.selectOne("kr.ac.arttech.member.checkUserId", userId);
	}
	
	//회원가입
	@Override
	public int insertMember(MemberVO member) {
		return sqlSession.insert("kr.ac.arttech.member.insertMember", member);
	}
	
	//member 정보 가져오기
	@Override
	public MemberVO selectMemberInfo(String id) {
		return sqlSession.selectOne("kr.ac.arttech.member.selectMemberInfo", id);
	}
	
	//member id(pk) 가져오기
	@Override
	public String selectMemberId(String userId) {
		return sqlSession.selectOne("kr.ac.arttech.member.selectMemberId", userId);
	}
	
	//아이디 비밀번호 확인 (count)
	@Override
	public int checkUserIdPassword(MemberVO member) {
		return sqlSession.selectOne("kr.ac.arttech.member.checkUserIdPassword", member);
	}
	
	//간편 비번 가져오기
	@Override
	public String selectEasyPassword(String id) {
		return sqlSession.selectOne("kr.ac.arttech.member.selectEasyPassword", id);
	}
	
	//myHistory 전체
	@Override
	public List<MyHistoryVO> selectMyHistoryListAll(String memberId) {
		return sqlSession.selectList("kr.ac.arttech.member.selectMyHistoryListAll", memberId);
	}
	//myHistory 모집중
	@Override
	public List<MyHistoryVO> selectMyHistoryListRecruit(String memberId) {
		return sqlSession.selectList("kr.ac.arttech.member.selectMyHistoryListRecruit", memberId);
	}
	//myHistory 모집완료(state:2,3,4,5,6)
	@Override
	public List<MyHistoryVO> selectMyHistoryListRecruitEnd(String memberId) {
		return sqlSession.selectList("kr.ac.arttech.member.selectMyHistoryListRecruitEnd", memberId);
	}
	//myHistory 매각완료 정보 
	@Override
	public List<MyHistoryVO> selectMyHistoryDisposalInfoList(String memberId) {
		return sqlSession.selectList("kr.ac.arttech.member.selectMyHistoryDisposalInfoList", memberId);
	}
	
	//myGallery all
	@Override
	public List<MyGalleryVO> selectMyGalleryAll(String memberId) {
		return sqlSession.selectList("kr.ac.arttech.member.selectMyGalleryAll",memberId);
	}
	//myGallery 모집중
	@Override
	public List<MyGalleryVO> selectMyGalleryRecruit(String memberId) {
		return sqlSession.selectList("kr.ac.arttech.member.selectMyGalleryRecruit",memberId);
	}
	//myGallery 모집완료
	@Override
	public List<MyGalleryVO> selectMyGalleryRecruitEnd(String memberId) {
		return sqlSession.selectList("kr.ac.arttech.member.selectMyGalleryRecruitEnd",memberId);
	}
	//myGallery 매각완료
	@Override
	public List<MyGalleryVO> selectMyGalleryDisposal(String memberId) {
		return sqlSession.selectList("kr.ac.arttech.member.selectMyGalleryDisposal",memberId);
	}
	
	
	//wallet update(지갑 생성 클릭)
	@Override
	public int updateWalletInfo(Map<String, String> wallet) {
		return sqlSession.update("kr.ac.arttech.member.updateWalletInfo", wallet);
	}
	
	//카카오id update
	@Override
	public int updateKakaoId(Map<String, String> map) {
		return sqlSession.update("kr.ac.arttech.member.updateKakaoId", map);
	}
	
}
