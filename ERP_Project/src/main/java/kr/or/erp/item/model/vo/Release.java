package kr.or.erp.item.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Release {
	private int releaseNo;
	private String itemName;
	private int releaseCount;
	private String releaseDate;
}
