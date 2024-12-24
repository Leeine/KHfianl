package kr.or.erp.item.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.vo.Customer;

@Repository
public class ItemDao {

	public int searchCustomerListCount(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectOne("itemMapper.searchCustomerListCount",keyword);
	}

	public ArrayList<Customer> searchCustomerList(SqlSessionTemplate sqlSession, String keyword, PageInfo pi) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.searchCustomerList",keyword,rowBounds);
	}

}
