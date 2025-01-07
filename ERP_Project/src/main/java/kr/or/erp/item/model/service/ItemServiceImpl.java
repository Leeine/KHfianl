package kr.or.erp.item.model.service;

import java.util.ArrayList;

import org.apache.ibatis.transaction.TransactionException;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.dao.ItemDao;
import kr.or.erp.item.model.vo.Category;
import kr.or.erp.item.model.vo.Customer;
import kr.or.erp.item.model.vo.Item;
import kr.or.erp.item.model.vo.Order;
import kr.or.erp.item.model.vo.Release;
import kr.or.erp.item.model.vo.Search;
import kr.or.erp.item.model.vo.Sell;

@Service
public class ItemServiceImpl implements ItemService {
	@Autowired
	ItemDao itemDao;
	
	@Autowired
	SqlSessionTemplate sqlSession;

	//----------거래처----------
	@Override
	public int searchCustomerListCount(String keyword) {
		return itemDao.searchCustomerListCount(sqlSession,keyword);
	}
	@Override
	public ArrayList<Customer> searchCustomer(PageInfo pi, String keyword) {
		return itemDao.searchCustomerList(sqlSession,keyword,pi);
	}
	@Override
	public int customerListCount() {
		return itemDao.customerListCount(sqlSession);
	}
	@Override
	public ArrayList<Customer> customerList(PageInfo pi) {
		return itemDao.customerList(sqlSession,pi);
	}
	@Override
	public int customerInsert(Customer customer) {
		return itemDao.customerInsert(sqlSession,customer);
	}
	@Override
	public int customerUpdate(Customer customer) {
		return itemDao.customerUpdate(sqlSession,customer);
	}

	

	//---------- 재고 ----------
	@Override
	public int stockListCount() {
		return itemDao.stockListCount(sqlSession);
	}
	@Override
	public ArrayList<Item> stockList(PageInfo pi) {
		return itemDao.stockList(sqlSession,pi);
	}
	@Override
	public ArrayList<Category> itemCategoryList() {
		return itemDao.itemCategoryList(sqlSession);
	}
	@Override
	public Item itemDetail(Item item) {
		return itemDao.itemDetail(sqlSession, item);
	}
	@Override
	public ArrayList<Category> itemCategory(Item item) {
		return itemDao.itemCategory(sqlSession, item);
	}
	
	//제품 정보 수정 트랜잭션(카테고리 정보가 없을경우 카테고리 초기화만 진행 후 제품 정보 업데이트)
	@Transactional
	@Override
	public int itemUpdate(Item item, ArrayList<Category> category) {
		itemDao.itemCategoryReset(sqlSession,item);
		int cResult = 1;
		if(category.size()!=0) {
			cResult =  itemDao.itemCategoryUpdate(sqlSession,category);
		}
		int iResult = itemDao.itemUpdate(sqlSession,item);
		
		return cResult*iResult;
	}
	@Override
	public int itemSearchListCount(String keyword) {
		return itemDao.itemSearchListCount(sqlSession, keyword);
	}
	@Override
	public ArrayList<Item> itemSearchList(PageInfo pi, String keyword) {
		return itemDao.itemSearchList(sqlSession, pi, keyword);
	}
	
	
	
	//---------- 발주 ----------
	@Override
	public int orderListCount() {
		return itemDao.orderListCount(sqlSession);
	}
	@Override
	public ArrayList<Order> orderList(PageInfo pi) {
		return itemDao.orderList(sqlSession, pi);
	}
	@Override
	public int orderSearchListCount(Search search) {
		return itemDao.orderSearchListCount(sqlSession, search);
	}
	@Override
	public ArrayList<Order> orderSearchList(PageInfo pi, Search search) {
		return itemDao.orderSearchList(sqlSession, pi, search);
	}
	@Override
	public ArrayList<Customer> orderCustomerList(String keyword) {
		return itemDao.orderCustomerList(sqlSession, keyword);
	}
	@Override
	public ArrayList<Item> orderItemList(String keyword) {
		return itemDao.orderItemList(sqlSession, keyword);
	}
	@Transactional(rollbackFor= {TransactionException.class})
	@Override
	public int orderInsert(ArrayList<Order> olist){
		//발주 기록 추가
		int insert = itemDao.orderInsert(sqlSession, olist);
		int update = 1;
		for(Order order : olist) {
			//재고 수량 업데이트
			update *= itemDao.itemCountOrderUpdate(sqlSession, order);
		}
		if(update==0) {	//update 반환값 0일 때 오류 발생시켜 롤백시키기
			throw new TransactionException();
		}
		return insert*update;
	}
	
	
	

	//---------- 판매 ----------
	@Override
	public int sellListCount() {
		return itemDao.sellListCount(sqlSession);
	}
	@Override
	public ArrayList<Sell> sellList(PageInfo pi) {
		return itemDao.sellList(sqlSession, pi);
	}
	@Override
	public int sellSearchListCount(Search search) {
		return itemDao.sellSearchListCount(sqlSession, search);
	}
	@Override
	public ArrayList<Sell> sellSearchList(PageInfo pi, Search search) {
		return itemDao.sellSearchList(sqlSession,pi,search);
	}
	@Override
	public int sellInsert(ArrayList<Sell> slist) {
		return itemDao.sellInsert(sqlSession, slist);
	}
	@Transactional(rollbackFor= {TransactionException.class})
	@Override
	public int sellRelease(Sell sell) {
		int stockCount = itemDao.itemStockCount(sqlSession,sell);
		int countUpdate = 0;
		int statusUpdate = 0;
		int insertRelease = 0;
		if(stockCount >= sell.getSellCount()) {
			countUpdate = itemDao.itemCountSellUpdate(sqlSession, sell);
			statusUpdate = itemDao.sellReleaseStatusUpdate(sqlSession,sell);
			insertRelease = itemDao.sellInsertRelease(sqlSession,sell);
			if(countUpdate*statusUpdate*insertRelease == 0) {
				throw new TransactionException();
			}
		}
		
		return countUpdate*statusUpdate*insertRelease;
	}

	
	

	//---------- 출하 ----------
	@Override
	public int releaseListCount() {
		return itemDao.releaseListCount(sqlSession);
	}
	@Override
	public ArrayList<Release> releaseList(PageInfo pi) {
		return itemDao.releaseList(sqlSession, pi);
	}
	@Override
	public int releaseSearchListCount(Search search) {
		return itemDao.releaseSearchListCount(sqlSession, search);
	}
	@Override
	public ArrayList<Release> releaseSearchList(PageInfo pi, Search search) {
		return itemDao.releaseSearchList(sqlSession, pi, search);
	}
	
	
	
	
}
