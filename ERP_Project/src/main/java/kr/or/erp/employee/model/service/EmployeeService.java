package kr.or.erp.employee.model.service;

import kr.or.erp.employee.model.vo.Employee;

public interface EmployeeService {


	Employee login(Employee e);

	int enrollPwd(Employee e);

	Employee info(Employee e);

}
