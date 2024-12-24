package kr.or.erp.attemdance.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.attemdance.model.vo.Attemdance;
import kr.or.erp.attemdance.model.vo.EmpAttemdance;
import kr.or.erp.attemdance.model.vo.PageInfo;

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

	public ArrayList<EmpAttemdance> empAttList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("attMapper.empAttList", null, rowBounds);
	}
	
	//사원 근태 리스트 조회

}
