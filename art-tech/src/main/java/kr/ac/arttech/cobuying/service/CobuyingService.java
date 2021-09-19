package kr.ac.arttech.cobuying.service;

import java.util.List;
import java.util.Map;

import kr.ac.arttech.cobuying.vo.ArtworkInfoVO;
import kr.ac.arttech.cobuying.vo.PurchaseInfoVO;
import kr.ac.arttech.util.PagingVO;

public interface CobuyingService {
	public List<ArtworkInfoVO> getArtworkInfoList(); //goods list
	public List<ArtworkInfoVO> getArtworkInfoListPaging(PagingVO paging); //goods list
	
	
	public Map<String, Object> getArtworkInfo(String id); //goods detail
	public String getEasyPassword(String id); //easy password
	public boolean addPurchaseInfo(PurchaseInfoVO purchaseInfo); //구매정보 insert
	
	public Map<String, Integer> modifyState();  //상태 update
	public List<ArtworkInfoVO> getOwnershipList();//소유자 현황 list
	public List<PurchaseInfoVO> getTotalOwnerList(String id); //해당 그림 소유 list
	
	public List<ArtworkInfoVO> getDisposalList(); //매각진행현황 list
	
	public int getArtworkCount(); //작품 총 개수 
	public List<ArtworkInfoVO> getRecommendArtworkInfoList(String memberId) ; //협업필터링으로 추천한 작품 정보 리스트
}
