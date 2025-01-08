package kr.or.erp.attemdance.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import kr.or.erp.attemdance.model.vo.Attemdance;
import kr.or.erp.attemdance.model.vo.CommuteOn;
import kr.or.erp.attemdance.model.vo.EmpAttemdance;
import kr.or.erp.attemdance.model.vo.PageInfo;
import kr.or.erp.employee.model.vo.Employee;

public interface AttemdanceService {

	//근태 세부 리스트 개수
	int listCount();
	//근태 항목 목록 조회
	ArrayList<Attemdance> selectAttList(PageInfo pi);
	
	//근태 항목 등록
	int attInsert(Attemdance att);
	//근태 수정
	int attUpdate(int attCode);
	int attUpdate2(int attCode);
	//근태 삭제
	int attDelete(int attCode);
	
	//사원 근태 개수
	int empAttListCount();
	//
	int userEmpCount(int empNo);
	//사원 근태 목록 조회
	ArrayList<EmpAttemdance> empAttList(PageInfo pi);
	//사원 근태 날짜 지정 조회
	ArrayList<EmpAttemdance> selectAttDate(HashMap<String, String> hashMap, PageInfo pi);
	//사원 근태 조회
//	EmpAttemdance selectEmpAtt(int empNo);
	//사원 근태 등록
	int empAttInsert(EmpAttemdance empAtt);
	//근태 선택 옵션
	ArrayList<Attemdance> empOptList();
	//삭제
	int empAttDelete(EmpAttemdance empAtt);
	
	ArrayList<Employee> empList(PageInfo pi);
	//사원 검색
	ArrayList empSearch(HashMap<String, String> hashMap);
	//count -
	int empAttCount(EmpAttemdance empAtt);
	//count +
	int empAttCount2(EmpAttemdance empAtt);
	//사원 근태 수정
	int empAttUpdate(EmpAttemdance empAtt);
	int empAttUpdate2(EmpAttemdance empAtt);
	
	//출퇴근 리스트 개수
	int comListCount();
	//출퇴근 리스트 목록 조회
	ArrayList comOnList(String daysc, PageInfo pi);
	//출근 조건 검색 조회
	ArrayList comSearchList(HashMap<String, String> hashMap, PageInfo pi);
	//유저 일주일 출근
	ArrayList<CommuteOn> empWeek(int empNo);
	//출퇴근 버튼
	int comInBtn(int empNo);
	//출퇴근 기록
	int insertCom(int empNo, String btnVal);
	//오늘 퇴근 체크
	int todayComCheck(int empNo);
	
	

}
