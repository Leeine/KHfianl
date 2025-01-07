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
				<input type="hidden" id="notice-startPage" value="1"> 
				<input type="text" id="notice-currentPage"> / <span id="notice-maxPage">1</span>
			</span> 
			<select id="notice-list-search-select">
				<option value="TITLE">제목</option>
				<option value="WRITER">작성자</option>
				<option value="DATE">날짜</option>
			</select>
			
			<input type="text" id="notice-list-search-keyword">
			<button id="notice-search-btn">search</button>
			<button class="add" onclick="item_customer_modal_add();">공지작성</button>
		</div>
		
		
		<script>
			$(function() {
				//공지 리스트 불러오기
				notice_list();

				//search 버튼 클릭시
				$("#notice-search-btn").click(function() {
					$('#notice-currentPage').val('1');
					item_notice_search();
				});

				//currentPage 번호 입력시
				$('#notice-currentPage').on('blur', function() {
					var num = $('#notice-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					var maxPage = $('#notice-maxPage').text();
					var startPage = $("#notice-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#notice-currentPage').val('1');
					}
					var keyword = $("#notice-list-search-keyword").val();

					if (keyword != '') {
						notice_search();
					} else {
						notice_list();
					}
				});

				//목록에서 선택시 공지 내용보기
				$("#notice-list-table").on("click","td",function(){
					var noticeNo = $(this).parents("tr").find("td").eq(0).text();
					notice_modal_detail(noticeNo);
				})
				
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
				
				//모달 숨기기
				$(".modalHide").click(function() {
					modalHide();
				})
			});
		</script>
		
		
		<table id="notice-list-table">
			<colgroup>
				<col style="width: 150px">
				<col style="width: 350px">
				<col style="width: 200px">
				<col style="width: 150px">
				<col style="width: 350px">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="5">등록된 공지가 없습니다.</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 공지 내용 보기 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>NOTICE</h3>
				<input type="hidden" class="modal-customerNo">
				<table>
					<tbody>
						<tr>
							<th>번호</th>
							<td>
								<input type="text" id="modal-noticeNo" class="modal_data">
							</td>
							<th>조회수</th>
							<td>
								<input type="text" id="modal-noticeCount" class="modal_data">
							</td>
							<th>작성자</th>
							<td>
								<input type="text" id="modal-noticeWriter" class="modal_data">
							</td>
						</tr>
						<tr>
							<th colspan="2">작성일</th>
							<td colspan="4">
								<input type="text" id="modal-createDate" class="modal_data">
							</td>
						</tr>
						<tr>
							<th colspan="2">제목</th>
							<td colspan="4">
								<input type="text" id="modal-noticeTitle" class="modal_data">
							</td>
						</tr>
						<tr>
							<th colspan="2">내용</th>
							<td colspan="4">
								<input type="text" id="modal-noticeContent" class="modal_data">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>