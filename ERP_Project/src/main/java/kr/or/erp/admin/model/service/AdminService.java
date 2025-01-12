package kr.or.erp.admin.model.service;

import java.util.ArrayList;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.CategoryList;
import kr.or.erp.item.model.vo.Item;

public interface AdminService {

	ArrayList<Employee> empRankList();
	ArrayList<Employee> deptList();

	ArrayList<Employee> empList();
	int empInsert(Employee e);

	ArrayList<Item> itemList();
	int itemInsert(Item i);
	
	ArrayList<CategoryList> categoryList();
	int categoryInsert(CategoryList c);
	


}
