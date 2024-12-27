<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
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
	<%@include file="/WEB-INF/views/attemdance/modal.jsp"%>
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
			<h3>출퇴근</h3>
			<table class="table" align="center">
				<thead>
					<tr>
						<th>일자</th>
						<th>사원명</th>
						<th>출근시간</th>
						<th>최근시간</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	
	<script>
		$(function(){
			
		});
		
		function comList(){
			$.ajax({
				url : "comList",
				success : function(list){
					var str = "";
					for(var com of list){
						str += "";
					}
				},
				error : function(){
					
				}
			});
		}
	</script>
</body>
</html>