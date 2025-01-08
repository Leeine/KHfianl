package kr.or.erp.item.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Item {
	private int itemCode;
	private String itemName;
	private int itemPrice;
	private int itemCount;
	private String itemCategoryName;
}
