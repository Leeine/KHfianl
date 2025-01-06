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
	<div id="item-sell-page">
		<div id=item-sell-input-area>
			<span id="item-sell-pagingbar"> 
				<input type="hidden" id="sell-startPage" value="1"> 
				<input type="text" id="sell-currentPage"> / <span id="sell-maxPage">1</span>
			</span> 
			<select id="item-sell-search-select">
				<option value="ITEM">품목</option>
				<option value="DATE">날짜</option>
			</select>
			
			<input type="text" id="item-sell-search-keyword">
			<button id="sell-search-btn">search</button>
			<button class="add" onclick="item_sell_modal();">판매 입력</button>
		</div>
		
		
		<script>
			$(function() {
				//거래처 리스트 불러오기
				item_sell_list();

				//search 버튼 클릭시
				$("#sell-search-btn").click(function() {
					$('#sell-currentPage').val('1');
					item_sell_search();
				});

				//currentPage 번호 입력시
				$('#sell-currentPage').on('blur', function() {
					var num = $('#sell-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					var maxPage = $('#sell-maxPage').text();
					var startPage = $("#sell-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#sell-currentPage').val('1');
					}
					var keyword = $("#item-sell-search-keyword").val();

					if (keyword != '') {
						item_sell_search();
					} else {
						item_sell_list();
					}
				});
				
				//검색창 폼 변경
				$("#item-sell-search-select").change(function () {
					var val = $(this).val();
					var input = $("#item-sell-search-keyword");
					input.val('');
					if(val == "DATE"){
						input.attr("type","date");
					}else{
						input.attr("type","text");
					}
				})
				//모달 숨기기
				$(".modalHide").click(function() {
					modalHide();
				})
			});
		</script>
		
		
		<table id="item-sell-table">
			<colgroup>
				<col style="width: 100px">
				<col style="width: 200px">
				<col style="width: 200px">
				<col style="width: 200px">
				<col style="width: 200px">
				<col style="width: 200px">
				<col style="width: 100px">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>품목</th>
					<th>수량</th>
					<th>단가</th>
					<th>금액(총)</th>
					<th>날짜</th>
					<th>출하</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="7">등록된 판매 기록이 없습니다.</td>
				</tr>
			</tbody>
		</table>
		

		<!-- 모달 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>판매 입력</h3>
				<input type="hidden" class="modal-sellNo">
				<table>
					<tbody>
						<tr>
							<th>품목</th>
							<td>
								<input type="hidden" id="modal-input-item" class="modal-input">
								<input type="text" class="modal-input-text modal-input">
								<div id="sell-item" class="modal-search-input-area"></div>
							</td>
							
						</tr>
						<tr>
							<th>수량</th>
							<td><input type="number" id="modal-input-count" class="modal-input"></td>
						</tr>
						<tr>
							<th>금액</th>
							<td><input type="number" id="modal-input-price" class="modal-input"></td>
						</tr>
					</tbody>
				</table>
				<button class="modal-submit-btn" onclick="item_sell_submit_add();">품목 추가</button>
			
			
			<script>
				$(function(){
					let timeout;
					//사용자 입력 0.2초후(재입력시 초기화) 검색된 리스트 보여주기
					$(".modal-input-text").on("input",function(){
						var keyword = $(this);
						//입력 감지시 timeout 초기화
					    clearTimeout(timeout);
					    
					    timeout = setTimeout(function() {
					    	if(keyword.val()==''){
								$(this).siblings("input[type=hidden]").val('');
					    		keyword.siblings($(".modal-search-input-area")).hide();
							}else{
								item_sell_modal_search(keyword.val());
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
			
			<table id="item-sell-submit-table">
					<colgroup>
						<col style="width: 10%">
						<col style="width: 30%">
						<col style="width: 30%">
						<col style="width: 30%">
					</colgroup>
					<thead>
						<tr>
							<th colspan="4">판매 목록</th>
						</tr>
						<tr>
							<th>삭제</th>
							<th>제품 코드</th>
							<th>수량</th>
							<th>금액</th>
						</tr>
					</thead>
				</table>
				<div id="item-sell-submit-list-area">
					<table id="item-sell-submit-list">
						<colgroup>
							<col style="width: 10%">
							<col style="width: 30%">
							<col style="width: 30%">
							<col style="width: 30%">
						</colgroup>
						<tbody>
						</tbody>
					</table>
				</div>
				<button class="modal-submit-btn" onclick="modal_sell_submit();">입력</button>
				
				<script>
					$(function(){
						$("#item-sell-submit-list").on("click", ".col-delete", function(){
							$(this).closest("tr").remove();
						})
					})
					$(function(){
						$("#item-sell-table").on("click", ".sell_release", function(){
							
							if (confirm("출하시키겠습니까?")) {
								var itemCode = $(this).closest("tr").find("input[type=hidden]").val();
								var sellCount = $(this).closest("tr").find(".sell-count").text();
								var sellNo = $(this).closest("tr").find(".sell-no").text();
								sell_release(sellNo,itemCode,sellCount);
							} else {
							    alert("취소되었습니다.");
							}
						})
					})
				</script>
			</div>
		</div>
	</div>
</body>
</html>