package kr.or.erp.approve.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Approve {
	private String apNo;
	private int empNo;
	private Date apCreateDate;
	private String apTitle;
	private String apContent;
	private String statusCode;
	private int apMaster;
}
