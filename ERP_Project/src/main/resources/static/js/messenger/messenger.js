//메신저 사원 리스트(본인 제외)
function messenger_emp_list(empNo, contextPath) {
	$.ajax({
		url: "/erp/employee/messenger/list",
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
				if(d.unreadCount != null){
					if (d.unreadCount > 99){
						td3.append($("<div>").addClass("unreadCount").text("99+"));
					}else{
						td3.append($("<div>").addClass("unreadCount").text(d.unreadCount));
					}
				}else{
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
		url: "/erp/employee/messenger/search",
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
				tbody.append(tr);
			}
			$("#messenger-emplist-table").append(tbody);
		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		}
	})
}

function chat_room(empNo, empName) {
	$.ajax({
		url: "/erp/employee/messenger/chatroom",
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
			$('#chat-text-area').scrollTop($('#chat-text-area')[0].scrollHeight);
			$('#chat-header-table').find("td").eq(1).append(empName);
		}
	})
}



//웹소켓 담을 변수 선언
let socket;
//웹소켓 연결(로그인 시 상시 연결)
function webSocketConnect(empNo) {
	//소켓 중복접속 방지
	if (socket && socket.readyState === socket.OPEN) {
		return;
	}
	//socket = new WebSocket("ws://localhost:8888/erp/messenger/ws");
	
	socket = new WebSocket("ws://192.168.150.26:8888/erp/messenger/ws");

	socket.onopen = function() {
		$("#messenger-status-text").text("온라인").css("background-color","green");
	};

	socket.onmessage = function(message) {
		var data = JSON.parse(message.data);
		var chat = $("<div>").addClass("chat");
		
		//메시지가 div에 들어가기 때문에 줄바꿈처리 및 공백처리
		var msg = (data.message).replace(/\n/g, "<br>").replace(/(\s+)/g, (match) => '&nbsp;'.repeat(match.length));
		if(data.send == empNo){
			//송신자 화면
			chat.addClass("send-chat").html(msg);
		}else{
			//수신자 화면
			chat.addClass("receive-chat").html(msg);
		}
		$("#chat-text-area").append(chat);
		
		if($("#messenger-main-page").css("display") == "none"){
			$("#msg-count").text("!");
			$("#msg-count").show();
		}
	};

	socket.onclose = function() {
		$("#messenger-status-text").text("오프라인").css("background-color","red");
	};
}
//웹소켓 연결 해제(로그아웃 시)
function webSocketDisconnect() {
	socket.close();
}
//메시지 전송
function sendMessage(empNo) {
	const jsonData = {
		send: empNo,
		receive: $("#messenger-receive-user").val(),
		msg: $("#chat-input-textarea").val()
	};

	// JSON 객체를 문자열로 변환 후 전송
	socket.send(JSON.stringify(jsonData));
	$("#chat-input-textarea").val('');
}

