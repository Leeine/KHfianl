package kr.or.erp.item.model.service;

import java.util.ArrayList;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.vo.Category;
import kr.or.erp.item.model.vo.Customer;
import kr.or.erp.item.model.vo.Item;
import kr.or.erp.item.model.vo.Order;
import kr.or.erp.item.model.vo.OrderSearch;
import kr.or.erp.item.model.vo.OrderView;

public interface ItemService {
	
	//----------거래처----------
	ArrayList<Customer> searchCustomer(PageInfo pi, String keyword);
	int searchCustomerListCount(String keyword);
	int customerListCount();
	ArrayList<Customer> customerList(PageInfo pi);
	int customerInsert(Customer customer);
	int customerUpdate(Customer customer);


	//---------- 재고 ----------
	int stockListCount();
	ArrayList<Item> stockList(PageInfo pi);
	ArrayList<Category> itemCategoryList();
	int itemSearchListCount(String keyword);
	ArrayList<Item> itemSearchList(PageInfo pi,String keyword);
	Item itemDetail(Item item);
	ArrayList<Category> itemCategory(Item item);
	int itemUpdate(Item item, ArrayList<Category> category);

	
	//---------- 발주 ----------
	int orderListCount();
	ArrayList<OrderView> orderList(PageInfo pi);
	int orderSearchListCount(OrderSearch orderSearch);
	ArrayList<OrderView> orderSearchList(PageInfo pi, OrderSearch orderSearch);
	ArrayList<Customer> orderCustomerList(String keyword);
	ArrayList<Item> orderItemList(String keyword);
	int orderInsert(Order order);
	
	
}
