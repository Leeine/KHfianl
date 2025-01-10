package kr.or.erp.attemdance.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AttemdanceType {
	private int attTypeCode;//	ATT_TYPE_CODE	NUMBER
	private String attTypeName;//	ATT_TYPE_NAME	VARCHAR2(100 BYTE)
}
