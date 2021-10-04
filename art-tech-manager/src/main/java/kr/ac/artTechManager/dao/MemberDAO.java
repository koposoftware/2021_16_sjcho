package kr.ac.artTechManager.dao;

import java.util.List;

import kr.ac.artTechManager.vo.MemberVO;

public interface MemberDAO {
	public List<MemberVO> selectMemberInfoList(); //전체 멤버 정보 list
	public String selectMemberName(String id); //해당 id의 이름 가져오기
	public MemberVO selectGenderNo();//남녀 수 
	public MemberVO selectCobuyingParticipation(); //공동구매 참여/미참여
}
