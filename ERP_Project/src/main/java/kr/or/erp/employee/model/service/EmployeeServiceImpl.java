package kr.or.erp.employee.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.employee.model.dao.EmployeeDao;
import kr.or.erp.employee.model.vo.Appointment;
import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.Search;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	@Autowired
	private EmployeeDao employeeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Employee login(Employee e) {
		Employee loginUser = employeeDao.login(sqlSession, e);
		return loginUser;
	}

	@Override
	public int enrollPwd(Employee e) {
		return employeeDao.enrollPwd(sqlSession, e);
	}

	@Override
	public Employee info(Employee e) {
		return employeeDao.info(sqlSession, e);
	}
	
	

	@Override
	public ArrayList<Employee> approveList(Employee e) {
		
		return employeeDao.approveList(sqlSession, e);
	}
	
	

	@Override
	public int employeeListCount() {
		return employeeDao.employeeListCount(sqlSession);
	}

	@Override
	public ArrayList<Employee> employeeList(PageInfo pi) {
		return employeeDao.employeeList(sqlSession, pi);
	}

	@Override
	public int employeeSearchListCount(Search search) {
		return employeeDao.employeeSearchListCount(sqlSession, search);
	}

	@Override
	public ArrayList<Employee> employeeSearchList(PageInfo pi, Search search) {
		return employeeDao.employeeSearchList(sqlSession, pi, search);
	}

	@Override
	@Transactional
	public int updateDept(Employee e) {
		Appointment a = Appointment.builder()
									.empNo(e.getEmpNo())
									.appointmentTypeCode(3)
									.newDept(e.getDeptCode())
									.newRank(e.getEmpRank())
									.build();
		int insert = employeeDao.insertAppointment(sqlSession, a);
		int update = employeeDao.updateDept(sqlSession, e);
		return insert * update;
	}

	@Override
	@Transactional
	public int updateRank(Employee e) {
		Appointment a = Appointment.builder()
									.empNo(e.getEmpNo())
									.appointmentTypeCode(2)
									.newRank(e.getEmpRank())
									.newDept(e.getDeptCode())
									.build();
		int insert = employeeDao.insertAppointment(sqlSession, a);
		int update =  employeeDao.updateRank(sqlSession, e);
		return insert * update;
	}
	
	@Override
	public ArrayList<Appointment> appointmentTypeList() {
		return employeeDao.appointmentTypeList(sqlSession);
	}

	@Override
	@Transactional
	public int insertEmployee(Employee e) {
		Appointment a = Appointment.builder()
									.appointmentTypeCode(1)
									.newRank(e.getEmpRank())
									.newDept(e.getDeptCode())
									.build();
		int result = employeeDao.insertEmployee(sqlSession, e);
		int insert = employeeDao.insertAppointment(sqlSession, a);
		return insert*result;
	}

	@Override
	public int insertAppointment(Appointment a) {
		return employeeDao.insertAppointment(sqlSession, a);
	}

	@Override
	public int appointmentListCount() {
		return employeeDao.appointmentListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Appointment> appointmentList(PageInfo pi) {
		return employeeDao.appointmentList(sqlSession, pi);
	}

	@Override
	public int appointmentSearchListCount(Search search) {
		return employeeDao.appointmentSearchListCount(sqlSession, search);
	}

	@Override
	public ArrayList<Appointment> appointmentsearchList(PageInfo pi, Search search) {
		return employeeDao.appointmentSearchList(sqlSession, pi, search);
	}




}
