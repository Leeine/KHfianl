package kr.or.erp.employee.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.messenger.model.vo.Messenger;


@Repository
public class EmployeeDao {
	public Employee login(SqlSessionTemplate sqlSession, Employee e) {
		
		return sqlSession.selectOne("employeeMapper.login",e);
	}

	public int enrollPwd(SqlSessionTemplate sqlSession, Employee e) {

		return sqlSession.update("employeeMapper.enrollPwd",e);
	}

	public Employee info(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.selectOne("employeeMapper.info",e);
	}

	public ArrayList<Employee> approveList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("employeeMapper.approveList",e);
	}
	
	
	
	
	//메신저용 사원리스트 불러오기
	public ArrayList<Messenger> messengerEmpList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("employeeMapper.messengerEmpList",e);
	}

	public ArrayList<Messenger> messengerEmpSearchList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("employeeMapper.messengerEmpSearchList",e);
	}

}
