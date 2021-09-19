package kr.ac.arttech.cobuying.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.ac.arttech.cobuying.vo.ArtworkInfoImgVO;
import kr.ac.arttech.cobuying.vo.ArtworkInfoVO;
import kr.ac.arttech.cobuying.vo.PurchaseInfoVO;
import kr.ac.arttech.util.PagingVO;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CobuyingDAOImpl implements CobuyingDAO {
	private final SqlSession sqlSession;
	
	
	//goods list
	@Override
	public List<ArtworkInfoVO> selectArtworkInfoList() {
		return sqlSession.selectList("kr.ac.arttech.cobuying.selectArtworkInfoList");
	}
	@Override
	public List<ArtworkInfoVO> selectArtworkInfoListPaging(PagingVO paging) {
		return sqlSession.selectList("kr.ac.arttech.cobuying.selectArtworkInfoListPaging", paging);
	}
	
	//goods detail
	@Override
	public ArtworkInfoVO selectArtworkInfo(String id) {
		return sqlSession.selectOne("kr.ac.arttech.cobuying.selectArtworkInfo" , id);
	}
	
	//goods detail img
	@Override
	public List<ArtworkInfoImgVO> selectArtworkInfoImgList(String id) { //artwork_Info_id
		return sqlSession.selectList("kr.ac.arttech.cobuying.selectArtworkInfoImgList", id);
	}
	
	//구매정보 insert
	@Override
	public int insertPurchaseInfo(PurchaseInfoVO purchaseInfo) {
		return sqlSession.insert("kr.ac.arttech.cobuying.insertPurchaseInfo", purchaseInfo);
	}
	//조각 개수 update
	@Override
	public int updateArtworkPieceInfo(Map<String, Object> paramMap) {
		return sqlSession.update("kr.ac.arttech.cobuying.updateArtworkPieceInfo", paramMap);
	}
	
	//조각 산 총 금액 (판 것은 빼기)
	@Override
	public String selectTotalPurchaseAmt(String memberId) {
		return sqlSession.selectOne("kr.ac.arttech.cobuying.selectTotalPurchaseAmt", memberId);
	}
	
	//작품 상태 update
	//모집예정(0) -> 모집중(1)
	@Override
	public int updateStateByStartDate(String today) {
		return sqlSession.update("kr.ac.arttech.cobuying.updateStateByStartDate", today);
	}
	//모집중(1) -> 모집완료(2)
	@Override
	public int updateStateByEndDate(String today) {
		return sqlSession.update("kr.ac.arttech.cobuying.updateStateByEndDate", today);
	}
	
	//소유자 현황 list
	@Override
	public List<ArtworkInfoVO> selectOwnershipList() {
		return sqlSession.selectList("kr.ac.arttech.cobuying.selectOwnershipList");
	}
	
	//해당 그림 소유 총 인원
	@Override
	public List<PurchaseInfoVO> selectTotalOwnerList(String id) {
		return sqlSession.selectList("kr.ac.arttech.cobuying.selectTotalOwnerList", id);
	}
	
	//wallet (publickey 가져오기)
	@Override
	public String selectWallet(String memberId) {
		return sqlSession.selectOne("kr.ac.arttech.cobuying.selectWallet", memberId);
	}
	
	//매각진행현황 list
	@Override
	public List<ArtworkInfoVO> selectDisposalList() {
		return sqlSession.selectList("kr.ac.arttech.cobuying.selectDisposalList");
	}
	
	//작품 총 개수
	@Override
	public int selectArtworkCount() {
		return sqlSession.selectOne("kr.ac.arttech.cobuying.selectArtworkCount");
	}
	
}
