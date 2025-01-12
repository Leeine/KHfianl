package kr.or.erp.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.erp.admin.model.dao.AdminDao;
import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.CategoryList;
import kr.or.erp.item.model.vo.Item;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	SqlSessionTemplate sqlSession;
	@Autowired
	AdminDao adminDao;
	
	@Override
	public ArrayList<Employee> empRankList() {
		return adminDao.empRankList(sqlSession);
	}
	@Override
	public ArrayList<Employee> deptList() {
		return adminDao.deptList(sqlSession);
	}
	@Override
	public ArrayList<Employee> empList() {
		return adminDao.empList(sqlSession);
	}
	@Override
	public int empInsert(Employee e) {
		return adminDao.empInsert(sqlSession, e);
	}
	@Override
	public ArrayList<Item> itemList() {
		return adminDao.itemList(sqlSession);
	}
	@Override
	public int itemInsert(Item i) {
		return adminDao.itemInsert(sqlSession, i);
	}
	@Override
	public ArrayList<CategoryList> categoryList() {
		return adminDao.categoryList(sqlSession);
	}
	@Override
	public int categoryInsert(CategoryList c) {
		return adminDao.categoryInsert(sqlSession, c);
	}

}
