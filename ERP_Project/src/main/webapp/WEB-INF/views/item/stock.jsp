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
	<div id="item-stock-page">
		<div id=item-stock-input-area>
			<span id="item-stock-pagingbar"> 
				<input type="hidden" id="stock-startPage" value="1"> 
				<input type="text" id="stock-currentPage"> / <span id="stock-maxPage">1</span>
			</span> 
			
			<input type="text" id="item-stock-search-keyword">
			<button id="stock-search-btn">search</button>
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
					var maxPage = $('#stock-maxPage').text();
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
				
				//tr선택시
				$("#item-stock-table").on("click","td",function(){
					if($(this).parent().find("td").length != 1){
						let list = [];
						$(this).parent().find("td").each(function(){
							list.push($(this).text());
						})
						item_stock_modal_info(list);
					}
				})
				
			$("#item-catagory-select-body").on("change","input", function(){
				let clist = [];
				$(".item-category-checkbox:checked").each(function(){
					var cName = $(this).parents("tr").children().eq(2).text();
					clist.push(cName);
				});
				$(".modal-input3").val(clist.join(", "));
				
			});
				//모달 숨기기
				$(".modalHide").click(function() {
					modalHide();
				})
			});
			
		</script>
		<table id="item-stock-table">
			<colgroup>
				<col style="width: 100px">
				<col style="width: 400px">
				<col style="width: 100px">
				<col style="width: 70px">
				<col style="width: 530px">
			</colgroup>
			<thead>
				<tr>
					<th>제품 코드</th>
					<th>제품명</th>
					<th>가격</th>
					<th>수량</th>
					<th>카테고리</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="5">등록된 품목이 없습니다.</td>
				</tr>
			</tbody>
		</table>

		<!-- 모달 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>모달창</h3>
				<input type="hidden" class="modal-itemCode">
				
				<table>
					<tbody>
						<tr>
							<th>제품명</th>
							<td><input type="text" class="modal-input1"></td>
						</tr>
						<tr>
							<th>가격</th>
							<td><input type="text" class="modal-input2"></td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td><input type="text" class="modal-input3" readonly></td>
						</tr>
					</tbody>
				</table>
				<br>
				<div id=item-category-area>
					<table id=item-catagory-select-head>
						<thead>
							<tr>
								<th>카테고리</th>
							</tr>
						</thead>
					</table>
					<div id="category-scroll-wrap">
						<table id=item-catagory-select-body>
							<colgroup>
								<col style="width: 5%">
								<col style="width: 10%">
								<col style="width: 85%">
							</colgroup>
						</table>
					</div>
				</div>
				
				
				<button class="modal-submit-btn" onclick="item_stock_info();">입력</button>
				
			</div>
		</div>
	</div>
</body>
</html>