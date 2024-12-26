<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="/erp/js/common/modal.js"></script>
<link href="/erp/css/common/modal.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<c:set var="contextPath"value="${pageContext.servletContext.contextPath}" />
	배경
	
	<button class="add" onclick="modalShow();">모달창 띄우기</button>
	
	<!-- 모달 샘플 -->
	<div class="modal-overlay">
		<div class="modal">
			<div class="modal-header">
				<img src="${contextPath}/icon/x.png" class="modalHide">
			</div>
			<h3>모달 샘플</h3>
			<table>
				<tbody>
					<tr>
						<th>항목1</th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th>항목2</th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th>항목3</th>
						<td><input type="text"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<script>
		$(".modalHide").click(function(){
			modalHide();
		})
	</script>
</body>
</html>