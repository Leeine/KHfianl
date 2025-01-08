package kr.or.erp.attemdance.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class EmpAttemdance {
	private Date empAttTime;//	EMP_ATT_TIME	DATE
	private int attCode;//	ATT_CODE NUMBER NOT NULL,
	private String attName;
	private int empNo;//    NUMBER,
	private String empName;
	private double empAttCount;//    EMP_ATT_COUNT NUMBER NOT NULL,
	private Date inputDate;//    INPUT_DATE DATE DEFAULT SYSDATE,
	private String empAttState;//    EMP_ATT_STATE VARCHAR(1)
	
	private String deptCode;
	private String deptName;
	private double vacation;
}
