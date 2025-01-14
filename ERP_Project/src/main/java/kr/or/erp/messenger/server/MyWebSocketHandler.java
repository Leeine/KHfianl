package kr.or.erp.messenger.server;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.http.HttpSession;
import kr.or.erp.employee.model.vo.Employee;
import kr.or.erp.messenger.model.service.MessengerService;
import kr.or.erp.messenger.model.vo.MessageVO;

@Component
public class MyWebSocketHandler extends TextWebSocketHandler {

	// DB 저장용 서비스
	@Autowired
	MessengerService messengerService;

	// 사용자(WebsocketSession 정보)를 담을 저장소 준비
	// 동기화 처리가 되어있는 Set 저장소
	private HashMap<String, WebSocketSession> users = new HashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// log.debug("로그인 서버 접속");

		// websocketSession에 모든 속성 추출(map 형태)
		// log.debug("session : {}",session.getAttributes());

		// 해당 속성중 loginUser라는 key값으로 value 추출
		Employee loginUser = (Employee) session.getAttributes().get("loginUser");
		String empNo = Integer.toString(loginUser.getEmpNo());
		users.put(empNo, session);// 저장소에 웹소켓 정보 담기
	}

	@Override
	@Transactional
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 메시지를 전달받아 VO에 담아서 처리
		JsonObject jsonObject = JsonParser.parseString(message.getPayload()).getAsJsonObject();
		String send = jsonObject.get("send").getAsString();
		String receive = jsonObject.get("receive").getAsString();
		
		//관리자 공지
		if(jsonObject.get("notice")!=null) {
			// 생성한 메시지 정보 VO를 json 문자열로 변환하여 전달하기
			System.out.println();
			MessageVO mv = MessageVO.builder().notice(jsonObject.get("notice").getAsString()).build();
			String responseMsg = new Gson().toJson(mv); // gson 이용해서 json화 하기

			TextMessage tm = new TextMessage(responseMsg); // 새 메시지 형태 담아서 메시지 객체 생성
			
			//접속중인 모든 사용자에게 전송
			for (HashMap.Entry<String,WebSocketSession> user : users.entrySet()) {
			    user.getValue().sendMessage(tm);
				users.remove(user.getKey());
			}
			return;
		}
		
		
		
		
		MessageVO mv = MessageVO.builder().send(send).receive(receive).build();
		
		// 채팅방 접속시 메시지 읽음 처리
		if (jsonObject.get("msg")==null) {	//메시지 확인인 경우
			int check = messengerService.readMessage(mv);
		} else {	//메시지 전송인 경우
			String msg = jsonObject.get("msg").getAsString();
			
			// 현재시간 측정
			LocalDateTime systemTime = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			String sendTime = systemTime.format(formatter);
			
			mv = MessageVO.builder().send(send).receive(receive).message(msg).sendTime(sendTime).build();
			

			// 메시지 데이터 DB에 등록
			messengerService.sendMessage(mv);

		}
		
		// 생성한 메시지 정보 VO를 json 문자열로 변환하여 전달하기
		String responseMsg = new Gson().toJson(mv); // gson 이용해서 json화 하기

		TextMessage tm = new TextMessage(responseMsg); // 새 메시지 형태 담아서 메시지 객체 생성
		
		// 송신자에게 전송
		users.get(send).sendMessage(tm);
		if (users.get(receive) != null) { // 수신자가 접속중이지 않다면 소켓 전송x
			users.get(receive).sendMessage(tm);
		}

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 접속 종료시 세션에 담겨있는 users 저장소에서 내 세션 정보를 지워준다.
		// 접속정보를 지우지 않으면 서버에서는 없는 세션정보에 지속적으로 메시지를 보낸다.
		Employee loginUser = (Employee) session.getAttributes().get("loginUser");
		String empNo = Integer.toString(loginUser.getEmpNo());
		users.remove(empNo);

	}
}
