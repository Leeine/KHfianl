package kr.or.erp.item.model.service;

import java.util.ArrayList;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.vo.Customer;

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
	ArrayList<Customer> stockList(PageInfo pi);
	
	
}
