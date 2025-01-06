<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
	<div id="notice-list-page">
		<div id=notice-list-input-area>
			<span id="notice-list-pagingbar"> 
				<input type="hidden" id="release-startPage" value="1"> 
				<input type="text" id="release-currentPage"> / <span id="release-maxPage">1</span>
			</span> 
			<select id="notice-list-search-select">
				<option value="TITLE">제목</option>
				<option value="WRITER">작성자</option>
				<option value="DATE">날짜</option>
			</select>
			
			<input type="text" id="notice-list-search-keyword">
			<button id="release-search-btn">search</button>
		</div>
		
		
		<script>
			$(function() {
				//거래처 리스트 불러오기
				notice_list();

				//search 버튼 클릭시
				$("#release-search-btn").click(function() {
					$('#release-currentPage').val('1');
					item_release_search();
				});

				//currentPage 번호 입력시
				$('#release-currentPage').on('blur', function() {
					var num = $('#release-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					var maxPage = $('#release-maxPage').text();
					var startPage = $("#release-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#release-currentPage').val('1');
					}
					var keyword = $("#notice-list-search-keyword").val();

					if (keyword != '') {
						item_release_search();
					} else {
						item_release_list();
					}
				});
				
				//검색창 폼 변경
				$("#notice-list-search-select").change(function () {
					var val = $(this).val();
					var input = $("#notice-list-search-keyword");
					input.val('');
					if(val == "DATE"){
						input.attr("type","date");
					}else{
						input.attr("type","text");
					}
				})
			});
		</script>
		
		
		<table id="notice-list-table">
			<colgroup>
				<col style="width: 150px">
				<col style="width: 350px">
				<col style="width: 350px">
				<col style="width: 350px">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="4">등록된 공지가 없습니다.</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>