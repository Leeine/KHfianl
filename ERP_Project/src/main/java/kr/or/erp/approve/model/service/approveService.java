package kr.or.erp.approve.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.erp.approve.model.vo.Approve;
import kr.or.erp.approve.model.vo.Document;

@Service
public interface approveService {
	

	ArrayList<Document> selectDocumentList();

	Document typeContent(Document doc);

	int insertDocument(Approve a);

	ArrayList<Document> docList();

	Approve typeDocument(Approve ap);
	
	

	
}
