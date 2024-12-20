package kr.or.erp.attemdance.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.attemdance.model.vo.Attemdance;
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

	public int attInsert(SqlSessionTemplate sqlSession, Attemdance att) {
		
		return sqlSession.insert("attMapper.attInsert", att);
	}

	public int attDelete(SqlSessionTemplate sqlSession, int attCode) {
		
		return sqlSession.delete("attMapper.attDelete", attCode);
	}

}
