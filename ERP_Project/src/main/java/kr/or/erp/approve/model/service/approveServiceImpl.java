package kr.or.erp.approve.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.erp.approve.model.dao.ApproveDao;
import kr.or.erp.approve.model.vo.Approve;
import kr.or.erp.approve.model.vo.Document;

@Service
public class approveServiceImpl implements approveService{

	@Autowired
	ApproveDao approveDao;
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Document> selectDocumentList() {
		
		return approveDao.selectDocumentList(sqlSession);

	}

	@Override
	public Document typeContent(Document doc) {
		
		
		return approveDao.typeContent(sqlSession, doc);
	}

	@Override
	public int insertDocument(Approve a) {
		
		return approveDao.insertDocument(sqlSession, a);
	}

	@Override
	public ArrayList<Document> docList() {
		
		return approveDao.docList(sqlSession);
	}

	@Override
	public Approve typeDocument(Approve ap) {
		
		return approveDao.typeDocument(sqlSession, ap);
	}

	@Override
	public int updateStatus(Approve a) {
		
		return approveDao.updateStatus(sqlSession, a);
	}

	@Override
	public int refuseStatus(Approve a) {

		return approveDao.refuseStatus(sqlSession, a);
	}

	@Override
	public int waitStatus(Approve a) {
		
		return approveDao.waitStatus(sqlSession, a);
	}

}
