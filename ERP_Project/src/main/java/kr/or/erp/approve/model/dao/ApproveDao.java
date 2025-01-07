package kr.or.erp.approve.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.approve.model.vo.Document;


@Repository
public class ApproveDao {

	public ArrayList<Document> selectDocumentList(SqlSessionTemplate sqlSession) {
	
		
		return (ArrayList)sqlSession.selectList("approveMapper.selectDocumentList");
	}

}
