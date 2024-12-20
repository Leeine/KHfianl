package kr.or.erp.employee.controller;

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
import kr.or.erp.employee.model.service.EmployeeService;
import kr.or.erp.employee.model.vo.Employee;


@Controller
@RequestMapping("/employee")
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//로그인 페이지 이동
	@GetMapping("/loginPage")
	public String loginPage() {
		
		return "common/loginPage";
	}
	
	//로그인
	@PostMapping("/login")
	public ModelAndView login(String inputId, 
						String inputPwd, 
						@RequestParam(value="saveId", defaultValue ="off")String saveId,
						HttpSession session,
						ModelAndView mv,
						HttpServletResponse response) {
		//아이디 저장 (쿠키)
		Cookie cookie;
		if(saveId.equals("on")) {
			cookie = new Cookie("empNo",inputId);
			
			cookie.setMaxAge(60*60*24); //초 단위 표현(하루)
			
			response.addCookie(cookie);
		}else {
			cookie = new Cookie("empNo",null);
			cookie.setMaxAge(0);
			
			response.addCookie(cookie);
		}
		//로그인 입력 정보 객체 생성
		Employee e = Employee.builder().empNo(Integer.parseInt(inputId)).build();
		Employee loginUser = employeeService.login(e);
		
		if(loginUser==null) {	
			mv.setViewName("common/loginPage");
			session.setAttribute("alertMsg", "존재하지 않는 사원번호입니다.");

		}else {
			//첫 로그인 확인(비밀번호 null)
			if(loginUser.getEmpPwd()==null) {
				mv.addObject("inputId", inputId);
				session.setAttribute("alertMsg", "비밀번호 설정 페이지로 이동합니다.");
				mv.setViewName("common/password");

			}else {
				if(bcryptPasswordEncoder.matches(inputPwd, loginUser.getEmpPwd())) {
					session.setAttribute("loginUser", loginUser);
					
					mv.setViewName("common/main");

				}else {
					mv.setViewName("common/loginPage");
					session.setAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");

				}
			}
		}
		return mv;
	}
	
	//첫 로그인 비밀번호 설정
	@PostMapping("/enrollPwd")
	public String enrollPwd(String inputId, 
							String inputPwd,
							HttpSession session) {

		String encPwd = bcryptPasswordEncoder.encode(inputPwd);
		
		Employee e = Employee.builder().empNo(Integer.parseInt(inputId)).empPwd(encPwd).build();
		
		int result = employeeService.enrollPwd(e);
		if(result>0) {
			session.setAttribute("alertMsg","비밀번호 등록 성공");
		}else {
			session.setAttribute("alertMsg","비밀번호 등록 실패");
		}
		return "common/loginPage";
		
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
}
