package kr.or.erp.item.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {
	private int orderNo;
	private int customerNo;
	private int itemCode;
	private int orderCount;
	private int orderPrice;
	private String orderDate;
	private int empNo;
}
