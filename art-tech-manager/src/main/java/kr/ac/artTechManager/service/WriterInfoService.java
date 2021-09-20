package kr.ac.artTechManager.service;

import java.util.List;

import kr.ac.artTechManager.vo.WriterInfoVO;

public interface WriterInfoService {
	public int addWriterInfo(WriterInfoVO writerInfo); //작가 정보 추가
	public List<WriterInfoVO> getWriterInfoList(); //작가 리스트
	public WriterInfoVO getWriterInfo(String id); //작가 디테일
}
