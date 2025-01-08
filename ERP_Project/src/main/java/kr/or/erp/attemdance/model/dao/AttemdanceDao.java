package kr.or.erp.attemdance.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.attemdance.model.vo.Attemdance;
import kr.or.erp.attemdance.model.vo.CommuteOn;
import kr.or.erp.attemdance.model.vo.EmpAttemdance;
import kr.or.erp.attemdance.model.vo.PageInfo;
import kr.or.erp.employee.model.vo.Employee;

@Repository
public class AttemdanceDao {

	//분류 개수
	public int listCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("attMapper.listCount");
	}

	public ArrayList<Attemdance> selectAttList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("attMapper.selectAttList", null, rowBounds);
	}

	//추가
	public int attInsert(SqlSessionTemplate sqlSession, Attemdance att) {
		
		return sqlSession.insert("attMapper.attInsert", att);
	}
	
	//삭제
	public int attDelete(SqlSessionTemplate sqlSession, int attCode) {
		
		return sqlSession.delete("attMapper.attDelete", attCode);
	}

	//수정
	public int attUpdate(SqlSessionTemplate sqlSession, int attCode) {
		
		return sqlSession.update("attMapper.attUpdate", attCode);
	}
	public int attUpdate2(SqlSessionTemplate sqlSession, int attCode) {
		
		return sqlSession.update("attMapper.attUpdate2", attCode);
	}

	//사원----------------
	
	//사원 근태 수 조회
	public int empAttListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("attMapper.empAttListCount");
	}

	//사원 근태 리스트 조회
	public ArrayList<EmpAttemdance> empAttList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("attMapper.empAttList", null, rowBounds);
	}
	
	//사원 근태 날짜 지정 조회
	public ArrayList<EmpAttemdance> selectAttDate(SqlSessionTemplate sqlSession,HashMap<String, String> hashMap,  PageInfo pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("attMapper.selectAttDate", hashMap, rowBounds);
	}

	//근태옵션리스트
	public ArrayList<Attemdance> empOptList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("attMapper.empOptList");
	}

	//사원 리스트
	public ArrayList<Employee> empList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("attMapper.empList",null, rowBounds);
	}
	
	//사원 검색
	public ArrayList empSearch(SqlSessionTemplate sqlSession, HashMap<String, String> hashMap) {
		
		return (ArrayList)sqlSession.selectList("attMapper.empSearch", hashMap);
	}

	//사원 근태 추가
	public int empAttInsert(SqlSessionTemplate sqlSession, EmpAttemdance empAtt) {
		
		return sqlSession.insert("attMapper.empAttInsert",empAtt);
	}

	//삭제
	public int empAttDelete(SqlSessionTemplate sqlSession, EmpAttemdance empAtt) {
		
		return sqlSession.delete("attMapper.empAttDelete", empAtt);
	}

	//count -
	public int empAttCount(SqlSessionTemplate sqlSession, EmpAttemdance empAtt) {
		
		return sqlSession.update("attMapper.empAttCount", empAtt);
	}
	//count +
	public int empAttCount2(SqlSessionTemplate sqlSession, EmpAttemdance empAtt) {
		
		return sqlSession.update("attMapper.empAttCount2", empAtt);
	}
	
	//사원 근태 수정
	public int empAttUpdate(SqlSessionTemplate sqlSession, EmpAttemdance empAtt) {
		
		return sqlSession.update("attMapper.empAttUpdate", empAtt);
	}
	public int empAttUpdate2(SqlSessionTemplate sqlSession, EmpAttemdance empAtt) {
		
		return sqlSession.update("attMapper.empAttUpdate2", empAtt);
	}

	//출퇴근------------------
	
	//개수
	public int comListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("attMapper.comListCount");
	}

	public ArrayList<CommuteOn> comOnList(SqlSessionTemplate sqlSession, String daysc, PageInfo pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("attMapper.comOnList", daysc, rowBounds);
	}

	public ArrayList comSearchList(SqlSessionTemplate sqlSession, HashMap<String, String> hashMap, PageInfo pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("attMapper.comSearchList", hashMap, rowBounds);
	}

	//유저 일주일 출근
	public ArrayList empWeek(SqlSessionTemplate sqlSession, int empNo) {
		
		return (ArrayList)sqlSession.selectList("attMapper.empWeek", empNo);
	}

	//출퇴근 버튼
	public int comInBtn(SqlSessionTemplate sqlSession, int empNo) {
		
		return sqlSession.selectOne("attMapper.comInBtn", empNo);
	}
	//퇴근 체크
	public int todayComCheck(SqlSessionTemplate sqlSession, int empNo) {
		
		return sqlSession.selectOne("attMapper.todayComCheck", empNo);
	}
	
	//출근 기록
	public int insertComOn(SqlSessionTemplate sqlSession, int empNo) {
		
		return sqlSession.insert("attMapper.insertComOn", empNo);
	}
	//퇴근 기록
	public int insertComOff(SqlSessionTemplate sqlSession, int empNo) {
		
		return sqlSession.insert("attMapper.insertComOff", empNo);
	}

	public int userEmpCount(SqlSessionTemplate sqlSession, int empNo) {
		
		return sqlSession.selectOne("attMapper.userEmpCount", empNo);
	}

	

	
	

}
