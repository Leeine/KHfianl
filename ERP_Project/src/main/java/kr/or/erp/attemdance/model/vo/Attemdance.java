package kr.or.erp.attemdance.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Attemdance {
	private int attCode;//	ATT_CODE NUMBER PRIMARY KEY,
	private int attTypeCode;//    ATT_TYPE_CODE VARCHAR2(100) NOT NULL,
	private String attTypeName;
	private String attName;//    ATT_NAME VARCHAR2(100) NOT NULL,
	private double attCount;//    ATT_COUNT NUMBER NOT NULL,
	private String attState;//    ATT_STATE VARCHAR2(1)
}
