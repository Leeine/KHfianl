package kr.or.erp.notice.model.vo;

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
	private String noticeContent;
	private int noticeCount;
	private String createDate;
	
}
