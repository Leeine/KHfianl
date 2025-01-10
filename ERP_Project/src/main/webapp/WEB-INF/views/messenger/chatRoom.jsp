<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="contextPath"
		value="${pageContext.servletContext.contextPath}" />
	<div id="messenger-chatting-room">
		<div id="chat-header">
			<table id="chat-header-table">
				<tbody>
					<tr>
						<td><img src="${contextPath}/icon/exit.png" class="exit-icon"></td>
						<td><input type="hidden" id="messenger-receive-user"></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="chat-text-area">
			<div class="user1-chat chat">채팅테스트ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</div>
			<div class="user2-chat chat">답장
				ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</div>
			<div class="user1-chat chat">11111</div>
			<div class="user1-chat chat"></div>
			<div class="user2-chat chat">22222</div>
			<div class="user2-chat chat">22</div>
			<div class="user1-chat chat">1</div>
			<div class="user1-chat chat">1</div>
			<div class="user2-chat chat">2</div>
			<div class="user2-chat chat">2</div>
			<div class="user1-chat chat">1</div>
			<div class="user1-chat chat">1</div>
			<div class="user2-chat chat">2</div>
			<div class="user2-chat chat">2</div>
		</div>
		<div id="chat-input">
			<table id="chat-input-table">
				<colgroup>
					<col style="width: 80%;">
					<col style="width: 20%;">
				</colgroup>
				<tbody>
					<tr>
						<td colspan="2"><textarea style="resize: none;"
								id="chat-input-textarea"></textarea></td>
					</tr>
					<tr style="height: 30px;">
						<td></td>
						<td>
							<button id="chat-send-btn">전송</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>