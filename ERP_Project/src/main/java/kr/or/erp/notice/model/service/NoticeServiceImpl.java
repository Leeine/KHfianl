package kr.or.erp.notice.model.service;

import java.util.ArrayList;

import org.apache.ibatis.transaction.TransactionException;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.vo.Search;
import kr.or.erp.notice.model.dao.NoticeDao;
import kr.or.erp.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeDao noticeDao;
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int noticeListCount() {
		return noticeDao.noticeListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> noticeList(PageInfo pi) {
		return noticeDao.noticeList(sqlSession, pi);
	}

	@Transactional(rollbackFor = {TransactionException.class})
	@Override
	public Notice noticeDetail(Notice n) {
		int increaseCount = noticeDao.increaseCount(sqlSession,n);
		if(increaseCount == 0) {
			throw new TransactionException();
		}
		Notice detail = noticeDao.noticeDetail(sqlSession,n);
		return detail;
	}

	@Override
	public ArrayList<Notice> index() {
		return noticeDao.index(sqlSession);
	}

	@Override
	public int insert(Notice n) {
		return noticeDao.insert(sqlSession,n);
	}

	@Override
	public int noticeSearchListCount(Search search) {
		return noticeDao.noticeSearchListCount(sqlSession,search);
	}

	@Override
	public ArrayList<Notice> noticeSearchList(PageInfo pi, Search search) {
		return noticeDao.noticeSearchList(sqlSession,pi,search);
	}

}
