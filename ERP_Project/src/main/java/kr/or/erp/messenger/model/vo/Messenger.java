package kr.or.erp.messenger.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Messenger {
	private String empNo;
	private String empName;
	private String deptCode;
	private String deptName;
	private String empRank;
	private String rankName;
	private String unreadCount;
}
