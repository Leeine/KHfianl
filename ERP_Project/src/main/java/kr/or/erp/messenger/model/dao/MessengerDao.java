package kr.or.erp.messenger.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;

import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.messenger.model.vo.MessageVO;
import kr.or.erp.messenger.model.vo.Messenger;

@Component
public class MessengerDao {
	// 메신저용 사원리스트 불러오기
	public ArrayList<Messenger> messengerEmpList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList) sqlSession.selectList("messengerMapper.messengerEmpList", e);
	}

	public ArrayList<Messenger> messengerEmpSearchList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList) sqlSession.selectList("messengerMapper.messengerEmpSearchList", e);
	}

	public int sendMessage(SqlSessionTemplate sqlSession, MessageVO mv) {
		return sqlSession.insert("messengerMapper.sendMessage", mv);
	}

	public int readMessage(SqlSessionTemplate sqlSession, MessageVO mv) {

		return sqlSession.update("messengerMapper.readMessage", mv);
	}

	public ArrayList<MessageVO> loadMessage(SqlSessionTemplate sqlSession, MessageVO mv) {
		return (ArrayList) sqlSession.selectList("messengerMapper.loadMessage",mv);
	}

}
