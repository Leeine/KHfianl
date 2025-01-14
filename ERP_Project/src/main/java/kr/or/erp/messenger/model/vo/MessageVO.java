package kr.or.erp.messenger.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class MessageVO {
	private String send;
	private String receive;
	private String message;
	private String readMsg;
	private String sendTime;
	private String notice;
}