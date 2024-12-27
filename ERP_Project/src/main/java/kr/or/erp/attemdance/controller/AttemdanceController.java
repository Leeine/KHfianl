package kr.or.erp.attemdance.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import kr.or.erp.attemdance.model.service.AttemdanceService;
import kr.or.erp.attemdance.model.template.Pagination;
import kr.or.erp.attemdance.model.vo.Attemdance;
import kr.or.erp.attemdance.model.vo.EmpAttemdance;
import kr.or.erp.attemdance.model.vo.PageInfo;
import kr.or.erp.employee.model.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/att")
public class AttemdanceController {

	@Autowired
	private AttemdanceService attService;
	
	//근태 항목 페이지로 이동
	@GetMapping("/attListPage")
	public String attListPage(){
		
		return "/attemdance/attemdance";
	}
	
	//근태 항목 조회
	@ResponseBody
	@GetMapping("/attList")
	public ArrayList<Attemdance> attList(@RequestParam(value="currentPage",defaultValue = "1")int currentPage, Model model){
		
		int listCount = attService.listCount();
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Attemdance> list = attService.selectAttList(pi);
		
		return list;
	} 
	
	//근태 항목 추가
	@ResponseBody
	@PostMapping("/attInsert")
	public String attInsert(Attemdance att) {
		
		int result = attService.attInsert(att);
		
		String resultStr = "";
		
		if(result >0) {
			resultStr = "NNNNY";
		}else {
			resultStr = "NNNNN";
		}

		return resultStr;
	}
	
	//근태 항목 수정
	@ResponseBody
	@GetMapping("/attUpdate")
	public String attUpdate(@RequestParam("attCode") int attCode) {
		
		int result = attService.attUpdate(attCode);
		
		String resultStr = "";
		
		if(result >0) {
			resultStr = "NNNNY";
		}else {
			resultStr = "NNNNN";
		}
		
		return resultStr;
	}
	@ResponseBody
	@GetMapping("/attUpdate2")
	public String attUpdate2(@RequestParam("attCode") int attCode) {
		
		int result = attService.attUpdate2(attCode);
		
		String resultStr = "";
		
		if(result >0) {
			resultStr = "NNNNY";
		}else {
			resultStr = "NNNNN";
		}
		
		return resultStr;
	}
	
	//근태 항목 삭제
	@ResponseBody
	@GetMapping("/attDelete")
	public String attDelete(@RequestParam("attCode") int attCode) {
		
		int result = attService.attDelete(attCode);
		
		String resultStr = "";
		
		if(result >0) {
			resultStr = "NNNNY";
		}else {
			resultStr = "NNNNN";
		}
		
		return resultStr;
	}
	
	//사원 ------------------------
	
	//사원 근태 조회 페이지로 이동
	@GetMapping("/empAttListPage")
	public String empAttListPage() {
		
		return "/attemdance/empAttemdance";
	}
	
	//사원 근태 목록 조회
	@ResponseBody
	@GetMapping("/empAttList")
	public ArrayList<EmpAttemdance> empAttList(@RequestParam(value="currentPage",defaultValue = "1")int currentPage){
		int listCount = attService.empAttListCount();
		int pageLimit = 5;
		int boardLimit = 10;
			
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
		ArrayList<EmpAttemdance> list = attService.empAttList(pi);
			
		return list;
	}
	
	//사원근태 선택옵션 조회
	@ResponseBody
	@GetMapping("/attOptList")
	public ArrayList<Attemdance> empOptList(){
		
		ArrayList<Attemdance> list = attService.empOptList();
		
		return list;
	}
	
	//사원 리스트
	@ResponseBody
	@GetMapping("/empList")
	public ArrayList<Employee> empList(@RequestParam(value="currentPage",defaultValue = "1")int currentPage){
		
		int listCount = attService.empAttListCount();
		int pageLimit = 5;
		int boardLimit = 10;
			
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
		ArrayList<Employee> list = attService.empList(pi);
			
		return list;
	}
	
	//사원 근태 등록
	@PostMapping("/empAttInsert")
	public String empAttInsert(EmpAttemdance empAtt, HttpSession session) {
		
		
		int result = attService.empAttInsert(empAtt);
		
		if(result >0) {
			session.setAttribute("alertMsg","등록 성공");
		}else {
			session.setAttribute("alertMsg","등록 실패");
		}
		
		
		return "redirect:/att/empAttListPage";
	}
	
	//사원 근태 삭제
	@ResponseBody
	@PostMapping("/empAttDelete")
	public String empAttDelete(EmpAttemdance empAtt) {
		
		int result = attService.empAttDelete(empAtt);
		
		String str = "";
		
		if(result >0) {
			str = "NNNNY";
		}else {
			str = "NNNNN";
		}
		
		return str;
	}
	
	//사원 근태 확인
	@ResponseBody
	@PostMapping("/empAttUpdate")
	public String empAttUpdate(EmpAttemdance empAtt) {
		
		int result1 = attService.empAttCount(empAtt);
		
		String str = "";
		
		if(result1 > 0) {
			int result = attService.empAttUpdate(empAtt);
			
			if(result >0) {
				str = "NNNNY";
			}else {
				str = "NNNNN";
			}
		}else {
			str = "NNNNN";
		}
		
		return str;
	}
	
	@ResponseBody
	@PostMapping("/empAttUpdate2")
	public String empAttUpdate2(EmpAttemdance empAtt) {
		
		int result1 = attService.empAttCount2(empAtt);
		
		String str = "";
		
		if(result1 >0) {
			int result = attService.empAttUpdate2(empAtt);
			
			if(result >0) {
				str = "NNNNY";
			}else {
				str = "NNNNN";
			}
		}else {
			str = "NNNNN";
		}
		
		return str;
	}
	
	//출퇴근------------------------
	
	//페이지 이동
	@GetMapping("/comPage")
	public String comPage() {
		
		return "/attemdance/commute";
	}
	
	//목록 조회
	@ResponseBody
	@GetMapping("/comList")
	public String comList() {
		
		int comListCount = attService.comListCount();
		
		return "";
	}
	
}
