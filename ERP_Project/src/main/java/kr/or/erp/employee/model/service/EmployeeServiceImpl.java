package kr.or.erp.employee.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.erp.employee.model.dao.EmployeeDao;
import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.messenger.model.vo.Messenger;

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

}
