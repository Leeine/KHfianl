package kr.or.erp.item.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.erp.common.model.vo.PageInfo;
import kr.or.erp.item.model.dao.ItemDao;
import kr.or.erp.item.model.vo.Customer;

@Service
public class ItemServiceImpl implements ItemService {
	@Autowired
	ItemDao itemDao;
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public int searchCustomerListCount(String keyword) {
		return itemDao.searchCustomerListCount(sqlSession,keyword);
	}

	@Override
	public ArrayList<Customer> searchCustomer(PageInfo pi, String keyword) {
		
		return itemDao.searchCustomerList(sqlSession,keyword,pi);
	}

}
