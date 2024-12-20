<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    *{
        padding : 0;
        margin : 0;
        box-sizing: border-box;
    }

    #login_wrap{
        margin: 100px auto;
        width: 500px;
        height: 600px;
        border : 8px solid navy;
        border-radius: 5px;
    	background-color: white;
        font-size: 0;
        box-shadow: 0 0 10px 4px rgb(160, 160, 160);
    }
    #login_logo_area{
        width: 100%;
        height: 50%;
        font-size: 40px;
        text-align: center;
        padding-top: 100px;
    }
    #login_input_area{
        font-size: 10px;
        width: 100%;
        height: 50%;
    }
    #login_input_box{
        height: 55%;
        text-align: center;
        padding-top: 30px;
        padding-bottom: 10px;
    }
    #login_btn_area{
        height: 45%;
        width: fit-content;
        font-size: 14px;
        margin: auto;
    }
    .login-input{
        width: 400px;
        height: 40px;
        margin: 5px 0;
        font-size: 18px;
        outline: none;
        border-radius: 3px;
        border: 1px solid lightgray;
        padding: 0 5px;
    }
    .login-btn{
        font-weight: bold;
        background-color: rgb(30, 127, 255);
        color: white;
    }
    .login-btn:hover{
        background-color: rgb(0, 110, 255);
        cursor: pointer;
    }
    #login_input_box>p{
        color: gray;
    }
    #login_input_box>button{
        width: 80%;
        height: 40px;
        margin: 5px 0;
    }
</style>
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
            프로젝트명
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