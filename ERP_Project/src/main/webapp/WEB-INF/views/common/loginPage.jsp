<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="/erp/css/common/login.css" rel="stylesheet">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"/>
	
	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg"/>
	</c:if>
    <div id="login_wrap">
        <div id="login_logo_area">
            <img src="${contextPath}/icon/user.png" id="login-icon">
            
        </div>
        <div id="login_input_area">
            <form action="${contextPath}/employee/login" method="post">
                <div id="login_input_box">
                    <p>※ 첫 로그인시 사원번호만 입력</p>
                    <input type="text" id="inputId" name="inputId" class="login-input" placeholder=" E.NO"> <br>
                    <input type="password" name="inputPwd" class="login-input" placeholder=" PASSWORD"> <br>
                </div>
                <div id="login_btn_area">
                    <input type="checkbox" name="saveId"> 아이디 저장 <br>
                    <button type="submit" class="login-input login-btn" id="testbtn">로그인</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
    	$(function(){
    		//쿠키에 데이터가 있으면 해당 아이디값을 아이디 입력란에 넣어놓고
    		//체크박스 체크해두기
    		var saveId = "${cookie.empNo.value}";
    		if(saveId!=""){
    			$("#inputId").val(saveId);
    			$("#saveId").attr("checked",true);
    		}
    	})
    </script>
</body>
</html>