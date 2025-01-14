//메신저 사원 리스트(본인 제외)
function messenger_emp_list(empNo, contextPath) {
	$.ajax({
		url: "/erp/messenger/list",
		method: 'GET',
		data: {
			empNo: empNo
		},
		success: function(data) {
			$("#messenger-emplist-table>tbody").remove();
			var tbody = $("<tbody>");
			for (var d of data) {
				var tr = $("<tr>").addClass("messenger-emplist");
				var td1 = $("<td>");
				td1.append($("<input>").attr("type", "hidden").val(d.empNo).addClass("messenger-empNo"));
				td1.append($("<img>").attr("src", contextPath + "/icon/mypage.png").addClass("user-icon"));
				tr.append(td1);
				var td2 = $("<td>");
				td2.append($("<div>").addClass("messenger-emplist-dept").text(d.deptName));
				td2.append($("<div>").addClass("messenger-emplist-name").text(d.rankName + " " + d.empName));
				tr.append(td2);
				var td3 = $("<td>");
				if (d.unreadCount != null) {
					if (d.unreadCount > 99) {
						td3.append($("<div>").addClass("unreadCount").text("99+"));
					} else {
						td3.append($("<div>").addClass("unreadCount").text(d.unreadCount));
					}
				} else {
					td3.append('');
				}
				tr.append(td3);
				tbody.append(tr);
			}
			$("#messenger-emplist-table").append(tbody);
		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		}
	})
}

//메신저 사원 검색 리스트(본인 제외)
function messenger_emp_search_list(empNo, contextPath) {
	$.ajax({
		url: "/erp/messenger/search",
		method: 'GET',
		data: {
			//검색하려는 사원명
			empName: $("#messenger-search-keyword").val(),
			//검색에서 제외할 내 사원번호
			empNo: empNo
		},
		success: function(data) {
			$("#messenger-emplist-table>tbody").remove();
			var tbody = $("<tbody>");
			for (var d of data) {
				var tr = $("<tr>").addClass("messenger-emplist");
				var td1 = $("<td>");
				td1.append($("<input>").attr("type", "hidden").val(d.empNo));
				td1.append($("<img>").attr("src", contextPath + "/icon/mypage.png").addClass("user-icon"));
				tr.append(td1);
				var td2 = $("<td>");
				td2.append($("<div>").addClass("messenger-emplist-dept").text(d.deptName));
				td2.append($("<div>").addClass("messenger-emplist-name").text(d.rankName + " " + d.empName));
				tr.append(td2);
				var td3 = $("<td>");
				if (d.unreadCount != null) {
					if (d.unreadCount > 99) {
						td3.append($("<div>").addClass("unreadCount").text("99+"));
					} else {
						td3.append($("<div>").addClass("unreadCount").text(d.unreadCount));
					}
				} else {
					td3.append('');
				}
				tr.append(td3);
				tbody.append(tr);
			}
			$("#messenger-emplist-table").append(tbody);
		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		}
	})
}

function chat_room(empNo, empName, myEmpNo) {
	$.ajax({
		url: "/erp/messenger/chatroom",
		method: 'GET',
		success: function(data) {
			$("#messenger-user-list").hide();
			$("#direct-message-area").html($(data).filter("#messenger-chatting-room")[0]);
		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		},
		complete: function() {
			$("#messenger-receive-user").val(empNo);
			//스크롤 맨 밑으로 내리기
			$('#chat-text-area').scrollTop($('#chat-text-area')[0].scrollHeight);
			$('#chat-header-table').find("td").eq(1).append(empName);
			readMessage(myEmpNo, empNo);
			loadMessage(myEmpNo, empNo);
		}
	})
}



