<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<title>ERP</title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
	<div id="table-wrap">
		<script>
			$(function(){
				//목록에서 선택시 공지 내용보기
				$("#index-notice-table").on("click","td",function(){
					var noticeNo = $(this).parents("tr").find("td").eq(0).text();
					notice_modal_detail(noticeNo);
				});
				
				//모달 숨기기
				$(".modalHide").click(function() {
					clear();
					modalHide();
					indexNoticeList();
				})
			})
		</script>
		<table id="index-notice-table">
			<colgroup>
				<col style="width: 15%">
				<col style="width: 45%">
				<col style="width: 15%">
				<col style="width: 25%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		
		<!-- 공지 내용 보기 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>NOTICE</h3>
				<input type="hidden" class="modal-customerNo">
				<table>
					<colgroup>
						<col style="width: 10%">
						<col style="width: 10%">
						<col style="width: 20%">
						<col style="width: 20%">
						<col style="width: 20%">
						<col style="width: 20%">
					</colgroup>
					<tbody>
						<tr>
							<th>번호</th>
							<td>
								<input type="text" id="modal-noticeNo" class="modal_data">
							</td>
							<th>조회수</th>
							<td>
								<input type="text" id="modal-noticeCount" class="modal_data">
							</td>
							<th>작성자</th>
							<td>
								<input type="text" id="modal-noticeWriter" class="modal_data">
							</td>
						</tr>
						<tr>
							<th colspan="2">작성일</th>
							<td colspan="4">
								<input type="text" id="modal-createDate" class="modal_data">
							</td>
						</tr>
						<tr>
							<th colspan="2">제목</th>
							<td colspan="4">
								<input type="text" id="modal-noticeTitle" class="modal_data">
							</td>
						</tr>
						<tr>
							<th colspan="2">내용</th>
							<td colspan="4">
								<div id="modal-noticeContent" class="modal_data"></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>