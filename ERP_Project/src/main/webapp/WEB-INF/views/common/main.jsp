<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<link href="/erp/css/item/item.css" rel="stylesheet">
<script src="/erp/js/common/main.js"></script>
<title>Insert title here</title>
<style>
	body {
    	background-color: rgb(225, 235, 255);
    }
    #main-content-header{
    	margin : 30px;
    	width : 93%;
    	height : 100px;
    	border-radius : 20px;
		background-color: white;
    }
	#main-content{
		margin-left : 60px;
	}
	#main-content-block{
		margin : 30px;
		padding : 1px 15px;
		background-color: white;
		border-radius: 20px;
		width : 93%;
		height : 80vh;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/sidemenu.jsp"%>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"/>
	<div id="main-content">
		<c:if test="${not empty alertMsg}">
			<script>
				alert("${alertMsg}");
			</script>
			<c:remove var="alertMsg"/>
		</c:if>
		
		<div id="main-content-header">
		</div>
		
		
		<div id="main-content-block">
			<h3>메인 페이지 구역</h3>
		</div>
	</div>
	
</body>
</html>