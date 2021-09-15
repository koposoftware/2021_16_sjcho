package kr.ac.arttech.member.dao;

import java.util.List;
import java.util.Map;

import kr.ac.arttech.member.vo.MemberVO;
import kr.ac.arttech.member.vo.MyGalleryVO;
import kr.ac.arttech.member.vo.MyHistoryVO;

public interface MemberDAO {
	public int checkUserId(String userId); //아이디 있는지 확인(count)
	public int insertMember(MemberVO member); //회원가입
	
	public MemberVO selectMemberInfo(String id); //member 정보 가져오기
	public String selectMemberId(String userId); //member id(pk) 가져오기
	
	public int checkUserIdPassword(MemberVO member); //아이디 비밀번호 확인 (count)
	public String selectEasyPassword(String id); //간편 비번 가져오기
	
	public List<MyHistoryVO> selectMyHistoryListAll(String memberId) ; //myHistory 전체
	public List<MyHistoryVO> selectMyHistoryListRecruit(String memberId) ; //myHistory 모집중
	public List<MyHistoryVO> selectMyHistoryListRecruitEnd(String memberId) ; //myHistory 모집완료(state:2,3,4,5,6)
	public List<MyHistoryVO> selectMyHistoryDisposalInfoList(String memberId); //myHistory 매각완료 정보 
	
	public List<MyGalleryVO> selectMyGalleryAll(String memberId); //myGallery all
	public List<MyGalleryVO> selectMyGalleryRecruit(String memberId); //myGallery 모집중
	public List<MyGalleryVO> selectMyGalleryRecruitEnd(String memberId); //myGallery 모집완료
	public List<MyGalleryVO> selectMyGalleryDisposal(String memberId); //myGallery 매각완료
	
	public int updateWalletInfo(Map<String, String> wallet); //wallet update(지갑 생성 클릭)
	
	public int updateKakaoId(Map<String, String> map); //카카오id update
	
}
