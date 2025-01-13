package kr.or.erp.employee.model.service;

import java.util.ArrayList;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.messenger.model.vo.Messenger;

public interface EmployeeService {


	Employee login(Employee e);

	int enrollPwd(Employee e);

	Employee info(Employee e);

	ArrayList<Employee> approveList(Employee e);

	
	

}
