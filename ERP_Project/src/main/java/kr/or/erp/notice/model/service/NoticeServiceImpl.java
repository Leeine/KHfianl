package kr.or.erp.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.erp.common.model.vo.PageInfo;
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

	@Override
	public Notice noticeDetail(Notice n) {
		return noticeDao.noticeDetail(sqlSession,n);
	}

}
