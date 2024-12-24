package kr.or.erp.item.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.service.ItemService;


@Controller
@RequestMapping("/item")
public class ItemController {
	@Autowired
	ItemService itemService;

	//재고관리 페이지 이동
	@GetMapping("/managementPage")
	public String managementPage() {
		
		return "item/itemManagement";
	}
	
}
