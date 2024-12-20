package kr.or.erp.attemdance.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class EmpAttemdance {
private int attCode;//	ATT_CODE NUMBER NOT NULL,
private String empNo;//    EMP_NO VARCHAR2(10) NOT NULL,
private double empAttCount;//    EMP_ATT_COUNT NUMBER NOT NULL,
private Date inputDate;//    INPUT_DATE DATE DEFAULT SYSDATE,
private String empAttState;//    EMP_ATT_STATE VARCHAR(1)
}
