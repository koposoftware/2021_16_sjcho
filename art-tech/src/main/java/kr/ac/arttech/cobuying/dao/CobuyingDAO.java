package kr.ac.arttech.cobuying.dao;

import java.util.List;
import java.util.Map;

import kr.ac.arttech.cobuying.vo.ArtworkInfoImgVO;
import kr.ac.arttech.cobuying.vo.ArtworkInfoVO;
import kr.ac.arttech.cobuying.vo.PurchaseInfoVO;
import kr.ac.arttech.util.PagingVO;

public interface CobuyingDAO {
	public List<ArtworkInfoVO> selectArtworkInfoList(); //goods list
	public List<ArtworkInfoVO> selectArtworkInfoListPaging(PagingVO paging); //goods list paging
	
	public ArtworkInfoVO selectArtworkInfo(String id) ; //goods detail
	public List<ArtworkInfoImgVO> selectArtworkInfoImgList(String id); //goods detail img
	
	//구매
	public int insertPurchaseInfo(PurchaseInfoVO purchaseInfo); //구매정보 insert
	public int updateArtworkPieceInfo(Map<String, Object> paramMap ); //조각 개수 update
	
	public String selectTotalPurchaseAmt(String memberId); //조각 산 총 금액 (판 것은 빼기)
	
	//작품 상태 update
	public int updateStateByStartDate(String today);
	public int updateStateByEndDate(String today);
	
	public List<ArtworkInfoVO> selectOwnershipList(); //소유자 현황 list
	public List<PurchaseInfoVO> selectTotalOwnerList(String id); //해당 그림 소유 리스트
	
	public String selectWallet(String memberId);//wallet (publickey 가져오기)
	public List<ArtworkInfoVO> selectDisposalList(); //매각진행현황 list
	
	public int selectArtworkCount(); //작품 총 개수 
}
