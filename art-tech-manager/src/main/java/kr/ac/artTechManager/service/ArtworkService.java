package kr.ac.artTechManager.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.ac.artTechManager.vo.ArtworkInfoVO;
import kr.ac.artTechManager.vo.MemberVO;
import kr.ac.artTechManager.vo.VoteVO;

public interface ArtworkService {
	public boolean addArtworkInfo(ArtworkInfoVO artworkInfo, List<MultipartFile> multipartFile) throws Exception; //모집공고 추가(작품 올리기)
	public List<ArtworkInfoVO> getArtworkInfoList(); //전체 리스트
	public Map<String, Object> getArtworkInfo(String artworkInfoId); //디테일 정보
	public String startVote(VoteVO vote); //매각투표 
	public VoteVO getVoteInfo(String artworkInfoId); //투표 정보 가져오기
	public int modifyStateVote();//투표중(3) -> 투표종료(4) : 스케줄러 
	
	//디테일 페이지 업무
	public String startGoodsDetailTast(VoteVO vote);
	
	//로그분석
	public Map<String, Object> getGoodsClickGraph() throws Exception;//작품 당 클릭 수 그래프
	public LinkedHashMap<String, Integer> getloginTime() throws Exception; //로그인 시간 데이터
	public List<MemberVO> geLoginTopMemberList() throws Exception; //로그인 많이 한 회원
	public MemberVO getGenderNo() ; //성별 수
	public MemberVO getCobuyingParticipation();//공동구매 참여 or 미참여
}
