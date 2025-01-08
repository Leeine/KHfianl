package kr.or.erp.attemdance.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

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
import kr.or.erp.attemdance.model.vo.CommuteOn;
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
	
	//gbrktn
	@ResponseBody
	@GetMapping("/userEmpCount")
	public int userEmpCount(int empNo) {
		
		int result = attService.userEmpCount(empNo);
		
		return result;
	}
	
	//사원 근태 목록 조회
	@ResponseBody
	@GetMapping("/empAttList")
	public ArrayList<EmpAttemdance> empAttList(@RequestParam(value="currentPage",defaultValue = "1")int currentPage
												,Model model){
		int listCount = attService.empAttListCount();
		int pageLimit = 5;
		int boardLimit = 20;
			
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<EmpAttemdance> list = attService.empAttList(pi);
		
		model.addAttribute(pi);
		
		return list;
	}
	
	//사원 근태 날짜 지정 조회
	@ResponseBody
	@GetMapping("/selectAttDate")
	public ArrayList<EmpAttemdance> selectAttDate(Model model
												, String inputDate1, String inputDate2
												, @RequestParam(value="currentPage",defaultValue = "1")int currentPage){
		
		if(inputDate1 == "") {
			inputDate1 = null;
		}
		if(inputDate2 == "") {
			inputDate2 = null;
		}
		
		int listCount = attService.empAttListCount();
		int pageLimit = 5;
		int boardLimit = 10;
				
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		HashMap<String, String> hashMap = new HashMap<>();
		hashMap.put("inputDate1", inputDate1);
		hashMap.put("inputDate2", inputDate2);
		
		ArrayList<EmpAttemdance> list = attService.selectAttDate(hashMap, pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("selectDate", hashMap);
		
		return list;
	}
	
	//사원근태 선택옵션 조회
	@ResponseBody
	@GetMapping("/attOptList")
	public ArrayList<Attemdance> empOptList(Model model){
		
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
	
	//사원 검색
	@ResponseBody
	@GetMapping("/empSearch")
	public ArrayList<Employee> empSearch(String keyword, String condition){
		
		HashMap<String, String> hashMap = new HashMap<>();
		hashMap.put("keyword", keyword);
		hashMap.put("condition", condition);
		
		ArrayList<Employee> list = (ArrayList)attService.empSearch(hashMap);
		
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
	public ArrayList<CommuteOn> comOnList(String daysc, @RequestParam(value="currentPage",defaultValue = "1")int currentPage, Model model) {
		
		int comListCount = attService.comListCount();
		int pageLimit = 5;
		int boardLimit = 25;
		
		PageInfo pi = Pagination.getPageInfo(comListCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<CommuteOn> list = (ArrayList)attService.comOnList(daysc, pi);
		
		model.addAttribute(pi);
		
		return list;
	}
	
	//목록 조건 조회
	@ResponseBody
	@GetMapping("/comSearchList")
	public ArrayList<CommuteOn> comSearchList(@RequestParam(value="currentPage",defaultValue = "1")int currentPage
											, String condition, String keyword
											, String inputDate1, String inputDate2
											, String daysc) {
		
		if(inputDate2 == "") {
			inputDate2 = null;
		}
		if(inputDate1 == ""){
			inputDate1 = null;
		}
		
		HashMap<String, String> hashMap = new HashMap<>();
		hashMap.put("condition", condition);
		hashMap.put("keyword", keyword);
		hashMap.put("inputDate1", inputDate1);
		hashMap.put("inputDate2", inputDate2);
		hashMap.put("daysc", daysc);
		
		int comListCount = attService.comListCount();
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(comListCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<CommuteOn> list = (ArrayList)attService.comSearchList(hashMap, pi);
		
		return list;
	}
	
	//유저 일주일 출근
	@ResponseBody
	@GetMapping("/empWeek")
	public ArrayList<CommuteOn> empWeek(int empNo) {
		
		ArrayList<CommuteOn> list = (ArrayList)attService.empWeek(empNo);
		
		return list;
	}
	
	//출퇴근 버튼
	@ResponseBody
	@GetMapping("/comInBtn")
	public String comInBtn(int empNo) {
		
		int result = attService.comInBtn(empNo);
		String str = "";
		
		if(result > 0) {
			str = "NNNNN";
		}else {
			str = "NNNNY";
		}
		
		return str;
	}
	//오늘 퇴근 체크
	@ResponseBody
	@GetMapping("/todayComCheck")
	public String todayComCheck(int empNo){
		String str = "";
		
		int result = attService.todayComCheck(empNo);
		
		if(result >0) {
			str = "NNNNN";
		}else {
			str = "NNNNY";
		}
		
		return str;
	}
	
	//출퇴근 기록
	@ResponseBody
	@PostMapping("/insertCom")
	public String insertCom(int empNo, String btnVal) {
		
		String str = "";
		
		int result = attService.insertCom(empNo, btnVal);
		
		if(result >0) {
			str = "NNNNY";
		}else {
			str = "NNNNN";
		}
		
		return str;
	}
	
	
}
