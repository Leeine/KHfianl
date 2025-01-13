package kr.or.erp.employee.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.common.template.Pagination;
import kr.or.erp.employee.model.service.EmployeeService;
import kr.or.erp.employee.model.vo.Appointment;
import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.Search;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 로그인 페이지 이동
	@GetMapping("/loginPage")
	public String loginPage() {

		return "common/loginPage";
	}

	// 로그인
	@PostMapping("/login")
	public ModelAndView login(@RequestParam(value = "inputId", defaultValue = "0") String inputId,
			@RequestParam(value = "inputPwd", defaultValue = "") String inputPwd,
			@RequestParam(value = "saveId", defaultValue = "off") String saveId, HttpSession session, ModelAndView mv,
			HttpServletResponse response) {
		// 아이디 저장 (쿠키)
		Cookie cookie;
		if (saveId.equals("on")) {
			cookie = new Cookie("empNo", inputId);

			cookie.setMaxAge(60 * 60 * 24); // 초 단위 표현(하루)

			response.addCookie(cookie);
		} else {
			cookie = new Cookie("empNo", null);
			cookie.setMaxAge(0);

			response.addCookie(cookie);
		}
		// 로그인 입력 정보 객체 생성
		Employee e = Employee.builder().empNo(Integer.parseInt(inputId)).build();
		Employee loginUser = employeeService.login(e);

		if (loginUser == null) {
			mv.setViewName("common/loginPage");
			session.setAttribute("alertMsg", "존재하지 않는 사원번호입니다.");

		} else {
			// 첫 로그인 확인(비밀번호 null)
			if (loginUser.getEmpPwd() == null) {
				mv.addObject("inputId", inputId);
				session.setAttribute("alertMsg", "비밀번호 설정 페이지로 이동합니다.");
				mv.setViewName("common/password");

			} else {
				if (bcryptPasswordEncoder.matches(inputPwd, loginUser.getEmpPwd())) {
					session.setAttribute("loginUser", loginUser);

					mv.setViewName("redirect:/");

				} else {
					mv.setViewName("common/loginPage");
					session.setAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");

				}
			}
		}
		return mv;
	}

	// 첫 로그인 비밀번호 설정
	@PostMapping("/enrollPwd")
	public String enrollPwd(String inputId, String inputPwd, HttpSession session) {

		String encPwd = bcryptPasswordEncoder.encode(inputPwd);

		Employee e = Employee.builder().empNo(Integer.parseInt(inputId)).empPwd(encPwd).build();

		int result = employeeService.enrollPwd(e);
		if (result > 0) {
			session.setAttribute("alertMsg", "비밀번호 등록 성공");
		} else {
			session.setAttribute("alertMsg", "비밀번호 등록 실패");
		}
		return "common/loginPage";

	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		return "redirect:/";
	}

	// 마이페이지 이동
	@GetMapping("/mypage")
	public String mypage() {
		return "employee/mypage";
	}

	@ResponseBody
	@GetMapping("/info")
	public Employee info(Employee e) {
		Employee empInfo = employeeService.info(e);
		return empInfo;
	}

	//
	@ResponseBody
	@GetMapping("/approve/list")
	public ArrayList<Employee> approvelist(Employee e) {

		ArrayList<Employee> approveList = employeeService.approveList(e);

		return approveList;
	}

	//사원 목록 페이지
	@GetMapping("/list/page")
	public String employeeListPage() {
		return "employee/employeeList";
	}

	@ResponseBody
	@GetMapping(value="/list", produces = "application/json;charset=UTF-8")
	public HashMap<String,Object> employeeList(
			@RequestParam(value="currentPage", defaultValue ="1")
			String currentPage){
		
		HashMap<String,Object> resultMap = new HashMap<>();
		

		int searchCount = employeeService.employeeListCount();
		int pageLimit = 1;	
		int boardLimit = 25;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Employee> list = employeeService.employeeList(pi);

		resultMap.put("pi", pi);
		resultMap.put("result", list);
		return resultMap;
	}
	@ResponseBody
	@GetMapping(value="/search", produces = "application/json;charset=UTF-8")
	public HashMap<String,Object> employeeSearchList(
			Search search,
			@RequestParam(value="currentPage", defaultValue ="1")
			String currentPage){
		
		HashMap<String,Object> resultMap = new HashMap<>();
		

		int searchCount = employeeService.employeeSearchListCount(search);
		int pageLimit = 1;	
		int boardLimit = 25;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Employee> list = employeeService.employeeSearchList(pi, search);

		resultMap.put("pi", pi);
		resultMap.put("result", list);
		return resultMap;
	}
	
	//인사발령 페이지 이동
	@GetMapping("/appointment/page")
	public String appointmentPage() {
		return "employee/appointmentList";
	}
	
	//부서 변경
	@ResponseBody
	@PostMapping(value="/appointment/dept")
	public String dept(Employee e, String data) {
		e.setDeptCode(data);
		int result = employeeService.updateDept(e);
		if(result > 0) {
			return "NNNNY";
		}else {
			return "NNNNN";
		}
	}
	//직급 변경
	@ResponseBody
	@PostMapping(value="/appointment/rank")
	public String rank(Employee e, String data) {
		e.setEmpRank(data);
		int result = employeeService.updateRank(e);
		if(result > 0) {
			return "NNNNY";
		}else {
			return "NNNNN";
		}
	}

	@ResponseBody
	@GetMapping("/appointment/typeList")
	public ArrayList<Appointment> appointmentTypeList() {

		ArrayList<Appointment> list = employeeService.appointmentTypeList();

		return list;
	}
	
	//사원추가
	@ResponseBody
	@PostMapping(value="/insert")
	public String insert(Employee e) {
		int result = employeeService.insertEmployee(e);
		if(result > 0) {
			return "NNNNY";
		}else {
			return "NNNNN";
		}
	}
	
	//인사발령 기록 추가
	@ResponseBody
	@PostMapping(value="/appointment/insert")
	public String insert(Appointment a) {
		int result = employeeService.insertAppointment(a);
		if(result > 0) {
			return "NNNNY";
		}else {
			return "NNNNN";
		}
	}
	
	@ResponseBody
	@GetMapping(value="/appointment/list", produces = "application/json; charset=UTF-8")
	public HashMap<String,Object> appointmentList(
			@RequestParam(value="currentPage", defaultValue ="1")
			String currentPage){
		
		HashMap<String,Object> resultMap = new HashMap<>();
		

		int searchCount = employeeService.appointmentListCount();
		int pageLimit = 1;	
		int boardLimit = 25;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Appointment> list = employeeService.appointmentList(pi);

		resultMap.put("pi", pi);
		resultMap.put("result", list);
		return resultMap;
	}

	@ResponseBody
	@GetMapping(value="/appointment/search", produces = "application/json; charset=UTF-8")
	public HashMap<String,Object> appointmentSearchList(
			Search search,
			@RequestParam(value="currentPage", defaultValue ="1")
			String currentPage){
		
		HashMap<String,Object> resultMap = new HashMap<>();
		

		int searchCount = employeeService.appointmentSearchListCount(search);
		int pageLimit = 1;	
		int boardLimit = 25;
		PageInfo pi = Pagination.getPageInfo(searchCount, Integer.parseInt(currentPage), pageLimit, boardLimit);

		ArrayList<Appointment> list = employeeService.appointmentsearchList(pi, search);

		resultMap.put("pi", pi);
		resultMap.put("result", list);
		return resultMap;
	}
}
