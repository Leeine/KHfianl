package kr.or.erp.attemdance.model.service;

import java.util.ArrayList;

import kr.or.erp.attemdance.model.vo.Attemdance;
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
	//사원 근태 목록 조회
	ArrayList<EmpAttemdance> empAttList(PageInfo pi);
	//사원 근태 조회
	EmpAttemdance selectEmpAtt(int empNo);
	//사원 근태 등록
	int empAttInsert(EmpAttemdance empAtt);
	//근태 선택 옵션
	ArrayList<Attemdance> empOptList();
	//삭제
	int empAttDelete(EmpAttemdance empAtt);
	
	ArrayList<Employee> empList(PageInfo pi);
	//count -
	int empAttCount(EmpAttemdance empAtt);
	//count +
	int empAttCount2(EmpAttemdance empAtt);
	//사원 근태 수정
	int empAttUpdate(EmpAttemdance empAtt);
	int empAttUpdate2(EmpAttemdance empAtt);
	
	//출퇴근 리스트 개수
	//출퇴근 리스트 목록 조회
	
	//출근 기록
	
	//퇴근 기록
	

}
