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
	
	
	
	
	
	//메신저용 사원리스트 불러오기
	@Override
	public ArrayList<Messenger> messengerEmpList(Employee e) {
		if(e.getEmpName()==null) {			
			return employeeDao.messengerEmpList(sqlSession,e);
		}else {
			return employeeDao.messengerEmpSearchList(sqlSession,e);
		}
	}

	@Override
	public ArrayList<Employee> approveList(Employee e) {
		
		return employeeDao.approveList(sqlSession, e);
	}

	@Override
	public Employee employeeDetail(Employee e) {
		
		return employeeDao.employeeDetail(sqlSession,e);
	}

	@Override
	public int employeeUpdate(Employee e) {
		
		return employeeDao.employeeUpdate(sqlSession, e);
	}

}
