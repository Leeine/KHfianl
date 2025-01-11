<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/erp/css/common/menu.css" rel="stylesheet">
</head>
<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"/>
	<%@include file="/WEB-INF/views/messenger/main.jsp"%>
	<div id="sidebar">
        <div id="user-info-menu">
            ${loginUser.empName} 님 <br>
        	
        </div>


        <ul>
        	


            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/approve.png" class="icon">
                    
                    <span class="side-menu-text">전자결재</span>
                </div>
                <ul class="sub-menu">
                    <li><a onclick="testDocument()">결재 등록</a></li>
                    <li><a onclick="approveList()">결재 목록</a></li>
                    <li><a href="">빈칸3</a></li>
                </ul>
            </li>



            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/humanManagement.png" class="icon">
                    <span class="side-menu-text">인사 관리</span>
                </div>
                <ul class="sub-menu">
                    <li><a href="">서브메뉴2</a></li>
                </ul>
            </li>



            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/storage.png" class="icon">
                    <span class="side-menu-text">제품 관리</span>
                </div>
                <ul class="sub-menu">
                    <li><a onclick="itemCustomerPage();">거래처 관리</a></li>
                    <li><a onclick="itemListPage();">재고 관리</a></li>
                    <li><a onclick="itemOrderPage();">발주 관리</a></li>
                    <li><a onclick="itemSellPage();">판매 관리</a></li>
                    <li><a onclick="itemReleasePage();">출하 조회</a></li>
                </ul>
            </li>



            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/employee.png" class="icon">
                    <span class="side-menu-text">근태 관리</span>
                </div>
                <ul class="sub-menu">
                    <li><a onclick="attemdance();">근태 관리</a></li>
                    <li><a onclick="empAttemdance();">사원 근태 관리</a></li>
                    <li><a onclick="commute();">출퇴근 관리</a></li>
                </ul>
            </li>




            <li class="menu-item">
                <div class="side-menu sidemenu-messenger">
	                <img src="${contextPath}/icon/message.png" class="icon">
                    <span class="side-menu-text">메신저</span>
	                <span id="msg-alert" class="circle">!</span>
                </div>
            </li>


            
            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/mypage.png" class="icon">
                    <span class="side-menu-text mypage-menu"><a onclick="employeeMypage();">내정보</a></span>
                </div>
            </li>
            
            <li class="menu-item admin">
                <div class="side-menu">
                    <img src="${contextPath}/icon/admin.png" class="icon">
                    <span class="side-menu-text">관리자</span>
                </div>
            </li>
        </ul>

        <div class="home">
            <img src="${contextPath}/icon/home.png" class="icon">
            <span class="side-menu-text">메인으로</span>
        </div>
        <div class="sign-out">
            <img src="${contextPath}/icon/signout.png" class="icon">
            <span class="side-menu-text">Sign out</span>
        </div>
        <script>
        	$(function(){
				webSocketConnect('${loginUser.empNo}');
        	})
        	$(".home").click(function(){
        		location.href="${contextPath}/menu/home";
        	});

            $(".sign-out").click(function(){
            	webSocketDisconnect();
            	location.href ="${contextPath}/employee/logout";
            })
            
        	$(".sidemenu-messenger").click(function(){
				$("#msg-alert").hide();
        		if($("#messenger-main-page").css("display") == "block"){
        			$("#messenger-main-page").hide();
        		}else{
        			$("#messenger-main-page").show();
        			messenger_emp_list('${loginUser.empNo}','${contextPath}');
        			
        			//메세지창 켰을때 채팅창이 켜져있는 경우(대화상대 값이 있는경우)
        			var receiver = $("#messenger-receive-user").val();
        			if(receiver != null){
        				readMessage('${loginUser.empNo}',receiver);
        			}
            		
        			
        		}
        	});
        </script>
    </div>
    
	
    
    
</body>
</html>