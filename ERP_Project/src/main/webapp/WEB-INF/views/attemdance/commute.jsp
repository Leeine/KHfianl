<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
	 <style>
	 	body {
    		background-color: rgb(225, 235, 255);
	    }
	    #main-content-header{
	    	margin : 30px;
	    	width : 93%;
	    	height : 100px;
	    	border-radius : 20px;
			background-color: white;
	    }
		#main-content{
			margin-left : 60px;
		}
		#main-content-block{
			margin : 30px;
			padding : 1px 15px;
			background-color: white;
			border-radius: 20px;
			width : 93%;
		}
		
	    table tbody tr {
	      height: 10px;
	    }
	    
	    #userCommuteDiv {
		    overflow: auto;
	  		white-space: nowrap;
	  		margin-bottom: 20px;
	    }
	    
	    #searchDiv{
	    	margin-top : 30px;
	    	margin-bottom: 10px;
	    }
	    
	    h4 {
	    	display: inline-block;
	    }
	    #loginUserDiv {
	    	padding: 15px 0px 15px 0px;
	    }
	    #comInBtn {
	    	display: inline-block;
	    	float: right;
	    }
	    
	    #inputDate {
	    	margin-bottom: 5px;
	    }
	    
	    #comListTable tbody tr:hover {
		    background-color: #DDE5FF;
		}
	    
	 </style>

</head>
<body>
	<%@include file="/WEB-INF/views/common/sidemenu.jsp"%>
	<%@include file="/WEB-INF/views/attemdance/modal.jsp"%>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"/>
	<div id="main-content">
		<c:if test="${not empty alertMsg}">
			<script>
				alert("${alertMsg}");
			</script>
			<c:remove var="alertMsg"/>
		</c:if>
		
		<div id="main-content-header">
			<h3>출퇴근 관리</h3>
		</div>
		
		<div id="main-content-block">
			<div>
				<div id="loginUserDiv">
					<h4>${loginUser.empName } 님</h4>
					<button class='btn btn-primary btn-sm' id='comInBtn' value=''></button>
				</div>
				<div id="userCommuteDiv">
					<table class="table table-bordered table-sm" id="userWeekTable">
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
						url : "empWeek",
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
						url : "comInBtn",
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
						url : "todayComCheck",
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
						url : "insertCom",
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
					<input type="date" id="inputDate1"> ~ <input type="date" id="inputDate2">
				</div>
				<select id="condition">
					<option value=null selected>===</option>
					<option value="empNo">사번</option>
					<option value="empName">사원명</option>
					<option value="deptName">부서</option>
				</select>
				<input type="text" id="keyword">
				<button class='btn btn-secondary btn-sm' onclick="comSearch();">검색</button>
			    <button class='btn btn-secondary btn-sm' onclick="reset();">초기화</button>
		    </div>
		    
			<table class="table table-sm table-bordered" align="center" id="comListTable">
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
	
	<script>
		$(function(){
			comList();
		});
		
		function comList(){
			var daysc = $("#daysc").data("value");
			
			$.ajax({
				url : "comList",
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
				url : "comSearchList",
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
</body>
</html>