package kr.or.erp.notice.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.common.template.Pagination;
import kr.or.erp.notice.model.service.NoticeService;
import kr.or.erp.notice.model.vo.Notice;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/page")
	public String noticePage() {
		return "notice/list";
	}
	
	
	@ResponseBody
	@GetMapping(value="/list", produces = "application/json;charset=UTF-8")
	public HashMap<String,Object> list(
			@RequestParam(value="currentPage", defaultValue ="1")
			String currentPage){
		
		HashMap<String,Object> resultMap = new HashMap<>();
		

		int searchCount = noticeService.noticeListCount();
		int pageLimit = 1;	
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Notice> list = noticeService.noticeList(pi);

		resultMap.put("pi", pi);
		resultMap.put("result", list);
		return resultMap;
	}
	
	@ResponseBody
	@GetMapping(value="/detail", produces = "application/json;charset=UTF-8")
	public Notice detail(Notice n){
		Notice detail = noticeService.noticeDetail(n); 
		return detail;
	}
}
