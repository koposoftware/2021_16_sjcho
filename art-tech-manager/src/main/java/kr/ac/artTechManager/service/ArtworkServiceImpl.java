package kr.ac.artTechManager.service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import kr.ac.artTechManager.dao.ArtworkDAO;
import kr.ac.artTechManager.dao.MemberDAO;
import kr.ac.artTechManager.util.AuthUtil;
import kr.ac.artTechManager.util.LogFileReader;
import kr.ac.artTechManager.vo.ArtworkInfoImg;
import kr.ac.artTechManager.vo.ArtworkInfoVO;
import kr.ac.artTechManager.vo.MemberVO;
import kr.ac.artTechManager.vo.PurchaseInfoVO;
import kr.ac.artTechManager.vo.VoteVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ArtworkServiceImpl implements ArtworkService{
	
	private final ArtworkDAO dao;
	private final MemberDAO memberDao;
	
	//add artwork
	@Transactional
	@Override
	public boolean addArtworkInfo(ArtworkInfoVO artworkInfo, List<MultipartFile> multipartFile) throws Exception{
		boolean result = false;
		
		String id = "artwork" + dao.selectArtworkInfoId();
		
		//db에 저장 후 성공하면 트랜잭션 추가(admin 지갑에 추가)
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		JsonObject parameters = new	JsonObject();
		parameters.addProperty("artId", id);
		parameters.addProperty("value", artworkInfo.getTargetPiece());
		
		HttpEntity<Object> entity = new HttpEntity<Object>(parameters.toString(), headers);
		
		String url = "http://localhost:18080/art";
		
		RestTemplate restTemplate = new RestTemplate();
		Object blockHash = restTemplate.postForObject(url,entity, Object.class);
		
		System.out.println(blockHash);
		
		
		
		//작품 이미지 데이터 
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		String filePath = "C:/art-tech/artwork_img";
		List<ArtworkInfoImg> artworkInfoImgList = new ArrayList<ArtworkInfoImg>();
		
		
		
		List<String> fileNameList = new ArrayList<>();
		
		//파일이 존재할 때
		if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
			for(MultipartFile file : multipartFile) {
				ArtworkInfoImg artworkInfoImg = new ArtworkInfoImg();
				
				artworkInfoImg.setOrgnFileName(file.getOriginalFilename());
				String fileChanName = UUID.randomUUID().toString().replace("-", "") + file.getOriginalFilename();
				artworkInfoImg.setFileChanName(fileChanName);
				artworkInfoImg.setFileSize(file.getSize());
				artworkInfoImg.setArtworkInfoId(id);
				artworkInfoImg.setFilePath(filePath);
				artworkInfoImg.setId("artworkImg" + dao.selectArtworkInfoImgId());
				artworkInfoImgList.add(artworkInfoImg);
				fileNameList.add(fileChanName);
			
			}
			paramMap.put("paramMap", artworkInfoImgList);
		}
		
		
		//작품 정보 저장
		artworkInfo.setId(id);
		int cnt = dao.insertArtworkInfo(artworkInfo);
		//이미지 저장
		cnt += dao.insertArtworkInfoImg(paramMap);
		
		//가격 테이블에 insert
		cnt += dao.insertArtworkAmt(id);
		
		
		
		if(cnt > 2) {
			
			for(int i = 0; i < multipartFile.size() ; ++i ) {
				File dest = new File(filePath + "/" + fileNameList.get(i));
				multipartFile.get(i).transferTo(dest);
			}
			
			result = true;
		}
		
		return result;
	}
	
	//전체 리스트
	@Override
	public List<ArtworkInfoVO> getArtworkInfoList() {
		return dao.selectArtworkInfoList();
	}
	
	//디테일 정보
	@Override
	public Map<String, Object> getArtworkInfo(String artworkInfoId) {
		Map<String, Object> map = new HashMap<>();
		
		//정보 가져오기
		map.put("artworkInfo", dao.selectArtworkInfo(artworkInfoId));
		
		//사진 가져오기
		return map;
	}
	
	//매각투표 
	@Transactional
	@Override
	public String startVote(VoteVO vote) {
		
		String result = "fail";
		//매각 투표 중으로 상태 변경
		int cnt = dao.updateArtworkInfoStateVote(vote.getArtworkInfoId());
		//투표 정보 insert
		cnt += dao.insertVoteInfo(vote);
		
		//member info 가져오기(해당 작품을 산 사람)
		List<MemberVO> memberList = dao.selectVoteMemberInfo(vote.getArtworkInfoId());
		
		vote.setType("1");
		if(cnt == 2) {
			memberList.forEach(member -> {
				String email = member.getEmail();
				String phone = member.getPhone();
				//AuthUtil.authEmail(vote, email);
				AuthUtil.authPhone(vote, phone);
			});
			result = "success";
		}
		
		
		return result;
	}
	
	//투표 정보 가져오기
	@Override
	public VoteVO getVoteInfo(String artworkInfoId) {
		return dao.selectVoteInfo(artworkInfoId);
	}
	
	//투표중(3) -> 투표종료(4) : 스케줄러
	@Override
	public int modifyStateVote() {
		String today = LocalDate.now().toString();
		return dao.updateStateVote(today);
	}
	
	//디테일 페이지 업무
	@Transactional
	@Override
	public String startGoodsDetailTast(VoteVO vote) {
		String result = "";
		switch (vote.getState()) {
		case "4": //투표 종료 -> 매각 기각 또는 매각 진행 
			
			if((vote.getTotalNo() - vote.getAgreeNo()) <= vote.getAgreeNo()) { //매각진행
				//상태 변경(매각 중으로)
				vote.setState("5");
				int cnt = dao.updateArtworkState(vote);
				
				//매각처, 매각 금액, 매각 update
				cnt += dao.updateSellInfo(vote);
				
				//문자 type
				vote.setType("2");
				//문자 보내기
				//member info 가져오기(해당 작품을 산 사람)
				List<MemberVO>  memberList = dao.selectVoteMemberInfo(vote.getArtworkInfoId());
				memberList.forEach(member -> {
					String email = member.getEmail();
					String phone = member.getPhone();
					//AuthUtil.authEmail(vote, email);
					AuthUtil.authPhone(vote, phone);
				});
				
				if(cnt == 2) {
					result = "1";
				}
				
			}else { //매각 기각
				vote.setType("3"); //문자 타입
				result = "2";
				
			}
			break;
		case "5": //수익분배 진행 (5->6)
			vote.setState("6");
			//상태 변경(수익분배)
			int cnt = dao.updateArtworkState(vote);
			
			//문자 type
			vote.setType("4");
			
			
			//sj_purchase_info에 insert(map에 list 넣기)
			List<PurchaseInfoVO> paramList = new ArrayList<>();
			//조각 산 사람들 list (몇개 샀는지)
			List<PurchaseInfoVO> purchaseList = dao.selectPurchaseListByArtworkInfoId(vote.getArtworkInfoId());
			purchaseList.forEach(purchase -> {
				PurchaseInfoVO vo = new PurchaseInfoVO();
				vo.setId("purchase" + dao.selectPurchaseInfoSeq());
				vo.setArtworkInfoId(vote.getArtworkInfoId());
				vo.setMemberId(purchase.getMemberId());
				vo.setPieceNo(-Integer.parseInt(purchase.getTotalPieceNo()));
				vo.setPieceAmt(String.format("%d" ,Integer.parseInt(vote.getSellPrice()) / Integer.parseInt(vote.getTargetPiece()))  );
				vo.setType("3"); //sj_purchase_info의 타입임
				paramList.add(vo);
			});
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("paramMap", paramList);
			dao.insertPurchaseInfoDisposal(paramMap);
			
			result ="3";
			
			//문자 보내기
			//member info 가져오기(해당 작품을 산 사람)
			List<MemberVO>  memberList2 = dao.selectDisposalSMSMemberInfo(vote.getArtworkInfoId());
			memberList2.forEach(member -> {
				String email = member.getEmail();
				String phone = member.getPhone();
				//AuthUtil.authEmail(vote, email);
				AuthUtil.authPhone(vote, phone);
			});
			break;
		
		case "6" : //수익분배 완료(매각완료) 6->7
			vote.setState("7");
			//상태 변경(매각완료)
			dao.updateArtworkState(vote);
			
			//문자 type
			vote.setType("5");
			//문자 보내기
			//member info 가져오기(해당 작품을 산 사람)
			List<MemberVO>  memberList3 = dao.selectDisposalSMSMemberInfo(vote.getArtworkInfoId());
			memberList3.forEach(member -> {
				String email = member.getEmail();
				String phone = member.getPhone();
				//AuthUtil.authEmail(vote, email);
				AuthUtil.authPhone(vote, phone);
			});
			
			result = "4";
			break;
		
		} //switch
		
		
		return result;
	}
	
	//로그분석
	//작품 당 클릭 수 그래프
	@Override
	public Map<String, Object> getGoodsClickGraph() throws Exception {
		Map<String, Object> map = new LogFileReader().getGoodsClickGraph();
		List<String> keyList = (List<String>) map.get("keyList");
		
		List<String> title = new ArrayList<>();
		
		keyList.forEach(key -> {
			title.add(dao.selectArtworkTitle(key)) ;
		});
		
		map.put("title", title);
		return map;
	}
	//로그인 시간 데이터
	@Override
	public LinkedHashMap<String, Integer> getloginTime() throws Exception {
		return new LogFileReader().getLoginTime();
	}
	//로그인 많이 한 회원
	@Override
	public List<MemberVO> geLoginTopMemberList() throws Exception {
		List<MemberVO> memberList = new ArrayList<>();
		Map<String, Object> map = new LogFileReader().getLoginTopMember();
		List<String> keySetList = (List<String>) map.get("keyList") ; 
		Map<String, Integer> frequency = (Map<String, Integer>) map.get("data") ; 
		
		if(keySetList.size() < 5) { //5개보다 적을 때
			for(int i = 0 ; i < keySetList.size() ; ++i) {
				MemberVO member = new MemberVO();
				member.setId(keySetList.get(i));
				member.setName(memberDao.selectMemberName(keySetList.get(i)));
				member.setFrequencyLogin(frequency.get(keySetList.get(i)));
				memberList.add(member);
			}
			
		}else { //5개보다 많을 때
			for(int i = 0; i < 5; ++i) {
				MemberVO member = new MemberVO();
				member.setId(keySetList.get(i));
				member.setName(memberDao.selectMemberName(keySetList.get(i)));
				member.setFrequencyLogin(frequency.get(keySetList.get(i)));
				memberList.add(member);
			}
		}
		
		return memberList;
	}
	//성별 수
	@Override
	public MemberVO getGenderNo() {
		return memberDao.selectGenderNo();
	}
	//공동구매 참여 or 미참여
	@Override
	public MemberVO getCobuyingParticipation() {
		return memberDao.selectCobuyingParticipation();
	}
}
