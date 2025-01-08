package kr.or.erp.item.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Sell {
	private int sellNo;
	private int itemCode;
	private String itemName;
	private int sellCount;
	private int sellPrice;
	private String sellDate;
	private String releaseStatus;
}
