package kr.or.erp.item.model.service;

import java.util.ArrayList;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.vo.Customer;

public interface ItemService {

	ArrayList<Customer> searchCustomer(PageInfo pi, String keyword);

	int searchCustomerListCount(String keyword);

}
