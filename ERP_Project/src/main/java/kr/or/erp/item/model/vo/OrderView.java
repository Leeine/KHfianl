package kr.or.erp.item.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderView {
	private int orderNo;
	private String customerName;
	private String itemName;
	private int orderCount;
	private int orderPrice;
	private String orderDate;
	private String empName;
}
