package kr.or.erp.attemdance.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.erp.attemdance.model.dao.AttemdanceDao;
import kr.or.erp.attemdance.model.vo.Attemdance;
import kr.or.erp.attemdance.model.vo.EmpAttemdance;
import kr.or.erp.attemdance.model.vo.PageInfo;

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
	public int insertEmpATt(EmpAttemdance empAtt) {
		// TODO Auto-generated method stub
		return 0;
	}

}
