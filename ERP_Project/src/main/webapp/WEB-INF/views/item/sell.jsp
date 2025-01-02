<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/erp/css/item/item.css" rel="stylesheet">
</head>
<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
	<div id="item-sell-page">
		<div id=item-sell-input-area>
			<span id="item-sell-pagingbar"> 
				<input type="hidden" id="sell-startPage" value="1"> 
				<input type="text" id="sell-currentPage"> / <span id="sell-maxPage">1</span>
			</span> 
			
			<input type="text" id="item-sell-search-keyword">
			<button id="sell-search-btn">search</button>
			<button class="add" onclick="">판매 입력</button>
		</div>
		<script>
		</script>
		<table id="item-sell-table">
			<colgroup>
				<col style="width: 100px">
				<col style="width: 450px">
				<col style="width: 150px">
				<col style="width: 500px">
			</colgroup>
			<thead>
				<tr>
					<th>거래처 코드</th>
					<th>거래처명</th>
					<th>전화</th>
					<th>주소</th>
				</tr>
			</thead>
		</table>
		

		<!-- 거래처 추가 모달 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>거래처 추가</h3>
				<input type="hidden" class="modal-sellNo">
				<table>
					<tbody>
						<tr>
							<th>거래처명</th>
							<td><input type="text" class="modal-input1"></td>
						</tr>
						<tr>
							<th>전화</th>
							<td><input type="text" class="modal-input2"></td>
						</tr>
						<tr>
							<th>주소</th>
							<td><input type="text" class="modal-input3"></td>
						</tr>
					</tbody>
				</table>
				<button class="modal-submit-btn" onclick="">입력</button>
			</div>
		</div>
	</div>
</body>
</html>