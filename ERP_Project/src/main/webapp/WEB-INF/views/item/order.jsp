<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="/erp/css/item/item.css" rel="stylesheet">
</head>
<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
	<div id="item-order-page">
		<div id=item-order-input-area>
			<span id="item-order-pagingbar"> 
				<input type="hidden" id="order-startPage" value="1"> 
				<input type="text" id="order-currentPage"> / <span id="order-maxPage">1</span>
			</span>
			<select id="item-order-search-select">
				<option value="ALL">전체</option>
				<option value="NO">발주번호</option>
				<option value="CUSTOMER">거래처</option>
				<option value="ITEM">제품명</option>
				<option value="DATE">날짜</option>
				<option value="EMP">담당자</option>
			</select>
			<input type="text" id="item-order-search-keyword">
			<button id="order-search-btn">search</button>
			<button class="add" onclick="modalShow();">발주서 작성</button>
		</div>
		<script>
			$(function() {
				item_order_list();

				//search 버튼 클릭시
				$("#order-search-btn").click(function() {
					$('#order-currentPage').val('1');
					item_order_search();
				});

				$("#order-test").click(function() {
					console.log($("#item-order-search-keyword").val());
				});

				//currentPage 번호 입력시
				$('#order-currentPage').on('blur', function() {
					var num = $('#order-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					var maxPage = $('#order-maxPage').text();
					var startPage = $("#order-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#order-currentPage').val('1');
					}
					var keyword = $("#item-order-search-keyword").val();

					if (keyword != '') {
						item_order_search();
					} else {
						item_order_list();
					}
				});
				$("#item-order-search-select").change(function () {
					var val = $(this).val();
					var input = $("#item-order-search-keyword");
					input.val('');
					if(val == "DATE"){
						input.attr("type","date");
					}else{
						input.attr("type","text");
					}
				})
				//모달 숨기기
				$(".modalHide").click(function() {
					$(".modal-input").val('');
					modalHide();
				})
				
				$(".calc").on("input",function(){
					var count = $("#modal-input-count").val();
					var amount = $("#modal-input-amount").val();
					if(count != 0 && amount != 0){
						$("#modal-input-price").val(count * amount);
					}else{
						$("#modal-input-price").val('')
					}
				});
			});
		</script>
		<table id="item-order-table">
			<colgroup>
				<col style="width: 100px">
				<col style="width: 300px">
				<col style="width: 300px">
				<col style="width: 100px">
				<col style="width: 100px">
				<col style="width: 200px">
				<col style="width: 100px">
			</colgroup>
			<thead>
				<tr>
					<th>발주번호</th>
					<th>거래처</th>
					<th>품목</th>
					<th>수량</th>
					<th>금액(합계)</th>
					<th>날짜</th>
					<th>작성자</th>
				</tr>
			</thead>
		</table>
		

		<!-- 모달 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>발주서 작성</h3>
				<input type="hidden" class="modal-orderNo">
				<table>
					<tbody>
						<tr>
							<th>거래처</th>
							<td>
								<input type="hidden" id="modal-input-customer" class="modal-input">
								<input type="text" class="modal-input-text modal-input">
								<div id="order-customer" class="modal-search-input-area"></div>
							</td>
						</tr>
						<tr>
							<th>품목</th>
							<td>
								<input type="hidden" id="modal-input-item" class="modal-input">
								<input type="text" class="modal-input-text modal-input">
								<div id="order-item" class="modal-search-input-area"></div>
							</td>
						</tr>
						<tr>
							<th>수량</th>
							<td>
								<input type="number" id="modal-input-count" class="calc modal-input">
							</td>
						</tr>
						<tr>
							<th>단가</th>
							<td>
								<input type="number" id="modal-input-amount" class="calc modal-input">
							</td>
						</tr>
						<tr>
							<th>금액(총)</th>
							<td>
								<input type="text" id="modal-input-price" class="modal-input" readonly>
							</td>
						</tr>
						<tr>
							<th>담당자</th>
							<td>
								<input type="hidden" id="modal-input-employee" value="${loginUser.empNo}">
								<input type="text" value="${loginUser.empName}" readonly>
							</td>
						</tr>
					</tbody>
				</table>
				<button class="modal-submit-btn" onclick="item_order_submit_add();">품목 추가</button>
				
				<script>
					$(function(){
						let timeout;
						//사용자 입력 0.2초후(재입력시 초기화) 검색된 리스트 보여주기
						$(".modal-input-text").on("input",function(){
							var category = $(this).closest("tr").find("th").text();
							var keyword = $(this);
							//입력 감지시 timeout 초기화
						    clearTimeout(timeout);
						    
						    timeout = setTimeout(function() {
						    	if(keyword.val()==''){
									$(this).siblings("input[type=hidden]").val('');
						    		keyword.siblings($(".modal-search-input-area")).hide();
								}else{

									if(category == "거래처"){
										item_order_modal_search(keyword.val(),"customer");
									}else if(category == "품목"){
										item_order_modal_search(keyword.val(),"item");
									}
									keyword.siblings($(".modal-search-input-area")).show();
								}
						    }, 200); // 200ms = 0.2초
						})
						
						//focus 해제시 box 숨기기
						$(".modal-input-text").blur(function(){	
					    	if($(this).val()==''){
								$(this).siblings("input[type=hidden]").val('');
					    	}
							setTimeout(function(){								
								$(".modal-search-input-area").hide();
							},200);
						})
					})
				</script>
				<script>
					$(function(){
						//추천 검색어 클릭시 검색어로 입력 후 box 숨기기
						$(".modal-search-input-area").on("click", ".suggested_items", function() {
							$(this).closest("tr").find("input[type=hidden]").val($(this).find("input").val());
							$(this).closest("tr").find("input[type=text]").val($(this).text());
						})
					})
				</script>
				
				
				
				
				
				<table id="item-order-submit-table">
					<colgroup>
						<col style="width: 10%">
						<col style="width: 15%">
						<col style="width: 15%">
						<col style="width: 20%">
						<col style="width: 20%">
						<col style="width: 20%">
					</colgroup>
					<thead>
						<tr>
							<th colspan="6">발주 목록</th>
						</tr>
						<tr>
							<th>삭제</th>
							<th>거래처</th>
							<th>품목</th>
							<th>수량</th>
							<th>금액</th>
							<th>작성자</th>
						</tr>
					</thead>
				</table>
				<div id="item-order-submit-list-area">
					<table id="item-order-submit-list">
						<colgroup>
							<col style="width: 10%">
							<col style="width: 15%">
							<col style="width: 15%">
							<col style="width: 20%">
							<col style="width: 20%">
							<col style="width: 20%">
						</colgroup>
						<tbody>
						</tbody>
					</table>
				</div>
				<button class="modal-submit-btn" onclick="modal_submit();">발주</button>
				
				<script>
					$(function(){
						$("#item-order-submit-list").on("click", ".col-delete", function(){
							$(this).closest("tr").remove();
						})
					})
				</script>
				
			</div>
		</div>
	</div>
</body>
</html>