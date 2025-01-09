package kr.or.erp.notice.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.common.template.Pagination;
import kr.or.erp.item.model.vo.Order;
import kr.or.erp.item.model.vo.Search;
import kr.or.erp.notice.model.service.NoticeService;
import kr.or.erp.notice.model.vo.Notice;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	NoticeService noticeService;
	
	//페이지 이동
	@GetMapping("/page")
	public String noticePage() {
		return "notice/list";
	}
	
	//공지 리스트 불러오기
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
	
	//공지 검색
	@ResponseBody
	@GetMapping(value="/search", produces = "application/json;charset=UTF-8")
	public HashMap<String,Object> orderSearchList(Search search,
			@RequestParam(value="currentPage", defaultValue ="1") String currentPage){
		HashMap<String,Object> resultMap = new HashMap<>();
		int searchCount = noticeService.noticeSearchListCount(search);
		int pageLimit = 1;	
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Notice> searchList = noticeService.noticeSearchList(pi,search);
		resultMap.put("pi", pi);
		resultMap.put("result", searchList);
		return resultMap;
	}
	
	//공지 상세보기
	@ResponseBody
	@GetMapping(value="/detail", produces = "application/json;charset=UTF-8")
	public Notice detail(Notice n){
		Notice detail = noticeService.noticeDetail(n); 
		return detail;
	}
	
	//공지 작성
	@ResponseBody
	@PostMapping(value="/insert", produces = "text/html;charset=UTF-8")
	public String insert(Notice n) {
		int result = noticeService.insert(n);

		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
	}

	//공지 삭제
	@ResponseBody
	@PostMapping(value="/delete", produces = "text/html;charset=UTF-8")
	public String delete(Notice n) {
		int result = noticeService.delete(n);

		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
	}
	

	//공지 수정
	@ResponseBody
	@PostMapping(value="/update", produces = "text/html;charset=UTF-8")
	public String update(Notice n) {
		int result = noticeService.update(n);

		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
	}
	
	
	
	
	
	
	
	
	
	
	//---------index 페이지----------
	//페이지 불러오기
	@GetMapping("/index")
	public String index() {
		return "common/indexNotice";
	}
	
	//리스트 불러오기
	@ResponseBody
	@GetMapping(value="/index/list", produces = "application/json;charset=UTF-8")
	public ArrayList<Notice> indexlist(){
		return noticeService.index();
	}
}
