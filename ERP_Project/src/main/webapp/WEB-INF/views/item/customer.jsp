<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="item-customer-page">
		<div id=item-customer-input-area>
			<span id="item-customer-pagingbar">
			<input type="hidden" id="customer-startPage" value="1">
			<input type="text" id="customer-currentPage">
			/ <input type="text" id="customer-maxPage" value="1" readonly>
			</span>
			<input type="text" id="item-customer-search-keyword">
			<button onclick="item_customer_search();">search</button>
		</div>
		<script>
			$(function(){
				//거래처 리스트 불러오기
				item_customer_list();
				
				//currentPage input 숫자만 입력되도록 설정
				//$('#customer-currentPage').on('input', function() {
				//	const value = $(this).val();
				//	const isNumber = /^\d+$/.test(value);
				//	if(!isNumber){
				//		$(this).val('');
				//	}
				//});
				//currentPage 번호 입력시
				$('#customer-currentPage').on('blur', function() {
					var num = $('#customer-currentPage').val();
					if(num==''){
						$(this).val('1');
					}
					var maxPage = $('#customer-maxPage').val();
					var startPage = $("#customer-startPage").val();
					if(num>maxPage || num<startPage){
						$('#customer-currentPage').val('1');
					}
					var keyword = $("#item-customer-search-keyword").val();
					
					if(keyword != ''){
						//console.log("작성");
						item_customer_search();
					}else{
						//console.log("빈칸");
						item_customer_list();
					}
					
				});
			});
		</script>
		<table id="item-customer-table">
			<colgroup>
				<col style="width:15%">
				<col style="width:35%">
				<col style="width:20%">
				<col style="width:30%">
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
	</div>
</body>
</html>