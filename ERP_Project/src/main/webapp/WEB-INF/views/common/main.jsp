<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="/erp/css/summernote/summernote-lite.css" rel="stylesheet">
<link href="/erp/css/approve/휴직원.css" rel="stylesheet">
<link href="/erp/css/approve/차량운행.css" rel="stylesheet">
<link href="/erp/css/approve/사직서.css" rel="stylesheet">
<link href="/erp/css/approve/출장 보고서.css" rel="stylesheet">
<link href="/erp/css/approve/비품신청서.css" rel="stylesheet">
<link href="/erp/css/approve/doclist.css" rel="stylesheet">
<script src="/erp/js/approve/approve.js"></script>
<script src="/erp/js/summernote/summernote-lite.js"></script>
<script src="/erp/js/summernote/lang/summernote-ko-KR.js"></script>


<link href="/erp/css/attemdance/attemdance.css" rel="stylesheet">
<link href="/erp/css/attemdance/empAttemdance.css" rel="stylesheet">
<link href="/erp/css/attemdance/commute.css" rel="stylesheet">


<link href="/erp/css/admin/admin.css" rel="stylesheet">
<script src="/erp/js/admin/admin.js"></script>
<script src="/erp/js/common/menu.js"></script>
<link href="/erp/css/common/main.css" rel="stylesheet">
<script src="/erp/js/common/modal.js"></script>
<link href="/erp/css/common/modal.css" rel="stylesheet">
<script src="/erp/js/common/index.js"></script>
<link href="/erp/css/common/indexNotice.css" rel="stylesheet">

<link href="/erp/css/item/customer.css" rel="stylesheet">
<script src="/erp/js/item/customer.js"></script>
<link href="/erp/css/item/stock.css" rel="stylesheet">
<script src="/erp/js/item/stock.js"></script>
<link href="/erp/css/item/order.css" rel="stylesheet">
<script src="/erp/js/item/order.js"></script>
<link href="/erp/css/item/sell.css" rel="stylesheet">
<script src="/erp/js/item/sell.js"></script>
<link href="/erp/css/item/release.css" rel="stylesheet">
<script src="/erp/js/item/release.js"></script>


<link href="/erp/css/employee/employeeList.css" rel="stylesheet">
<script src="/erp/js/employee/employeeList.js"></script>
<link href="/erp/css/employee/appointment.css" rel="stylesheet">
<script src="/erp/js/employee/appointment.js"></script>
<link href="/erp/css/employee/mypage.css" rel="stylesheet">
<script src="/erp/js/employee/mypage.js"></script>

<link href="/erp/css/notice/list.css" rel="stylesheet">
<script src="/erp/js/notice/list.js"></script>




<title>ERP</title>
</head>
<body style="background-color: rgb(225, 235, 255)">
	<div id="admin-notice">
		<h1 id="admin-notice-title">※ 관리자 공지 ※</h1>
		<div id="admin-notice-content">실시간 공지 내용임</div>
		<div id="admin-notice-close">x</div>
	</div>
	<%@include file="/WEB-INF/views/common/sidemenu.jsp"%>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"/>
	<div id="main-content">
		<c:if test="${not empty alertMsg}">
			<script>
				alert("${alertMsg}");
			</script>
			<c:remove var="alertMsg"/>
		</c:if>
		<script>
			$(function(){
				indexNoticePage();
				employeeMypage("${loginUser.empNo}");
				//employeeDetail("${loginUser.empNo}");
			})
		</script>
		<div id="main-content-header">
		</div>
		<div id="index-content-block">
			<div id="index-content-wrap">
				<div id="employee-info-block">
				</div>
				<div id="notice-list-block">
					<h3 onclick="noticePage();">NOTICE</h3>
					<div id="index-notice-div">
						
					</div>
				</div>
			</div>
		</div>
		
		<div id="main-content-block">
		</div>
	</div>
	
    
    <script>
    	$("#admin-notice-close").click(function(){
    		$("#admin-notice").hide();
    	});
        $(".side-menu").click(function(){
            $($(this).parent()).siblings().find(".sub-menu").slideUp();
            $(this).siblings(".sub-menu").slideToggle();
        });
        $("#sidebar").mouseleave(function(){
            $(".sub-menu").slideUp();
        })
    </script>
</body>
</html>