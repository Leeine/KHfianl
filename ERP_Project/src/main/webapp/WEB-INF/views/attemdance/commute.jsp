<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>
	<%@include file="/WEB-INF/views/common/sidemenu.jsp"%>
	<c:set var="contextPath"
		value="${pageContext.servletContext.contextPath}" />

	<div id="attemdance-commute-page">
		<div id="main-content">
			<div id="attemdance-content-block">

				<div id="loginUserDiv">
					<h3>${loginUser.empName }님</h3>
					<button id='comInBtn' value=''></button>
				</div>
				<div align="center">
					<div id="userCommuteDiv">
						<table class="comTable" id="userWeekTable">
							<thead>
								<tr>
									<th colspan="2">월요일</th>
									<th colspan="2">화요일</th>
									<th colspan="2">수요일</th>
									<th colspan="2">목요일</th>
									<th colspan="2">금요일</th>
									<th colspan="2">토요일</th>
									<th colspan="2">일요일</th>
								</tr>
								<tr id="comSet">
								</tr>
							</thead>
							<tbody>
								<tr></tr>
							</tbody>
						</table>
					</div>
				</div>

				<script>
				$(function(){
					empWeek();
					comInBtn();
				});
				
				//유저 일주일 출근
				function empWeek(){
					var empNo = ${loginUser.empNo };
					
					$.ajax({
						url : "/erp/att/empWeek",
						data : {
							empNo : empNo
						},
						success : function(list){
							
							str = "";
							comSet = "";
							
							for(var uw of list){
								
								if(!uw){
									str += "<td></td><td></td>";
									continue;
								}
								
								str += "<td>"+ uw.comStartChar +"</td>";
								
								if(uw.comEndChar == null){
									str += "<td></td>";
								}else{
									str += "<td>"+ uw.comEndChar +"</td>";
								}
							}
								
							for(i=1; i<=7; i++){
								comSet += "<td>출근</td>"
										+ "<td>퇴근</td>";
							}
							
							$("#userWeekTable tbody tr").html(str);
							$("#userWeekTable thead #comSet").html(comSet);
						},
						error : function(){
							console.log("통신 오류");
						}
					});
				}
				
				function comInBtn(){
					var empNo = ${loginUser.empNo };
					
					$.ajax({
						url : "/erp/att/comInBtn",
						data : {
							empNo : empNo
						},
						success : function(result){
							var str = "";
							
							if(result == 'NNNNY'){
								str += "출근";
								$("#comInBtn").val("on");
							}else{
								str += "퇴근";
								$("#comInBtn").val("off");
							}
							
							$("#comInBtn").text(str);
							todayComCheck();
						},
						error : function(){
							console.log("통신 오류");
						}
					});
				}
				
				function todayComCheck(){
					var empNo = ${loginUser.empNo };
					
					$.ajax({
						url : "/erp/att/todayComCheck",
						data : {
							empNo : empNo
						},
						success : function(result){
							if(result == "NNNNY"){
								 $("#comInBtn").show();
							}else{
								$("#comInBtn").hide();
							}
						},
						error : function(){
							console.log("통신 오류");
						}
					});
				}
				
				$("#loginUserDiv").on("click", "#comInBtn", function(){
					var empNo = ${loginUser.empNo };
					var btnVal = $("#comInBtn").val();
					
					$.ajax({
						url : "/erp/att/insertCom",
						type : "POST",
						data : {
							empNo : empNo,
							btnVal : btnVal
						},
						success : function(result){
							if(result == "NNNNY"){
								alert("등록이 완료되었습니다.");
								empWeek();
								comInBtn();
							}else{
								alert("등록에 실패하였습니다.");
							}
							comList();
						},
						error : function(){
							console.log("통신 오류");
						}
					});
				});
				
			</script>

				<div id="searchDiv">
					<div id="inputDate">
						<input type="date" id="inputDate1"> ~ <input type="date"
							id="inputDate2">
					</div>
					<div>
						<div id="inputSearchData">
							<select id="condition">
								<option value=null selected>===</option>
								<option value="empNo">사번</option>
								<option value="empName">사원명</option>
								<option value="deptName">부서</option>
							</select> <input type="text" id="keyword">
							<button class='btn btn-secondary btn-sm' onclick="comSearch();">검색</button>
							<button class='btn btn-secondary btn-sm' onclick="reset();">초기화</button>
						</div>
					</div>
				</div>

				<div>
					<table class="comTable" id="comListTable">
						<thead>
							<tr>
								<th id="daysc" data-value="desc">일자 ▲</th>
								<th>사원명</th>
								<th>부서명</th>
								<th>출근시간</th>
								<th>퇴근시간</th>
							</tr>
						</thead>
						<tbody>
							<tr></tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<script>
		$(function(){
			comList();
		});
		
		function comList(){
			var daysc = $("#daysc").data("value");
			
			$.ajax({
				url : "/erp/att/comList",
				data : {
					daysc : daysc
				},
				success : function(list){
					var str = "";
					
					for(var com of list){
						str += "<tr>"
							 + "<td>"+ com.comStart +"</td>"
							 + "<td>"+ com.empName +"</td>";
						
						if(com.deptName == "미배치"){
							str += "<td></td>";
						}else{
							str += "<td>"+ com.deptName +"</td>";
						}
						
						str += "<td>"+ com.comStartChar +"</td>";
							 
						if(com.comEndChar == null){
							str += "<td></td>";
						}else{
							str += "<td>"+ com.comEndChar +"</td>";
						}
						
						str += "</tr>"
					}
					
					$("#comListTable tbody").html(str);
				},
				error : function(){
					console.log("통신 오류");
				}
			});
			
		}
		
		$("#daysc").click(function(){
			
			var daysc = $(this).data("value");
			
			if (daysc == "desc") {
	            $(this).data("value", "asc"); // data-value 업데이트
	            $(this).text("일자 ▼"); // 텍스트 업데이트
	        } else {
	            $(this).data("value", "desc");
	            $(this).text("일자 ▲");
	        }
			
			var condition = $("#condition").val();
			var keyword = $("#keyword").val();
			var inputDate1 = $("#inputDate1").val();
			var inputDate2 = $("#inputDate2").val();
			
			if(condition == "null" && keyword == "" &&
			   inputDate1 == "" && inputDate2 == ""){
				comList();
			}else{
				comSearch();
			}
			
		});
		
		function comSearch(){
			var condition = $("#condition").val();
			var keyword = $("#keyword").val();
			var inputDate1 = $("#inputDate1").val();
			var inputDate2 = $("#inputDate2").val();
			var daysc = $("#daysc").data("value");
			
			$.ajax({
				url : "/erp/att/comSearchList",
				data : {
					condition : condition,
					keyword : keyword,
					inputDate1 : inputDate1,
					inputDate2 : inputDate2,
					daysc : daysc
				},
				success : function(list){
					var str = "";
					
					if(list == ""){
						str += "<tr>"
							 + "<td colspan='5' align='center'>조회된 내용이 없습니다.</td>";
						
						$("#comListTable tbody").html(str);
						return;
					}
					
					for(var com of list){
						str += "<tr>"
							 + "<td>"+ com.comStart +"</td>"
							 + "<td>"+ com.empName +"</td>";
						
						if(com.deptName == "미배치"){
							str += "<td></td>";
						}else{
							str += "<td>"+ com.deptName +"</td>";
						}
						
						str += "<td>"+ com.comStartChar +"</td>";
							 
						if(com.comEndChar == null){
							str += "<td></td>";
						}else{
							str += "<td>"+ com.comEndChar +"</td>";
						}
						
						str += "</tr>"
					}
					
					$("#comListTable tbody").html(str);
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		//초기화
		function reset(){
			$("#condition").val("null");
		    $("#inputDate1").val("");
		    $("#inputDate2").val("");
		    $("#keyword").val("");
		    comList();
		}
		
	</script>
	</div>
</body>
</html>