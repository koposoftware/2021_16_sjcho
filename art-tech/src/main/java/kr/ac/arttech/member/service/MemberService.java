package kr.ac.arttech.member.service;

import java.util.List;
import java.util.Map;

import kr.ac.arttech.member.vo.MemberVO;
import kr.ac.arttech.member.vo.MyGalleryVO;
import kr.ac.arttech.member.vo.MyHistoryVO;

public interface MemberService {
	public int checkUserId(String userId); //아이디 있는지 확인 (count)
	public boolean addMember(MemberVO member) ; //회원가입
	
	public MemberVO getMemberInfo(String id); //회원정보 가져오기
	public String getMemberId(String userId); //member id(pk) 가져오기
	
	public int checkSignin(MemberVO member); //아이디 비밀번호 chekc(count)
	
	public List<MyHistoryVO> getMyHistoryListAll(String memberId); //my history all
	public List<MyHistoryVO> getMyHistoryDisposalInfoList(String memberId);//my history disposal
	public List<MyHistoryVO> getMyHistoryListOption(Map<String, String> map); //myhistory 옵션 선택했을 때 list 
	
	public List<MyGalleryVO> getMyGalleryList(Map<String, String> map); //myGallery list
	
	public String createWalletInfo(String id); //지갑 생성하기
	
	public String getEasyPassword(String memberId); //간편 비밀번호 가져오기
	
	public boolean addKakaoId(Map<String, String> map); //카카오id update

}
