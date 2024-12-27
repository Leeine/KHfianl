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
	<c:set var="contextPath"
		value="${pageContext.servletContext.contextPath}" />
	<div id="item-stock-page">
		<div id=item-stock-input-area>
			<span id="item-stock-pagingbar"> 
				<input type="hidden" id="stock-startPage" value="1"> 
				<input type="text" id="stock-currentPage"> / <input type="text" id="stock-maxPage" value="1" readonly>
			</span> 
			
			<input type="text" id="item-stock-search-keyword">
			<button id="stock-search-btn">search</button>
			<button class="add" onclick="modalShow();">거래처 추가</button>
		</div>
		<script>
			$(function() {
				//거래처 리스트 불러오기
				item_stock_list();

				//search 버튼 클릭시
				$("#stock-search-btn").click(function() {
					$('#stock-currentPage').val('1');
					item_stock_search();
				});

				//currentPage 번호 입력시
				$('#stock-currentPage').on('blur', function() {
					var num = $('#stock-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					var maxPage = $('#stock-maxPage').val();
					var startPage = $("#stock-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#stock-currentPage').val('1');
					}
					var keyword = $("#item-stock-search-keyword").val();

					if (keyword != '') {
						item_stock_search();
					} else {
						item_stock_list();
					}
				});

				//모달 숨기기
				$(".modalHide").click(function() {
					modalHide();
				})
			});
		</script>
		<table id="item-stock-table">
			<colgroup>
				<col style="width: 15%">
				<col style="width: 35%">
				<col style="width: 20%">
				<col style="width: 30%">
			</colgroup>
			<thead>
				<tr>
					<th>제품 코드</th>
					<th>제품명</th>
					<th>가격</th>
					<th>수량</th>
				</tr>
			</thead>
		</table>


		<!-- 제품 추가 모달 -->
		<div class="modal-overlay" id="modal">
			<div class="modal" id="draggable-modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>제품 추가</h3>
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
				<button onclick="item_stock_add();">입력</button><br>
			</div>
		</div>
	</div>
</body>
</html>