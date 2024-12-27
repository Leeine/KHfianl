package kr.or.erp.attemdance.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.erp.attemdance.model.dao.AttemdanceDao;
import kr.or.erp.attemdance.model.vo.Attemdance;
import kr.or.erp.attemdance.model.vo.EmpAttemdance;
import kr.or.erp.attemdance.model.vo.PageInfo;
import kr.or.erp.employee.model.vo.Employee;

@Service
public class AttemdanceServiceImpl implements AttemdanceService{

	@Autowired
	private AttemdanceDao attDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//세부 종류 개수
	@Override
	public int listCount() {
		
		return attDao.listCount(sqlSession);
	}

	//세부 목록 조회
	@Override
	public ArrayList<Attemdance> selectAttList(PageInfo pi) {
		
		return attDao.selectAttList(sqlSession, pi);
	}

	//근태 항목 등록
	@Override
	public int attInsert(Attemdance att) {
		
		return attDao.attInsert(sqlSession, att);
	}
	
	//근태 항목 수정
	@Override
	public int attUpdate(int attCode) {
		
		return attDao.attUpdate(sqlSession, attCode);
	}
	@Override
	public int attUpdate2(int attCode) {
		
		return attDao.attUpdate2(sqlSession, attCode);
	}

	//근태 항목 삭제
	@Override
	public int attDelete(int attCode) {
		
		return attDao.attDelete(sqlSession, attCode);
	}

	//사원 --------------------
	
	//사원 근태 리스트 개수
	@Override
	public int empAttListCount() {
		
		return attDao.empAttListCount(sqlSession);
	}
	
	//사원 근태 리스트 조회
	@Override
	public ArrayList<EmpAttemdance> empAttList(PageInfo pi){
		return attDao.empAttList(sqlSession, pi);
	}

	//사원 근태 조회
	@Override
	public EmpAttemdance selectEmpAtt(int empNo) {
		// TODO Auto-generated method stub
		return null;
	}

	//사원 근태 등록
	@Override
	public int empAttInsert(EmpAttemdance empAtt) {
		
		return attDao.empAttInsert(sqlSession, empAtt);
	}
	
	//근태 선택 옵션
	@Override
	public ArrayList<Attemdance> empOptList() {
		
		return attDao.empOptList(sqlSession);
	}

	//사원 리스트
	@Override
	public ArrayList<Employee> empList(PageInfo pi) {
		
		return attDao.empList(sqlSession, pi);
	}

	//삭제
	@Override
	public int empAttDelete(EmpAttemdance empAtt) {
		
		return attDao.empAttDelete(sqlSession, empAtt);
	}

	//count -
	@Override
	public int empAttCount(EmpAttemdance empAtt) {
		
		return attDao.empAttCount(sqlSession, empAtt);
	}
	//count +
	@Override
	public int empAttCount2(EmpAttemdance empAtt) {
		
		return attDao.empAttCount2(sqlSession, empAtt);
	}

	//사원 근태 수정
	@Override
	public int empAttUpdate(EmpAttemdance empAtt) {
		
		return attDao.empAttUpdate(sqlSession, empAtt);
	}
	@Override
	public int empAttUpdate2(EmpAttemdance empAtt) {
		
		return attDao.empAttUpdate2(sqlSession, empAtt);
	}

	

}
