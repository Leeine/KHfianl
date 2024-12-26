<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link href="/erp/css/summernote/summernote-lite.css" rel="stylesheet">
<script src="/erp/js/summernote/summernote-lite.js"></script>
<script src="/erp/js/summernote/lang/summernote-ko-KR.js"></script>




<meta charset="UTF-8">
<script src="/erp/js/summernote/summernote-ajax.js"></script>
<script src="/erp/js/common/menu.js"></script>
<script src="/erp/js/common/modal.js"></script>
<link href="/erp/css/common/modal.css" rel="stylesheet">
<link href="/erp/css/item/customer.css" rel="stylesheet">
<script src="/erp/js/item/customer.js"></script>

<title>Insert title here</title>
<style>
	body {
    	background-color: rgb(225, 235, 255);
    }
    #main-content-header{
    	margin : 30px;
		padding : 1px 15px;
    	width : 93%;
    	height : 100px;
    	border-radius : 10px;
		background-color: white;
    }
	#main-content{
		margin-left : 60px;
	}
	#main-content-block{
		margin : 30px;
		padding : 1px 15px;
		background-color: white;
		border-radius: 10px;
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
	<script>
		$(function(){
			$('#summernote').summernote({
	              placeholder: '내용을 입력해주세요',
	              tabsize: 2,
	              width: 1000,
	              height: 300,
	              focus: true,
	              lang: 'ko-KR', 
	              toolbar: [
	                ['style', ['style']],
	                ['font', ['bold', 'underline', 'clear']],
	                ['color', ['color']],
	                ['para', ['ul', 'ol', 'paragraph']],
	                ['table', ['table']],
	                ['insert', ['link', 'picture', 'video']],
	                ['view', ['fullscreen', 'codeview', 'help']]
	              ]
	      	});
		})
	</script>
</body>
</html>