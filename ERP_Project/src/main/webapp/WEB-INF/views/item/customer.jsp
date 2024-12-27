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
	<div id="item-customer-page">
		<div id=item-customer-input-area>
			<span id="item-customer-pagingbar"> 
				<input type="hidden" id="customer-startPage" value="1"> 
				<input type="text" id="customer-currentPage"> / <span id="customer-maxPage">1</span>
			</span> 
			
			<input type="text" id="item-customer-search-keyword">
			<button id="customer-search-btn">search</button>
			<button class="add" onclick="item_customer_modal_add();">거래처 추가</button>
		</div>
		<script>
			$(function() {
				//거래처 리스트 불러오기
				item_customer_list();

				//search 버튼 클릭시
				$("#customer-search-btn").click(function() {
					$('#customer-currentPage').val('1');
					item_customer_search();
				});

				//currentPage 번호 입력시
				$('#customer-currentPage').on('blur', function() {
					var num = $('#customer-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					var maxPage = $('#customer-maxPage').text();
					var startPage = $("#customer-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#customer-currentPage').val('1');
					}
					var keyword = $("#item-customer-search-keyword").val();

					if (keyword != '') {
						item_customer_search();
					} else {
						item_customer_list();
					}
				});
				
				$("#item-customer-table").on("click","td",function(){
					let list = [];
					$(this).parent().find("td").each(function(){
						list.push($(this).text());
					})
					item_customer_modal_info(list);
				})
				
				//모달 숨기기
				$(".modalHide").click(function() {
					modalHide();
				})
			});
		</script>
		<table id="item-customer-table">
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
				<input type="hidden" class="modal-customerNo">
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
				<button class="modal-submit-btn" onclick="modal_submit();">입력</button>
			</div>
		</div>
	</div>
</body>
</html>