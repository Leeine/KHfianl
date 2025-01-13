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
				<option value="NO">사원번호</option>
				<option value="DEPT">부서</option>
				<option value="RANK">직급</option>
				<option value="NAME">이름</option>
				<option value="DATE">입사일</option>
			</select>
			
			<input type="text" id="appointment-search-keyword">
			<button id="appointment-search-btn">search</button>
		</div>
		
		
		<script>
			$(function() {
				//사원 리스트 불러오기
				appointment_list();

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

					if (keyword != null) {
						appointment_search();
					} else {
						appointment_list();
					}
				});
				//목록에서 선택시 상세정보
				$("#appointment-table").on("click","td",function(){
					var empNo = $(this).parent().find("td").eq(0).text();
					appointment_info(empNo);
				})
				
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
				<col style="width: 25%">
				<col style="width: 20%">
				<col style="width: 20%">
				<col style="width: 20%">
			</colgroup>
			<thead>
				<tr>
					<th>사원번호</th>
					<th>부서</th>
					<th>직급</th>
					<th>이름</th>
					<th>입사일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="5">등록된 인사 발령 기록이 없습니다.</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 사원정보 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>사원 정보</h3>
				<table>
					<tbody>
						<tr>
							<th>사원번호</th>
							<td><input type="text" id="modal-empNo" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>부서</th>
							<td><input type="text" id="modal-deptName" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>직급</th>
							<td><input type="text" id="modal-rankName" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" id="modal-empName" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>나이</th>
							<td><input type="text" id="modal-age" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>전화</th>
							<td><input type="text" id="modal-phone" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" id="modal-email" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>주소</th>
							<td><input type="text" id="modal-address" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td><input type="text" id="modal-birthday" class="modal-input" readonly></td>
						</tr>
						<tr>
							<th>입사일</th>
							<td><input type="text" id="modal-joinDate" class="modal-input" readonly></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>