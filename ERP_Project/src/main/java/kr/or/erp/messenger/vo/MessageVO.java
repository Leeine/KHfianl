package kr.or.erp.messenger.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MessageVO {
	private int id;
	private String message;
}
