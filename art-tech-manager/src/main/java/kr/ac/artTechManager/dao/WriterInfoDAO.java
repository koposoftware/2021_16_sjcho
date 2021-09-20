package kr.ac.artTechManager.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.ac.artTechManager.vo.WriterInfoVO;

@Repository
public interface WriterInfoDAO {
	public int insertWriterInfo(WriterInfoVO writerInfo); //작가 정보 추가
	public List<WriterInfoVO> selectWriterInfoList(); //작가 리스트
	public WriterInfoVO selectWriterInfo(String id); //작가 디테일
	
}
