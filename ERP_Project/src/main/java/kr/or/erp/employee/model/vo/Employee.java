package kr.or.erp.employee.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Employee {
	private int empNo;//	EMP_NO	NUMBER
	private String empPwd;//	EMP_PASSWORD	VARCHAR2(20 BYTE)
	private String empRank;//	EMP_RANK	VARCHAR2(2 BYTE)
	private String rankName;
	private String deptCode;//	DEPT_CODE	VARCHAR2(3 BYTE)
	private String deptName;
	private String empName;//	EMP_NAME	VARCHAR2(100 BYTE)
	private int age;//	AGE	NUMBER
	private String phone;//	PHONE	VARCHAR2(13 BYTE)
	private String email;//	EMAIL	VARCHAR2(100 BYTE)
	private String address;//	ADDRESS	VARCHAR2(4000 BYTE)
	private String birthday;//	BIRTHDAY	DATE
	private double vacation;//	VACATION	VARCHAR2(5 BYTE)
	private String joinDate;//	JOIN_DATE	DATE
}
