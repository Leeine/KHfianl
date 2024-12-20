package kr.or.erp.employee.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.employee.model.vo.Employee;


@Repository
public class EmployeeDao {
	public Employee login(SqlSessionTemplate sqlSession, Employee e) {
		
		return sqlSession.selectOne("employeeMapper.login",e);
	}

	public int enrollPwd(SqlSessionTemplate sqlSession, Employee e) {

		return sqlSession.update("employeeMapper.enrollPwd",e);
	}
}
