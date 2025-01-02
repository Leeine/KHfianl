package kr.or.erp.item.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.vo.Category;
import kr.or.erp.item.model.vo.Customer;
import kr.or.erp.item.model.vo.Item;
import kr.or.erp.item.model.vo.Order;
import kr.or.erp.item.model.vo.OrderSearch;
import kr.or.erp.item.model.vo.OrderView;

@Repository
public class ItemDao {

	//----------거래처----------
	public int customerListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("itemMapper.customerListCount");
	}
	public ArrayList<Customer> customerList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.customerList",null,rowBounds);
	}
	public int searchCustomerListCount(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectOne("itemMapper.searchCustomerListCount",keyword);
	}
	public ArrayList<Customer> searchCustomerList(SqlSessionTemplate sqlSession, String keyword, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.searchCustomerList",keyword,rowBounds);
	}
	public int customerInsert(SqlSessionTemplate sqlSession, Customer customer) {
		return sqlSession.insert("itemMapper.customerInsert",customer);
	}
	public int customerUpdate(SqlSessionTemplate sqlSession, Customer customer) {
		return sqlSession.update("itemMapper.customerUpdate",customer);
	}


	//---------- 재고 ----------
	public int stockListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("itemMapper.stockListCount");
	}
	public ArrayList<Item> stockList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.stockList",null,rowBounds);
	}
	public ArrayList<Category> itemCategoryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("itemMapper.itemCategoryList");
	}
	public Item itemDetail(SqlSessionTemplate sqlSession, Item item) {
		return sqlSession.selectOne("itemMapper.itemDetail",item);
	}
	public ArrayList<Category> itemCategory(SqlSessionTemplate sqlSession, Item item) {
		return (ArrayList)sqlSession.selectList("itemMapper.itemCategory",item);
	}
	public int itemCategoryReset(SqlSessionTemplate sqlSession, Item item) {
		return sqlSession.delete("itemMapper.itemCategoryReset",item);
	}
	public int itemCategoryUpdate(SqlSessionTemplate sqlSession, ArrayList<Category> category) {
		return sqlSession.insert("itemMapper.itemCategoryUpdate",category);
	}
	public int itemUpdate(SqlSessionTemplate sqlSession, Item item) {
		return sqlSession.update("itemMapper.itemUpdate",item);
	}
	public int itemSearchListCount(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectOne("itemMapper.itemSearchListCount",keyword);
	}
	public ArrayList<Item> itemSearchList(SqlSessionTemplate sqlSession, PageInfo pi, String keyword) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.itemSearchList",keyword,rowBounds);
	}
	
	
	
	

	//---------- 발주 ----------
	public int orderListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("itemMapper.orderListCount");
	}
	public ArrayList<OrderView> orderList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.orderList",null,rowBounds);
	}
	public int orderSearchListCount(SqlSessionTemplate sqlSession, OrderSearch orderSearch) {
		return sqlSession.selectOne("itemMapper.orderSearchListCount", orderSearch);
	}
	public ArrayList<OrderView> orderSearchList(SqlSessionTemplate sqlSession, PageInfo pi, OrderSearch orderSearch) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.orderSearchList",orderSearch,rowBounds);
	}
	public int orderCustomerListCount(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectOne("itemMapper.orderCustomerListCount",keyword);
	}
	public ArrayList<Customer> orderCustomerList(SqlSessionTemplate sqlSession, String keyword) {
		return (ArrayList)sqlSession.selectList("itemMapper.orderCustomerList",keyword);
	}
	public ArrayList<Item> orderItemList(SqlSessionTemplate sqlSession, String keyword) {
		return (ArrayList)sqlSession.selectList("itemMapper.orderItemList",keyword);
	}
	public int orderInsert(SqlSessionTemplate sqlSession, ArrayList<Order> olist) {
		return sqlSession.insert("itemMapper.orderInsert", olist);
	}
	public int itemCountUpdate(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.update("itemMapper.itemCountUpdate",order);
	}
	
	
	
	
	
}
