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
	<div id="appointment-list-page">
		<div id=appointment-input-area>
			<span id="appointment-pagingbar"> 
				<input type="hidden" id="appointment-startPage" value="1"> 
				<input type="text" id="appointment-currentPage"> / <span id="appointment-maxPage">1</span>
			</span> 
			<select id="appointment-search-select">
				<option value="NO">발령번호</option>
				<option value="NAME">사원명</option>
				<option value="DATE">발령일</option>
			</select>
			
			<input type="text" id="appointment-search-keyword">
			<button id="appointment-search-btn">search</button>
			<button class="add" onclick="modalShow();">사원 추가</button>
		</div>
		
		
		<script>
			$(function() {
				//사원 리스트 불러오기
				appointment_list();
				appointmentDeptList();
				appointmentRankList();

				//search 버튼 클릭시
				$("#appointment-search-btn").click(function() {
					$('#appointment-currentPage').val('1');
					appointment_search();
				});

				//currentPage 번호 입력시
				$('#appointment-currentPage').on('blur', function() {
					var num = $('#appointment-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					var maxPage = $('#appointment-maxPage').text();
					var startPage = $("#appointment-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#appointment-currentPage').val('1');
					}
					var keyword = $("#appointment-search-keyword").val();
					if (keyword != '') {
						appointment_search();
					} else {
						appointment_list();
					}
				});
				
				//검색창 폼 변경
				$("#appointment-search-select").change(function () {
					var val = $(this).val();
					var input = $("#appointment-search-keyword");
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
			});
		</script>
		
		
		<table id="appointment-table">
			<colgroup>
				<col style="width: 15%">
				<col style="width: 15%">
				<col style="width: 20%">
				<col style="width: 15%">
				<col style="width: 20%">
				<col style="width: 15%">
			</colgroup>
			<thead>
				<tr>
					<th>발령 번호</th>
					<th>사원명</th>
					<th>발령일</th>
					<th>발령 유형</th>
					<th>발령 부서</th>
					<th>변경 직급</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="6">기록이 없습니다.</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 신입 사원 등록 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>신입 사원 등록</h3>
				<table>
					<tbody>
						<tr>
							<th>부서</th>
							<td>
								<select id="select-dept">
								</select>
							</td>
						</tr>
						<tr>
							<th>직급</th>
							<td>
								<select id="select-rank">
								</select>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" id="modal-empName" class="modal-input"></td>
						</tr>
					</tbody>
				</table>
				<button class="modal-submit-btn" onclick="appointment_insert_employee();">등록</button>
			</div>
		</div>
	</div>
</body>
</html>