<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- 부트스트랩에서 제공하고 있는 스타일 -->
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
			height : 80vh;
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
		</div>
		
		
		<div id="main-content-block">
			<h3>사원 근태</h3>
				<table id="empAttList" class="table table-hover" align="center">
		        	<thead>
		            	<tr>
		            		<th>근태일자</th>
		                	<th>사원명</th>
		                	<th>근태</th>
		                	<th>근태수</th>
		                	<th>사용</th>
		                	<th></th>
		            	</tr>
			       	</thead>
			    	<tbody>
		        	</tbody>
				</table>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insrtEmpAttForm">항목추가</button>
		</div>
		
		<div class="modal fade" id="insrtEmpAttForm">
		        <div class="modal-dialog modal-dialog-centered">
		            <div class="modal-content">
		
		                <!-- Modal Header -->
		                <div class="modal-header">
		                    <h4 class="modal-title">근태 추가</h4>
		                    <button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		
		                <form action="empAttInsert" method="post">
		                    <!-- Modal body -->
		                    <div class="modal-body">
		                    	<table align="center">
					            	<tr>
					            		<th>근태일자</th>
					            		<td>
						                	<select id="timeY">
						            			<option value="2025">2025</option>
						            			<option value="2024">2024</option>
						            			<option value="2023">2023</option>
						            			<option value="2022">2022</option>
						            			<option value="2021">2021</option>
						            			<option value="2020">2020</option>
						            		</select>
						            		-
						            		<select id="timeM">
						            			<option value="01">1</option>
						            			<option value="02">2</option>
						            			<option value="03">3</option>
						            			<option value="04">4</option>
						            			<option value="05">5</option>
						            			<option value="06">6</option>
						            			<option value="07">7</option>
						            			<option value="08">8</option>
						            			<option value="09">9</option>
						            			<option value="10">10</option>
						            			<option value="11">11</option>
						            			<option value="12">12</option>
						            		</select>
						            		-
						            		<input type="number" id="timeD" required>
						            		<input type="hidden" name="empAttTime" id="empAttTime">
					            		</td>
					            	</tr>
					            	<tr>
					            		<th>사원명</th>
					            		<td>
					            			<input type="hidden" name="empNo" id="empNo">
					            			<input type="text" name="empName" id="empName" readonly  data-toggle="modal" data-target="#empList">
					            		</td>
					            	</tr>
					            	<tr>
					            		<th>근태</th>
					            		<td>
					            			<select name="attCode" id="attCode">
											</select>
					            		</td>
					            	</tr>
					            	<tr>
					            		<th>근태수</th>
					            		<td><input type="number" name="empAttCount"></td>
					            	</tr>
					            	<tr>
					            		<th></th>
					            		<td></td>
					            	</tr>
						    	</table>
		                    </div>
		                    <!-- Modal footer -->
		                    <div class="modal-footer" align="center">
		                        <button type="submit" id="empAttInsert" class="btn btn-primary">추가하기</button>
		                    </div>
		                </form>
		            </div>
				</div>
		</div>
		
		<div class="modal fade" id="empList">
		        <div class="modal-dialog modal-dialog-centered">
		            <div class="modal-content">
		
		                <!-- Modal Header -->
		                <div class="modal-header">
		                    <h4 class="modal-title">사원 목록</h4>
		                    <button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		                <!-- Modal body -->
		                <div class="modal-body">
		                    <table align="center" class="table table-hover" id="empListTable">
		                    	<thead>
		                    		<tr>
						            	<th>사원코드</th>
						            	<th>사원명</th>
						            	<th>부서</th>
						            	<th>남은 수</th>
						            </tr>
		                    	</thead>
		                    	<tbody>
		                    	
		                    	</tbody>
							</table>
		            	</div>
		            </div>
				</div>
		</div>
		
	</div>

	
    
	
	<script>
	
		$(function(){
			empAttList();
			optionList();
			empList();
		});
		
		function empAttList(){
			$.ajax({
				url : "empAttList",
				success : function(list){
					//console.log(list);
					
					var str = "";
					
					for(var att of list){
						str += "<tr>"
							 + "<td>"+ att.empAttTime +"</td>"
							 + "<td data-value='"+ att.empNo +"'>"+ att.empName +"</td>"
							 + "<td data-value='"+ att.attCode +"'>"+ att.attName +"</td>"
							 + "<td data-value='"+ att.empAttCount +"'>"+ att.empAttCount +"</td>"
							 + "<td>";
						
						if(att.empAttState == null){
							str += "</td>" + "<td>";
						}else{
							str += att.empAttState +"</td>" + "<td>";
						}
							 
						
						if(att.empAttState == 'Y'){
							str += "<button class='btn btn-secondary btn-sm attUpdate'>중지</button>";
						}else if(att.empAttState == 'N'){
							str += "<button class='btn btn-secondary btn-sm attUpdate2'>사용</button>";
						}else{
							str += "<button class='btn btn-secondary btn-sm attUpdate3'>확인</button>";
						}
						
						str += "<button  class='btn btn-danger btn-sm attDelete'>삭제</button>"
							 + "</td>"
							 + "</tr>";
					}
					$("#empAttList tbody").html(str);
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		function optionList(){
			$.ajax({
				url : "attOptList",
				success : function(list){
					
					var str = "";
					
					for (var opt of list){
						str += "<option value='"+ opt.attCode +"'>" + opt.attName + "</option>";
					}
					
					$("#attCode").html(str);
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		//사원 목록 조회
		function empList(){
			$.ajax({
				url : "empList",
				success : function(list){
					var str = "";
					
					for(var emp of list){
						str += "<tr>"
							 + "<td>"+ emp.empNo +"</td>"
							 + "<td>"+ emp.empName +"</td>";
							 
						if(emp.deptCode == "null"){
							str += "<td>"+ emp.deptCode +"</td>";
						}else{
							str += "<td></td>";
						}
						
						str += "<td>"+ emp.vacation +"</td>"
							 + "</tr>";
					}
					
					$("#empListTable tbody").html(str);
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		//사원 값 넣기
		$("#empListTable").on("click","tbody tr", function(){
			
			var empNo = $(this).find("td:nth-child(1)").text();
			var empName = $(this).find("td:nth-child(2)").text();
			
			$("#empNo").val(empNo);
			$("#empName").val(empName);
			
			$("#empList").modal("hide");
		});
		
		//근태 일자
		$("#empAttInsert").click(function(){
			var timeY = $("#timeY").val();
			var timeM = $("#timeM").val();
			var timeD = $("#timeD").val();
			
			var empAttTime = timeY + "-" + timeM  + "-" + timeD;
			
			$("#empAttTime").val(empAttTime);
			
		});
		
		//근태 항목 삭제
		$("#empAttList").on("click","tbody>tr .attDelete",function(){
				
			var tr = $(this).closest("tr");
			var empAttTime = tr.find("td:nth-child(1)").text();
			var empNo = tr.find("td:nth-child(2)").data("value");
			var attCode = tr.find("td:nth-child(3)").data("value");
			
			if (confirm("복구가 불가능합니다. 정말 삭제하시겠습니까?")) {
		        $.ajax({
		            url: "empAttDelete",
		            method: "post",
		            data: {
		            	empAttTime : empAttTime,
		            	empNo : empNo,
		            	attCode : attCode
		            },
		            success: function(result) {
		                if (result == "NNNNY") {
		                    alert("삭제가 완료되었습니다.");
		                    empAttList();
		                } else {
		                    alert("삭제 실패");
		                }
		            },
		            error: function() {
		                console.log("통신 오류");
		            }
		        });
		    }
		});
		
		//근태 확인
		$("#empAttList").on("click","tbody>tr .attUpdate3",function(){
			
			var tr = $(this).closest("tr");
			var empAttTime = tr.find("td:nth-child(1)").text();
			var empNo = tr.find("td:nth-child(2)").data("value");
			var attCode = tr.find("td:nth-child(3)").data("value");
			var empAttCount = tr.find("td:nth-child(4)").data("value");
			
			if (confirm("확인 처리를 하시겠습니까?")) {
		        $.ajax({
		            url: "empAttUpdate",
		            method: "post",
		            data: {
		            	empAttTime : empAttTime,
		            	empNo : empNo,
		            	attCode : attCode,
		            	empAttCount : empAttCount
		            },
		            success: function(result) {
		                if (result == "NNNNY") {
		                    alert("완료되었습니다.");
		                    empAttList();
		                    empList();
		                } else {
		                    alert("실패");
		                }
		            },
		            error: function() {
		                console.log("통신 오류");
		            }
		        });
		    }
		});
		
		$("#empAttList").on("click","tbody>tr .attUpdate2",function(){
			
			var tr = $(this).closest("tr");
			var empAttTime = tr.find("td:nth-child(1)").text();
			var empNo = tr.find("td:nth-child(2)").data("value");
			var attCode = tr.find("td:nth-child(3)").data("value");
			var empAttCount = tr.find("td:nth-child(4)").data("value");
			
			if (confirm("해당 항목을 사용하시겠습니까?")) {
		        $.ajax({
		            url: "empAttUpdate",
		            method: "post",
		            data: {
		            	empAttTime : empAttTime,
		            	empNo : empNo,
		            	attCode : attCode,
		            	empAttCount : empAttCount
		            },
		            success: function(result) {
		                if (result == "NNNNY") {
		                    alert("완료되었습니다.");
		                    empAttList();
		                    empList();
		                } else {
		                    alert("실패");
		                }
		            },
		            error: function() {
		                console.log("통신 오류");
		            }
		        });
		    }
		});
		
		$("#empAttList").on("click","tbody>tr .attUpdate",function(){
			
			var tr = $(this).closest("tr");
			var empAttTime = tr.find("td:nth-child(1)").text();
			var empNo = tr.find("td:nth-child(2)").data("value");
			var attCode = tr.find("td:nth-child(3)").data("value");
			var empAttCount = tr.find("td:nth-child(4)").data("value");
			
			if (confirm("사용을 중지하시겠습니까?")) {
		        $.ajax({
		            url: "empAttUpdate2",
		            method: "post",
		            data: {
		            	empAttTime : empAttTime,
		            	empNo : empNo,
		            	attCode : attCode,
		            	empAttCount : empAttCount
		            },
		            success: function(result) {
		                if (result == "NNNNY") {
		                    alert("완료되었습니다.");
		                    empAttList();
		                    empList();
		                } else {
		                    alert("실패");
		                }
		            },
		            error: function() {
		                console.log("통신 오류");
		            }
		        });
		    }
		});
		
	</script>
	
	
</body>
</html>