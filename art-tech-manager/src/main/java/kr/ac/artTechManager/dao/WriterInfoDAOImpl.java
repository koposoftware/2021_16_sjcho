package kr.ac.artTechManager.dao;

import java.sql.SQLData;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.artTechManager.vo.WriterInfoVO;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class WriterInfoDAOImpl implements WriterInfoDAO {
	
	private final SqlSession sqlSession;
	
	//작가 정보 추가
	@Override
	public int insertWriterInfo(WriterInfoVO writerInfo) {
		return sqlSession.insert("kr.ac.kopo.manage.writerInfo.insertWriterInfo", writerInfo);
	}
	
	//작가 리스트
	@Override
	public List<WriterInfoVO> selectWriterInfoList() {
		return sqlSession.selectList("kr.ac.kopo.manage.writerInfo.selectWriterList");
	}
	
	//디테일
	@Override
	public WriterInfoVO selectWriterInfo(String id) {
		return sqlSession.selectOne("kr.ac.kopo.manage.writerInfo.selectWriterInfo", id);
	}
}
