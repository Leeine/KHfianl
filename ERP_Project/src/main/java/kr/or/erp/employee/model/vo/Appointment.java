package kr.or.erp.employee.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Appointment {
	private int appointmentNo;
	private int empNo;
	private String empName;
	private String appointmentDate;
	private int appointmentTypeCode;
	private String appointmentTypeName;
	private String newDept;
	private String deptName;
	private String newRank;
	private String rankName;
}
