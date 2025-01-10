package kr.or.erp.employee.model.service;

import java.util.ArrayList;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.Search;

public interface EmployeeService {


	Employee login(Employee e);

	int enrollPwd(Employee e);

	Employee info(Employee e);

	ArrayList<Employee> approveList(Employee e);

	
	
	//메신저용 사원리스트 불러오기
	ArrayList<Employee> messengerEmpList(Employee e);

}
