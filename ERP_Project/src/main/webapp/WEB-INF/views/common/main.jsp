<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="/erp/css/summernote/summernote-lite.css" rel="stylesheet">
<script src="/erp/js/summernote/summernote-lite.js"></script>
<script src="/erp/js/summernote/lang/summernote-ko-KR.js"></script>

<script src="/erp/js/common/menu.js"></script>
<script src="/erp/js/common/modal.js"></script>
<link href="/erp/css/common/modal.css" rel="stylesheet">

<link href="/erp/css/item/customer.css" rel="stylesheet">
<script src="/erp/js/item/customer.js"></script>
<link href="/erp/css/item/stock.css" rel="stylesheet">
<script src="/erp/js/item/stock.js"></script>
<title>Insert title here</title>
<style>
    #main-content-header{
    	margin : 30px auto;
		padding : 1px 15px;
    	width : 95%;
    	height : 100px;
    	border-radius : 10px;
		background-color: white;
    }
	#main-content{
		margin-left : 60px;
	}
	#main-content-block{
		margin : 0 auto;
		padding : 1px 15px;
		background-color: white;
		border-radius: 10px;
		width : 95%;
		height : 80vh;
		overflow: auto;
	}
</style>
</head>
<body style="background-color: rgb(225, 235, 255)">
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
			var dept = ("${loginUser.deptCode}").substring(0,1);
			if(dept != "D"){
				$(".admin").hide();
			}
		});
        $(".side-menu").click(function(){
            $($(this).parent()).siblings().find(".sub-menu").slideUp();
            $(this).siblings(".sub-menu").slideToggle();
        });
        $("#sidebar").mouseleave(function(){
            $(".sub-menu").slideUp();
        })
        $(".sign-out").click(function(){
        	location.href ="${contextPath}/employee/logout";
        })
    </script>
</body>
</html>