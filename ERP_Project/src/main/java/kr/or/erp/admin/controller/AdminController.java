package kr.or.erp.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.erp.admin.model.service.AdminService;
import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.CategoryList;
import kr.or.erp.item.model.vo.Item;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	@PostMapping("/page")
	public String adminNoticePage() {
		return "admin/admin";
	}
	
	@ResponseBody
	@GetMapping(value="/empRankList", produces = "application/json; charset=UTF-8")
	public ArrayList<Employee> empRankList(){
		ArrayList<Employee> list = adminService.empRankList();
		return list;
	}

	@ResponseBody
	@GetMapping(value="/deptList", produces = "application/json; charset=UTF-8")
	public ArrayList<Employee> deptList(){
		ArrayList<Employee> list = adminService.deptList();
		return list;
	}
	
	@ResponseBody
	@GetMapping(value="/empList", produces = "application/json; charset=UTF-8")
	public ArrayList<Employee> empList(){
		ArrayList<Employee> list = adminService.empList();
		return list;
	}

	@ResponseBody
	@PostMapping(value="/empInsert", produces = "text/html; charset=UTF-8")
	public String empInsert(Employee e){
		int result = adminService.empInsert(e);
		if(result > 0) {
			return "NNNNY";
		}else {
			return "NNNNN";
		}
	}
	
	
	@ResponseBody
	@GetMapping(value="/itemList", produces = "application/json; charset=UTF-8")
	public ArrayList<Item> itemList(){
		ArrayList<Item> list = adminService.itemList();
		return list;
	}

	@ResponseBody
	@PostMapping(value="/itemInsert", produces = "text/html; charset=UTF-8")
	public String itemInsert(Item i){
		int result = adminService.itemInsert(i);
		if(result > 0) {
			return "NNNNY";
		}else {
			return "NNNNN";
		}
	}

	@ResponseBody
	@GetMapping(value="/categoryList", produces = "application/json; charset=UTF-8")
	public ArrayList<CategoryList> categoryList(){
		ArrayList<CategoryList> list = adminService.categoryList();
		return list;
	}

	@ResponseBody
	@PostMapping(value="/categoryInsert", produces = "text/html; charset=UTF-8")
	public String categoryInsert(CategoryList c){
		int result = adminService.categoryInsert(c);
		if(result > 0) {
			return "NNNNY";
		}else {
			return "NNNNN";
		}
	}
}
