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
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
	<div id="employee-mypage-page">
		<input type="hidden" value="${loginUser.empNo}" id="empNo">
		<script>
			$(function(){
				employee_mypage_info();
			});
		</script>
	</div>
</body>
</html>