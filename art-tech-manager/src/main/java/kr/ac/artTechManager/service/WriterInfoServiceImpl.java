package kr.ac.artTechManager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.artTechManager.dao.WriterInfoDAO;
import kr.ac.artTechManager.vo.WriterInfoVO;

@Service
public class WriterInfoServiceImpl implements WriterInfoService {
	@Autowired
	WriterInfoDAO dao;
	
	//작가 정보 추가
	@Override
	public int addWriterInfo(WriterInfoVO writerInfo) {
		return dao.insertWriterInfo(writerInfo);
	}
	
	//작가 리스트 전체
	@Override
	public List<WriterInfoVO> getWriterInfoList() {
		return dao.selectWriterInfoList();
	}
	
	//작가 디테일
	@Override
	public WriterInfoVO getWriterInfo(String id) {
		return dao.selectWriterInfo(id);
	}
}
