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
		<div id=intem-customer-input-area>
			<input type="text" id="item-customer-search-keyword">
			<button onclick="item_customer_search();">search</button>
		</div>
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
			<tbody>
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
				<tr>
			</tbody>
		</table>
	</div>
</body>
</html>