//웹소켓 담을 변수 선언
let socket;
//웹소켓 연결(로그인 시 상시 연결)
function webSocketConnect(myEmpNo,contextPath) {
	//소켓 중복접속 방지
	if (socket && socket.readyState === socket.OPEN) {
		return;
	}
	socket = new WebSocket("ws://localhost:8888/erp/messenger/ws");

	//socket = new WebSocket("ws://192.168.150.26:8888/erp/messenger/ws");

	socket.onopen = function() {
		$("#messenger-status-text").text("온라인").css("background-color", "green");

	};

	socket.onmessage = function(messageData) {
		var data = JSON.parse(messageData.data);
		var send = data.send;
		var receive = data.receive;
		var dateTime = (data.sendTime);

		var wrap = $("<div>").addClass("chat");
		var chat = $("<div>").addClass("chat-text");
		var receiver = $("#messenger-receive-user").val(); //대화상대
		var msgBrowser = $("#messenger-main-page").css("display"); //메신저 창 켜져있는지
		var message = (data.message)
		
		//관리자 실시간 공지를 수신했을 때
		if(data.notice != null){
			//관리자의 일괄 로그아웃 요청
			if(data.notice == "/logoutAll"){
					location.href = contextPath+"/employee/logout";
			}else{
				//화면에 공지 띄우기
				$("#admin-notice-content").html(data.notice);
				$("#admin-notice").show();
			}
			return;
		}
		
		//일반 메시지를 수신했을 때
		if (send == myEmpNo) { //송신자 화면 (우측) [send : 나 / receive : 대화상대]
			if (data.message != null) {

				//공백 및 줄바꿈 처리
				var msg = message.replace(/\n/g, "<br>").replace(/(\s+)/g, (match) => '&nbsp;'.repeat(match.length));
				//읽음 확인 숫자 및 시간 처리
				var time = (dateTime.split(" ")[1]).split(":").slice(0, 2).join(":");
				var label = $("<label>").addClass("msg-readNo").text("1");
				wrap.addClass("send-chat").append($("<div>").addClass("msg-time").html("<br>" + time).prepend(label));

				//채팅방에 표시하기
				chat.append(msg);
				wrap.append(chat);
			}

		} else { //수신자 화면 (좌측) [send : 대화상대 / receive : 나]
			if (data.message == null) {//빈 메시지 수신 = 대화상대 채팅방 입장 또는 대화상대 메시지 확인중
				//읽음 확인 숫자 지우기
				$(".msg-readNo").remove();
			} else {	//대화상대가 메시지 보냄

				//시간 처리
				var time = (dateTime.split(" ")[1]).split(":").slice(0, 2).join(":");

				//공백 및 줄바꿈 처리
				var msg = message.replace(/\n/g, "<br>").replace(/(\s+)/g, (match) => '&nbsp;'.repeat(match.length));

				

				//메시지를 보낸 사람(send)이 대화상대와 같고(같은 채팅방에 들어와있는 경우)
				//AND 메신저 창이 켜져있는 경우 => 채팅방 최신화
				if (receiver == send && msgBrowser == "block") {
					chat.addClass("receive-chat").html(msg);
					wrap.append(chat);
					wrap.append($("<div>").addClass("msg-time").html("<br>" + time));
					//읽음처리
					readMessage(receive, send);

				} else if (receiver == null && msgBrowser == "block") {//메신저 메인페이지만 켜놨을 경우
					//읽지 않은 메시지 갯수 최신화를 위해 사원목록 다시 불러오기
					messenger_emp_list(receive, '/erp/');
				}
				//다른 채팅방에 들어가있거나 메신저 창이 내려가 있는 경우는 채팅방 최신화 x
			}
			if ($("#messenger-main-page").css("display") == "none") {
				$("#msg-alert").show();
			}

		}
		//메시지를 전송 받았을때
		if (message != null) {
			//채팅 추가
			$("#chat-text-area").append(wrap);
			//채팅방에 들어가 있는 경우
			if (msgBrowser == "block" && receiver != null) {
				//스크롤 맨 밑으로 내리기
				$('#chat-text-area').scrollTop($('#chat-text-area')[0].scrollHeight);
			}
		}



	};

	socket.onclose = function() {
		$("#messenger-status-text").text("오프라인").css("background-color", "red");
	};
}
//웹소켓 연결 해제(로그아웃 시)
function webSocketDisconnect() {
	socket.close();
}
//메시지 전송
function sendMessage(empNo) {
	const jsonData = {
		send: empNo,	//보낸사람 : 나
		receive: $("#messenger-receive-user").val(),
		msg: $("#chat-input-textarea").val()
	};

	// JSON 객체를 문자열로 변환 후 전송
	socket.send(JSON.stringify(jsonData));
	$("#chat-input-textarea").val('');
}
//메시지 확인(나,대화상대)
function readMessage(myEmpNo, receive) {
	const jsonData = {
		send: myEmpNo,	//보낸사람 : 나(서버로 읽기 요청 보낸사람)
		receive: receive,	//받은사람 : 대화상대
	};
	socket.send(JSON.stringify(jsonData));
}

//메시지 불러오기
function loadMessage(myEmpNo, receive) {
	$.ajax({
		url: "/erp/messenger/load",
		data: {
			send: myEmpNo,		//보낸사람 : 나
			receive: receive	//받은사람 : 대화상대
		},
		method: 'POST',
		success: function(result) {
			let tempDate = "";
			for (var data of result) {
				var send = data.send;
				var dateTime = (data.sendTime);
				var wrap = $("<div>").addClass("chat");
				var chat = $("<div>").addClass("chat-text");
				var time = (dateTime.split(" ")[1]).split(":").slice(0, 2).join(":");
				var date = dateTime.split(" ")[0];
				var msg = (data.message).replace(/\n/g, "<br>").replace(/(\s+)/g, (match) => '&nbsp;'.repeat(match.length));
				if (tempDate != date) {
					var chatDate = $("<div>").addClass("chat-date").text(date);
					tempDate = date;
					$("#chat-text-area").append(chatDate);
				}

				if (send == myEmpNo) {
					//송신자 화면 (우측)

					var label = $("<label>").addClass("msg-readNo");
					if (data.readMsg == "N") {
						label.text("1");
					} else {
						label.text("");
					}
					wrap.addClass("send-chat").append($("<div>").addClass("msg-time").html("<br>" + time).prepend(label));

					chat.append(msg);
					wrap.append(chat);
				} else {
					//수신자 화면 (좌측)

					chat.addClass("receive-chat").html(msg);
					wrap.append(chat);
					wrap.append($("<div>").addClass("msg-time").html("<br>" + time));

				}
				$("#chat-text-area").append(wrap);
			}
			//스크롤 맨 밑으로 내리기
			$('#chat-text-area').scrollTop($('#chat-text-area')[0].scrollHeight);

		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		},
	})
}
