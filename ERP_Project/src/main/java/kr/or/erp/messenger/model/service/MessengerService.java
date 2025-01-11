package kr.or.erp.messenger.model.service;

import java.util.ArrayList;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.messenger.model.vo.MessageVO;
import kr.or.erp.messenger.model.vo.Messenger;

public interface MessengerService {
	//메신저용 사원리스트 불러오기
	ArrayList<Messenger> messengerEmpList(Employee e);

	int sendMessage(MessageVO mv);
	
	int readMessage(MessageVO mv);

	ArrayList<MessageVO> loadMessage(MessageVO mv);
}
