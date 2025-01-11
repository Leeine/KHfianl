package kr.or.erp.messenger.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.messenger.model.service.MessengerService;
import kr.or.erp.messenger.model.vo.MessageVO;
import kr.or.erp.messenger.model.vo.Messenger;

@Controller
@RequestMapping("/messenger")
public class MessengerController {
	@Autowired
	MessengerService messengerService;

	// 메신저 사용자 목록
	@ResponseBody
	@GetMapping("/list")
	public ArrayList<Messenger> messengerEmpList(Employee e) {
		ArrayList<Messenger> list = messengerService.messengerEmpList(e);
		return list;
	}

	@ResponseBody
	@GetMapping("/search")
	public ArrayList<Messenger> messengerEmpSearchList(Employee e) {
		ArrayList<Messenger> list = messengerService.messengerEmpList(e);
		return list;
	}

	// 채팅방 이동
	@GetMapping("/chatroom")
	public String chatroom() {
		return "messenger/chatRoom";
	}

	@ResponseBody
	@PostMapping("/load")
	public ArrayList<MessageVO> loadMessage(MessageVO mv){
		ArrayList<MessageVO> list = messengerService.loadMessage(mv);
		return list;
	}
}
