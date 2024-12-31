package kr.or.erp.item.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.dao.ItemDao;
import kr.or.erp.item.model.vo.Category;
import kr.or.erp.item.model.vo.Customer;
import kr.or.erp.item.model.vo.Item;

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
	public ArrayList<Customer> stockList(PageInfo pi) {
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
	public ArrayList<Customer> itemSearchList(PageInfo pi, String keyword) {
		return itemDao.itemSearchList(sqlSession, pi, keyword);
	}
	
	
	
}
