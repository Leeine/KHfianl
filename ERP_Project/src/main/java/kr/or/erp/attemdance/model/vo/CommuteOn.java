package kr.or.erp.attemdance.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CommuteOn {
	private int empNo;
	private String empName;
	private Date comStart;
	private Date comEnd;
	
	private String comStartChar;
	private String comEndChar;
	
	private String deptCode;
	private String deptName;
}
