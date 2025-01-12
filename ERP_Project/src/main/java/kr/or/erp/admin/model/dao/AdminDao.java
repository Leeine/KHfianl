package kr.or.erp.admin.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.item.model.vo.CategoryList;
import kr.or.erp.item.model.vo.Item;

@Repository
public class AdminDao {

	public ArrayList<Employee> empRankList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.empRankList");
	}
	public ArrayList<Employee> deptList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.deptList");
	}
	public ArrayList<Employee> empList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.empList");
	}
	public int empInsert(SqlSessionTemplate sqlSession, Employee e) {
		return sqlSession.insert("adminMapper.empInsert",e);
	}
	public ArrayList<CategoryList> categoryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.categoryList");
	}
	public int categoryInsert(SqlSessionTemplate sqlSession, CategoryList c) {
		return sqlSession.insert("adminMapper.categoryInsert",c);
	}
	public ArrayList<Item> itemList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMapper.itemList");
	}
	public int itemInsert(SqlSessionTemplate sqlSession, Item i) {
		return sqlSession.insert("adminMapper.itemInsert",i);
	}
	
}
