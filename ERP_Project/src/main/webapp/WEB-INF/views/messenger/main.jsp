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
	<div id="messenger-main-page">
		<div id="messenger-wrap">
            <div id="messenger-header">

            </div>
            <div id="messenger-content-wrap">
                <div id="messenger-profile-area">
                    내정보
                </div>
                <div id="user-search-area">
                    <div id="user-search-input">
                        <input type="text">
                    </div>
                    <div id="user-search-result">
                        검색결과
                    </div>
                </div>
            </div>
			<div id="messenger-menu">
                <table id="messenger-menu-table">
                    <tbody>
                        <tr>
                            <td>사용자</td>
                            <td>채팅방</td>
                        </tr>
                    </tbody>
                </table>
			</div>
		</div>
	</div>
</body>
</html>