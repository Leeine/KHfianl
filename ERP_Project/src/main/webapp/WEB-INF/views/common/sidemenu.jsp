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
	
	<div id="sidebar">
        <div id="user-info-menu">
            ${loginUser.empName} 님
        </div>


        <ul>


            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/approve.png" class="icon">
                    
                    <span class="side-menu-text">전자결재</span>
                </div>
                <ul class="sub-menu">
                    <li><a href="">서브메뉴1</a></li>
                    <li><a href="">서브메뉴1</a></li>
                    <li><a href="">서브메뉴1</a></li>
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
                    <li><a onclick="">판매 관리</a></li>
                    <li><a onclick="">출하 조회</a></li>
                </ul>
            </li>



            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/employee.png" class="icon">
                    <span class="side-menu-text">근태 관리</span>
                </div>
                <ul class="sub-menu">
                    <li><a href="">서브메뉴4</a></li>
                </ul>
            </li>




            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/message.png" class="icon">
                    <span class="side-menu-text">메신저</span>
                </div>
                <ul class="sub-menu">
                    <li><a href="">서브메뉴4</a></li>
                </ul>
            </li>


            
            <li class="menu-item">
                <div class="side-menu">
                    <img src="${contextPath}/icon/mypage.png" class="icon">
                    <span class="side-menu-text">마이페이지</span>
                </div>
                <ul class="sub-menu">
                    <li><a href="">서브메뉴4</a></li>
                </ul>
            </li>
            
            <li class="menu-item admin">
                <div class="side-menu">
                    <img src="${contextPath}/icon/admin.png" class="icon">
                    <span class="side-menu-text">관리자</span>
                </div>
            </li>
        </ul>


        <div class="sign-out">
            <img src="${contextPath}/icon/signout.png" class="icon">
            <span class="side-menu-text">Sign out</span>
        </div>
    </div>
    
    
    
</body>
</html>