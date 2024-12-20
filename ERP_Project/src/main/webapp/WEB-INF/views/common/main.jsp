<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<link href="/erp/css/test.css" rel="stylesheet">
<title>Insert title here</title>
<style>
	#main-content{
		padding-left : 60px;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/sidemenu.jsp"%>
	<div id="main-content">
		<c:if test="${not empty alertMsg}">
			<script>
				alert("${alertMsg}");
			</script>
			<c:remove var="alertMsg"/>
		</c:if>
		<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"/>
		<h3>메인 페이지 구역</h3>
	</div>
</body>
</html>