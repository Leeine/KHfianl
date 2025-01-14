package kr.or.erp.employee.model.service;

import java.util.ArrayList;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.employee.model.vo.Appointment;
import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.Search;

public interface EmployeeService {


	Employee login(Employee e);

	int enrollPwd(Employee e);

	Employee info(Employee e);

	ArrayList<Employee> approveList(Employee e);

	int employeeListCount();

	ArrayList<Employee> employeeList(PageInfo pi);

	int employeeSearchListCount(Search search);

	ArrayList<Employee> employeeSearchList(PageInfo pi, Search search);

	int updateDept(Employee e);

	int updateRank(Employee e);

	int insertEmployee(Employee e);

	int insertAppointment(Appointment a);

	ArrayList<Appointment> appointmentTypeList();

	int appointmentListCount();

	ArrayList<Appointment> appointmentList(PageInfo pi);

	int appointmentSearchListCount(Search search);

	ArrayList<Appointment> appointmentsearchList(PageInfo pi, Search search);


	
	

	Employee employeeDetail(Employee e);

	int employeeUpdate(Employee e);

}
