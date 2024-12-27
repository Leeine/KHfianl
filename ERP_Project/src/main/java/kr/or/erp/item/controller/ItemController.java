package kr.or.erp.item.controller;

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
import kr.or.erp.item.model.service.ItemService;
import kr.or.erp.item.model.vo.Customer;


@Controller
@RequestMapping("/item")
public class ItemController {
	@Autowired
	ItemService itemService;

	//거래처 관리 페이지
	@GetMapping("/customer")
	public String customer() {	
		return "item/customer";
	}
	
	//거래처 리스트
	@ResponseBody
	@GetMapping(value="/customer/list", produces = "application/json;charset=UTF-8")
	public HashMap<String,Object> listCustomer(
			@RequestParam(value="currentPage", defaultValue ="1")
			String currentPage){
		
		HashMap<String,Object> resultMap = new HashMap<>();
		

		int searchCount = itemService.customerListCount();
		int pageLimit = 1;	
		int boardLimit = 25;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Customer> list = itemService.customerList(pi);

		resultMap.put("pi", pi);
		resultMap.put("result", list);
		return resultMap;
	}
	
	//거래처 검색
	@ResponseBody
	@GetMapping(value="/customer/search", produces = "application/json;charset=UTF-8")
	public HashMap<String,Object> searchCustomer(String keyword,
			@RequestParam(value="currentPage", defaultValue ="1") String currentPage){
		
		HashMap<String,Object> resultMap = new HashMap<>();

		int searchCount = itemService.searchCustomerListCount(keyword);
		int pageLimit = 1;	
		int boardLimit = 25;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Customer> searchList = itemService.searchCustomer(pi,keyword);

		resultMap.put("pi", pi);
		resultMap.put("result", searchList);
		return resultMap;
	}
	
	//거래처 추가
	@ResponseBody
	@GetMapping("/customer/insert")
	public String customerInsert(Customer customer) {
		int result = itemService.customerInsert(customer);
		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
	}
	//거래처 정보 수정
	@ResponseBody
	@GetMapping("/customer/update")
	public String customerUpdate(Customer customer) {
		int result = itemService.customerUpdate(customer);
		if(result>0) {
			return "NNNNY";
		}else{
			return "NNNNN";
		}
	}
	
	//===============================================================================================================================
	
	

	//재고 관리 페이지 이동
	@GetMapping("/stock")
	public String list() {
		
		return "item/stock";
	}
	
	//재고 확인
	@ResponseBody
	@GetMapping(value="/stock/list", produces = "application/json;charset=UTF-8")
	public HashMap<String,Object> itemList(
			@RequestParam(value="currentPage", defaultValue ="1")
			String currentPage){
		
		HashMap<String,Object> resultMap = new HashMap<>();
		

		int searchCount = itemService.stockListCount();
		int pageLimit = 1;	
		int boardLimit = 20;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Customer> searchList = itemService.stockList(pi);

		resultMap.put("pi", pi);
		resultMap.put("result", searchList);
		return resultMap;
	}
	
	
	
	
	
	
	
}
