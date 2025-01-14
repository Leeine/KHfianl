<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
   <input type="hidden" value="${loginUser.empNo}" id="empNo">
	<div id="mypage_container">
        <header class="header">
            <h1>인사정보</h1>
        </header>
        <section class="profile-overview">
            <div class="profile-photo">
                <img src="/erp/icon/profile/10007.jpg" alt="사원 사진">
            </div>
            <div class="profile-info">
                <div class="info-row">
                    <span class="label">이름</span>
                    <span id="nameSpan" class="user-info"></span>
                </div>
                <div class="info-row">
                    <span class="label">생년월일</span>
                    <span id="birthSpan" class="user-info"></span>
                </div>
                <div class="info-row">
                    <span class="label">소속</span>
                    <span id="deptSpan" class="user-info"></span>
                </div>
                <div class="info-row">
                    <span class="label">사번</span>
                    <span id="empSpan" class="user-info">${loginUser.empNo}</span>
                </div>
                <div class="info-row">
                    <span class="label">이메일</span>
                    <span id="emailSpan" class="user-info"></span>
                </div>
                <div class="info-row">
                    <span class="label">직위</span>
                    <span id="rankSpan" class="user-info"></span>
                </div>
                <div class="info-row">
                    <span class="label">대표전화</span>
                    <span id="phoneSpan" class="user-info"></span>
                </div>
                <div class="info-row">
                    <span class="label">입사일</span>
                    <span id="joinSpan" class="user-info"></span>
                </div>
            </div>
        </section>
      
        <section class="details">
            <h2>기본 정보 수정</h2>
            <div class="detail-grid">
                <div class="detail-item">
                    <label for="hire-date">이름</label>
                    <input type="text" id="name" value="">
                </div>
                <div class="detail-item">
                    <label for="hire-date">비밀번호</label>
                    <input type="text" id="" value="관리자 문의">
                </div>
                <div class="detail-item">
                    <label for="employment-type">핸드폰</label>
                    <input type="text" id="phone" value="">
                </div>
                <div class="detail-item">
                    <label for="gender">주소</label>
                    <input type="text" id="addr" value="">
                </div>
                <div class="detail-item">
                    <label for="marital-status">이메일</label>
                    <input type="text" id="email" value="">
                </div>
                <div class="detail-item">
                    <label for="marital-status">저장</label>
                    <input type="button" id="update-mypage" value="저장" onclick="employeeUpdate('${loginUser.empNo}')">
                </div>
            </div>
        </section>
    </div>
    
    
  
   
    
   
</body>
</html>