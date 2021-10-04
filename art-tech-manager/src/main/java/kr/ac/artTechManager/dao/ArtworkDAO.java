package kr.ac.artTechManager.dao;

import java.util.List;
import java.util.Map;

import kr.ac.artTechManager.vo.ArtworkInfoVO;
import kr.ac.artTechManager.vo.MemberVO;
import kr.ac.artTechManager.vo.PurchaseInfoVO;
import kr.ac.artTechManager.vo.VoteVO;

public interface ArtworkDAO {
	public int insertArtworkInfo(ArtworkInfoVO artworkInfo);//공동구매 등록
	public List<ArtworkInfoVO> selectArtworkInfoList(); //공동구매 작품 리스트
	public int insertArtworkInfoImg(Map<String, Object> map); //공동구매 작품 이미지 저장
	public int selectArtworkInfoImgId(); //공동구매 이미지 시퀀스값 가져오기
	public int selectArtworkInfoId(); //공동구매 작품 시퀀스값 가져오기
	public ArtworkInfoVO selectArtworkInfo(String artworkInfoId); //goodsDetail
	public int insertArtworkAmt(String id); //가격정보 테이블에 insert
	public List<MemberVO> selectVoteMemberInfo(String artwortInfoId); //투표해야할 유저 list
	public List<MemberVO> selectDisposalSMSMemberInfo(String artwortInfoId);//매각진행 후 문자보낼 유저 
	
	public int updateArtworkInfoStateVote(String artwortInfoId); //투표중으로 상태 update
	public int insertVoteInfo(VoteVO vote);//투표시작하면 table에 insert
	public VoteVO selectVoteInfo(String artworkInfoId); //투표 정보 가져오기
	public int updateStateVote(String today); //투표중(3) -> 투표종료(4)
	public int updateArtworkState(VoteVO vote); //디테일 페이지 상태 변경
	public int updateSellInfo(VoteVO vote); //매각금액, 매각처, 매각일 update 
	public List<PurchaseInfoVO> selectPurchaseListByArtworkInfoId(String artworkInfoId); //해당 미술품 조각을 몇개 샀는지
	public int insertPurchaseInfoDisposal(Map<String, Object> paramMap); //매각정보 insert
	public int selectPurchaseInfoSeq();// selectPurchaseInfoSeq 시퀀스 가져오기
	
	public String selectArtworkTitle(String id);//작품명 가져오기
}
