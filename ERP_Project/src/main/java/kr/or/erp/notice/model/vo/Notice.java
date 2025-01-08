package kr.or.erp.notice.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class Notice {
	private int noticeNo;
	private int noticeWriter;
	private String empName;
	private String noticeTitle;
	private String noticeContent;
	private int noticeCount;
	private Date createDate;
	
}
