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
	<div id="employee-list-page">
		<div id=employee-input-area>
			<span id="employee-pagingbar"> 
				<input type="hidden" id="employee-startPage" value="1"> 
				<input type="text" id="employee-currentPage"> / <span id="employee-maxPage">1</span>
			</span> 
			<select id="employee-search-select">
				<option value="NO">사원번호</option>
				<option value="DEPT">부서</option>
				<option value="RANK">직급</option>
				<option value="NAME">이름</option>
				<option value="DATE">입사일</option>
			</select>
			
			<input type="text" id="employee-search-keyword">
			<button id="employee-search-btn">search</button>
		</div>
		
		
		<script>
			$(function() {
				//사원 리스트 불러오기
				employee_list();
				appointment_dept_list();
				appointment_rank_list();

				//search 버튼 클릭시
				$("#employee-search-btn").click(function() {
					$('#employee-currentPage').val('1');
					employee_search();
				});

				//currentPage 번호 입력시
				$('#employee-currentPage').on('blur', function() {
					var num = $('#employee-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					var maxPage = $('#employee-maxPage').text();
					var startPage = $("#employee-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#employee-currentPage').val('1');
					}
					var keyword = $("#employee-search-keyword").val();

					if (keyword != null) {
						employee_search();
					} else {
						employee_list();
					}
				});
				//목록에서 선택시 상세정보
				$("#employee-table").on("click","td",function(){
					if($(this).parent().find("td").length!=1){
						var empNo = $(this).parent().find("td").eq(0).text();
						employee_info(empNo);
					}
				})
				
				//검색창 폼 변경
				$("#employee-search-select").change(function () {
					var val = $(this).val();
					var input = $("#employee-search-keyword");
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
					modal_appointment_reset();
					modalHide();
				})
			});
		</script>
		
		
		<table id="employee-table">
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
					<td colspan="5">등록된 사원이 없습니다.</td>
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
				<table id="emp-info-table">
					<tbody>
						<tr>
							<th width="30%">사원번호</th>
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
				<button class="modal-submit-btn" onclick="modal_employee_appointment();">인사 발령</button>
			
			
				<table id="emp-appointment-table">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						<tr>
					</thead>
					<tbody>
						<tr>
							<th colspan="2" width="50%">
								<select id="appointment-select">
									<option value="dept">부서 이동</option>
									<option value="rank">직급 변경</option>
								</select>
							</th>
							<td colspan="2">
								<select id="appointment-dept-list">
									<option value="NULL">미선택(부서)</option>
								</select>
								<select id="appointment-rank-list">
									<option value="NULL">미선택(직급)</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<button class="appointment-btn" onclick="modal_appointment_reset();">취소</button>
				<button class="appointment-btn" id="appointment-submit-btn">등록</button>
				<script>
					$("#appointment-select").on("change",function(){
						if($(this).val()==="dept"){
							$("#appointment-dept-list").show();
							$("#appointment-rank-list").hide();
						}else if($(this).val()==="rank"){
							$("#appointment-dept-list").hide();
							$("#appointment-rank-list").show();
						}
					})
					
					$(function(){
						$("#appointment-submit-btn").click(function(){
							var select = $("#appointment-select").val();
							var empNo = $("#emp-appointment-table>thead>tr>th").eq(0).text();
							if(select === "dept"){
								var pk = $("#appointment-dept-list").val();
								appointment(select,empNo,pk);
							}else if(select === "rank"){
								var pk = $("#appointment-rank-list").val();
								appointment(select,empNo,pk);
							}
						})
					})
				</script>
			</div>
		</div>
	</div>
</body>
</html>