package kr.or.erp.approve.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/approve")
public class appoveController {
		

	//거래처 관리 페이지
	@GetMapping("/insert")
	public String customer() {	
		return "approve/insert";
	}
	
	
}
