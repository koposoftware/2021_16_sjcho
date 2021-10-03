package kr.ac.arttech.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.ac.arttech.artscan.vo.WalletInfoVO;
import kr.ac.arttech.member.dao.MemberDAO;
import kr.ac.arttech.member.vo.MemberVO;
import kr.ac.arttech.member.vo.MyGalleryVO;
import kr.ac.arttech.member.vo.MyHistoryVO;
import kr.ac.arttech.util.SecurityUtil;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

	private final MemberDAO dao;

	//아이디 중복검사
	@Override
	public int checkUserId(String userId) {
		return dao.checkUserId(userId);
	}
	
	//회원가입
	@Override
	public boolean addMember(MemberVO member) {
		//password 암호화
		String password = SecurityUtil.encryptSHA256(member.getPassword());
		member.setPassword(password);
		
		//간편 비밀번호 암호화
		member.setEasyPassword(SecurityUtil.encryptSHA256(member.getEasyPassword()));
		
		boolean result = false;
		if(dao.insertMember(member) == 1) {
			result = true;
		}
		return result;
	}
	
	//member id(pk) 가져오기
	@Override
	public String getMemberId(String userId) {
		return dao.selectMemberId(userId);
	}
	
	//회원정보 가져오기
	@Override
	public MemberVO getMemberInfo(String id) {
		return dao.selectMemberInfo(id);
	}
	
	//로그인 검사
	@Override
	public int checkSignin(MemberVO member) {
		int result = 0; //아이디가 존재하지 않음
		
		result += dao.checkUserId(member.getUserId()); //1 : 비번과 아이디 일치하지 않음
		result += dao.checkUserIdPassword(member); // 2: 로그인 성공~
		
		return result;
	}
	
	//my history all
	@Override
	public List<MyHistoryVO> getMyHistoryListAll(String memberId) {
		return dao.selectMyHistoryListAll(memberId);
	}
	//my history disposal
	@Override
	public List<MyHistoryVO> getMyHistoryDisposalInfoList(String memberId) {
		return dao.selectMyHistoryDisposalInfoList(memberId);
	}
	//myhistory 옵션 선택했을 때 list 
	@Override
	public List<MyHistoryVO> getMyHistoryListOption(Map<String, String> map) {
		List<MyHistoryVO> myHistoryList = null;
		String option = map.get("option");
		String memberId = map.get("memberId");
		
		switch (option) {
		case "all": //전체
			myHistoryList = dao.selectMyHistoryListAll(memberId);
			break;
		
		case "ing" : //모집중
			myHistoryList = dao.selectMyHistoryListRecruit(memberId);
			break;
		
		case "end" : //모집완료
			myHistoryList = dao.selectMyHistoryListRecruitEnd(memberId);
			break;
			
		case "disposal": //매각작품
			myHistoryList = dao.selectMyHistoryDisposalInfoList(memberId);
			break;
		}
		
		return myHistoryList;
	}
	
	//myGallery list
	@Override
	public List<MyGalleryVO> getMyGalleryList(Map<String, String> map) {
		String option = map.get("option");
		String memberId = map.get("memberId");
		List<MyGalleryVO> myGalleryList = null;
		switch (option) {
		case "all":
			myGalleryList = dao.selectMyGalleryAll(memberId);
			break;
		case "ing" : //모집중
			myGalleryList = dao.selectMyGalleryRecruit(memberId);
			break;
		case "end" : //모집완료
			myGalleryList = dao.selectMyGalleryRecruitEnd(memberId);
			break;
		case "disposal" : //매각완료
			myGalleryList = dao.selectMyGalleryDisposal(memberId);
			break;
		
		}
		
		return myGalleryList;
	}
	
	//my history 내가 산 조각 개수
	@Override
	public List<MyHistoryVO> getMyHistoryBuyPieceNo(String memberId) {
		return dao.selectMyHistoryBuyPieceNo(memberId);
	}
	
	//지갑 생성
	@Override
	public String createWalletInfo(String id) {
		String result = "";
		//지갑 생성
		String url = "http://localhost:18080/wallet";
		RestTemplate restTemplate = new RestTemplate();
		Map<String, Object> data = (Map<String, Object>) restTemplate.postForObject(url,null, Object.class);
		Map<String, String> wallet = (Map<String, String>) data.get("data");
		wallet.put("id", id);
		
		int cnt = dao.updateWalletInfo(wallet);
		if(cnt == 1) {
			result = wallet.get("publicKey");
		}
		return result;
	}
	
	//간편 비밀번호 가져오기
	@Override
	public String getEasyPassword(String memberId) {
		return dao.selectEasyPassword(memberId);
	}
	
	//카카오id update
	@Override
	public boolean addKakaoId(Map<String, String> map) {
		boolean result = false;
		
		int cnt = dao.updateKakaoId(map);
		if(cnt == 1) {
			result = true;
		}
		return result;
	}
}
