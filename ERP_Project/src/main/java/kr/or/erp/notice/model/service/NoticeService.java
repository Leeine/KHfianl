package kr.or.erp.notice.model.service;

import java.util.ArrayList;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.vo.Search;
import kr.or.erp.notice.model.vo.Notice;

public interface NoticeService {

	int noticeListCount();

	ArrayList<Notice> noticeList(PageInfo pi);

	Notice noticeDetail(Notice n);
	
	//메인페이지에 공지 목록 띄우기
	ArrayList<Notice> index();

	int insert(Notice n);

	int noticeSearchListCount(Search search);

	ArrayList<Notice> noticeSearchList(PageInfo pi, Search search);


}
