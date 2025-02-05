package kr.or.erp.employee.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.employee.model.vo.Appointment;
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

	public ArrayList<Employee> approveList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("employeeMapper.approveList",e);
	}

	public int employeeListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("employeeMapper.employeeListCount");
	}

	public ArrayList<Employee> employeeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return  (ArrayList)sqlSession.selectList("employeeMapper.employeeList",null,rowBounds);
	}

	public Employee employeeDetail(SqlSessionTemplate sqlSession, Employee e) {
		
		return sqlSession.selectOne("employeeMapper.employeeDetail",e);
	}

	public int employeeUpdate(SqlSessionTemplate sqlSession, Employee e) {
		
		return sqlSession.update("employeeMapper.employeeUpdate",e);
	}
	public int employeeSearchListCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("employeeMapper.employeeSearchListCount");
	}

	public ArrayList<Employee> employeeSearchList(SqlSessionTemplate sqlSession, PageInfo pi, Search search) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return  (ArrayList)sqlSession.selectList("employeeMapper.employeeSearchList",search,rowBounds);
	}

	public int updateDept(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.update("employeeMapper.updateDept",e);
	}

	public int updateRank(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.update("employeeMapper.updateRank",e);
	}

	public int insertEmployee(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.insert("employeeMapper.insertEmployee",e);
	}

	public int insertAppointment(SqlSessionTemplate sqlSession, Appointment a) {
		return sqlSession.insert("employeeMapper.insertAppointment",a);
	}

	public ArrayList<Appointment> appointmentTypeList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("employeeMapper.appointmentTypeList");
	}

	public int appointmentListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("employeeMapper.appointmentListCount");
	}
	
	public ArrayList<Appointment> appointmentList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("employeeMapper.appointmentList",null,rowBounds);
	}

	public int appointmentSearchListCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("employeeMapper.appointmentSearchListCount");
	}

	public ArrayList<Appointment> appointmentSearchList(SqlSessionTemplate sqlSession, PageInfo pi, Search search) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("employeeMapper.appointmentSearchList",search,rowBounds);
	}

	
	
	
	

}
