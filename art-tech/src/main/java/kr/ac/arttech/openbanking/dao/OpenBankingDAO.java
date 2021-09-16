package kr.ac.arttech.openbanking.dao;

import java.util.List;
import java.util.Map;

import kr.ac.arttech.member.vo.MemberVO;
import kr.ac.arttech.openbanking.vo.AccountInfoVO;
import kr.ac.arttech.openbanking.vo.AccountTransferInfoVO;
import kr.ac.arttech.openbanking.vo.AutoTranAccountVO;
import kr.ac.arttech.openbanking.vo.AutoTranInfoSMSVO;
import kr.ac.arttech.openbanking.vo.ManageAccountInfoVO;

public interface OpenBankingDAO {
	public String checkServiceAgree(String memberId); //오픈뱅킹 동의했는지 확인
	public int updateServiceAgreeState(MemberVO member); //오픈뱅킹 동의(토큰넣기, Y로 바꾸기)
	
	public MemberVO selectMemberNameJumin(String memberId); //오픈뱅킹 토큰 생성을 위한 정보 가져오기 
	public String selectToken(String memberId) ; //토큰 가져오기 
	
	public List<AutoTranAccountVO> selectAutoAccountList(String memberId);  //자동예치금 설정한 계좌 리스트(한명)
	public List<AccountInfoVO> selectNonAutoAccountList(Map<String, String> map); //설정 안한 계좌 리스트(한명)
	public String selectJuminNo(String memberId);
	
	public int insertAutoAccountInfo(Map<String, Object> paramMap) ; //자동이체 설정
	public int deleteAutoAccountInfo(Map<String, Object> paramMap) ; //자동이체 설정 취소
	
	
	public int selectSeqNo();//자동이체 시퀀스 가져오기
	public List<AutoTranAccountVO> selectAutoTranAccountInfoList(); //자동이체할 계좌 list 가져오기
	
	public ManageAccountInfoVO selectManageAccountInfo(); //회사 계좌 정보
	
	public List<AutoTranInfoSMSVO> selectAutoTranInfoSMS();//자동이체 신청한 계좌정보와 사람 정보 가져와서 문자보내기
	
	
	
	
	
}
