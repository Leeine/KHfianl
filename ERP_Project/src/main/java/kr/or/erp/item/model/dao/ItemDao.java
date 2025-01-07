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
import kr.or.erp.item.model.vo.Release;
import kr.or.erp.item.model.vo.Search;
import kr.or.erp.item.model.vo.Sell;

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
	public ArrayList<Order> orderList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.orderList",null,rowBounds);
	}
	public int orderSearchListCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("itemMapper.orderSearchListCount", search);
	}
	public ArrayList<Order> orderSearchList(SqlSessionTemplate sqlSession, PageInfo pi, Search search) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.orderSearchList",search,rowBounds);
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
	public int itemCountOrderUpdate(SqlSessionTemplate sqlSession, Order order) {
		return sqlSession.update("itemMapper.itemCountOrderUpdate",order);
	}
	
	
	
	//---------- 판매 ----------
	public int sellListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("itemMapper.sellListCount");
	}
	public ArrayList<Sell> sellList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.sellList",null,rowBounds);
	}
	public int sellSearchListCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("itemMapper.sellSearchListCount",search);
	}
	public ArrayList<Sell> sellSearchList(SqlSessionTemplate sqlSession, PageInfo pi, Search search) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.sellSearchList",search,rowBounds);
	}
	public int sellInsert(SqlSessionTemplate sqlSession, ArrayList<Sell> slist) {
		return sqlSession.insert("itemMapper.sellInsert",slist);
	}
	public int itemCountSellUpdate(SqlSessionTemplate sqlSession, Sell sell) {
		return sqlSession.update("itemMapper.itemCountSellUpdate",sell);
	}
	public int itemStockCount(SqlSessionTemplate sqlSession, Sell sell) {
		return sqlSession.selectOne("itemMapper.itemStockCount",sell);
	}
	public int sellReleaseStatusUpdate(SqlSessionTemplate sqlSession, Sell sell) {
		return sqlSession.update("itemMapper.sellReleaseStatusUpdate",sell);
	}
	public int sellInsertRelease(SqlSessionTemplate sqlSession, Sell sell) {
		return sqlSession.insert("itemMapper.sellInsertRelease",sell);
	}

	
	
	//---------- 출하 ----------
	public int releaseListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("itemMapper.releaseListCount");
	}
	public ArrayList<Release> releaseList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.releaseList",null,rowBounds);
	}
	public int releaseSearchListCount(SqlSessionTemplate sqlSession, Search search) {
		return sqlSession.selectOne("itemMapper.releaseSearchListCount",search);
	}
	public ArrayList<Release> releaseSearchList(SqlSessionTemplate sqlSession, PageInfo pi, Search search) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("itemMapper.releaseSearchList",search,rowBounds);
	}
	
}
