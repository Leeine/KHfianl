package kr.or.erp.employee.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.Search;


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

	
	
	
	
	//메신저용 사원리스트 불러오기
	public ArrayList<Employee> messengerEmpList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("employeeMapper.messengerEmpList",e);
	}

	public ArrayList<Employee> messengerEmpSearchList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("employeeMapper.messengerEmpSearchList",e);
	}

}
