package kr.or.erp.approve.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Document {
	private String doNo;
	private String doList;
	private String doContent;
}
