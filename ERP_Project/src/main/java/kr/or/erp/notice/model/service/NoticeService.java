package kr.or.erp.notice.model.service;

import java.util.ArrayList;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.notice.model.vo.Notice;

public interface NoticeService {

	int noticeListCount();

	ArrayList<Notice> noticeList(PageInfo pi);

	Notice noticeDetail(Notice n);


}
