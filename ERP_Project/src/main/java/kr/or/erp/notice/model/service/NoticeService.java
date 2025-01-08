package kr.or.erp.notice.model.service;

import java.util.ArrayList;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.notice.model.vo.Notice;

public interface NoticeService {

	int noticeListCount();

	ArrayList<Notice> noticeList(PageInfo pi);

	Notice noticeDetail(Notice n);
	
	//메인페이지 공지
	ArrayList<Notice> index();

	int insert(Notice n);


}
