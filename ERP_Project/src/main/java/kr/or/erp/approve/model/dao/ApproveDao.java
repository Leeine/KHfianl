package kr.or.erp.approve.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.approve.model.vo.Approve;
import kr.or.erp.approve.model.vo.Document;


@Repository
public class ApproveDao {

	public ArrayList<Document> selectDocumentList(SqlSessionTemplate sqlSession) {
	
		
		return (ArrayList)sqlSession.selectList("approveMapper.selectDocumentList");
	}

	public Document typeContent(SqlSessionTemplate sqlSession, Document doc) {
		
		
		return sqlSession.selectOne("approveMapper.typeContent",doc);
	}

	public int insertDocument(SqlSessionTemplate sqlSession, Approve a) {
		
		return sqlSession.insert("approveMapper.insertDocument",a);
	}

	public ArrayList<Document> docList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("approveMapper.docList");
	}

	public Approve typeDocument(SqlSessionTemplate sqlSession, Approve ap) {
		
		return sqlSession.selectOne("approveMapper.typeDocument", ap);
	}

	public int updateStatus(SqlSessionTemplate sqlSession, Approve a) {
		
		return sqlSession.update("approveMapper.updateStatus", a);
	}

	public int refuseStatus(SqlSessionTemplate sqlSession, Approve a) {
		
		return sqlSession.update("approveMapper.refuseStatus", a);
	}

	public int waitStatus(SqlSessionTemplate sqlSession, Approve a) {
		
		return sqlSession.update("approveMapper.waitStatus", a);
	}

}
