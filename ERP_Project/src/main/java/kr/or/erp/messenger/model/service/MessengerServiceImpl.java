package kr.or.erp.messenger.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.messenger.model.dao.MessengerDao;
import kr.or.erp.messenger.model.vo.MessageVO;
import kr.or.erp.messenger.model.vo.Messenger;

@Service
public class MessengerServiceImpl implements MessengerService {
	@Autowired
	private MessengerDao messengerDao;

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 메신저용 사원리스트 불러오기
	@Override
	public ArrayList<Messenger> messengerEmpList(Employee e) {
		if (e.getEmpName() == null) {
			return messengerDao.messengerEmpList(sqlSession, e);
		} else {
			return messengerDao.messengerEmpSearchList(sqlSession, e);
		}
	}

	@Override
	public int sendMessage(MessageVO mv) {
		return messengerDao.sendMessage(sqlSession, mv);
	}

	@Override
	public int readMessage(MessageVO mv) {
		return messengerDao.readMessage(sqlSession, mv);
	}

	@Override
	public ArrayList<MessageVO> loadMessage(MessageVO mv) {
		return messengerDao.loadMessage(sqlSession, mv);
	}
}
