<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="/erp/css/common/modal.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


</head>
<body>
	<%@include file="/WEB-INF/views/common/sidemenu.jsp"%>

	<c:set var="contextPath"
		value="${pageContext.servletContext.contextPath}" />
		
	<div id="attemdance-emp-page">
		<div id="main-content">
			<div id="attemdance-content-block">
				<div id="userDiv">
					<h3>${loginUser.empName }님</h3>
					<p>404</p>
				</div>

				<div id="empAttListDiv">
					<div id="inputDate">
						<input type="date" id="inputDate1"> ~ <input type="date" id="inputDate2">
						<button onclick="selectAttDate();">검색</button>
						<button onclick="reset();">초기화</button>
					</div>

					<table class="empAttTable" id="empAttList">
						<thead>
							<tr>
								<th>근태일자</th>
								<th>사원명</th>
								<th>근태</th>
								<th>근태수</th>
								<th colspan="2">사용</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>

					<div align="center">
						<button class="insertBtn" type="button" onclick="modalShow();">항목추가</button>
					</div>
				</div>
			</div>

			<div class="modal-overlay" id="insrtEmpAttForm">
				<div class="modal">
					<div class="modal-header">
						<img src="${contextPath}/icon/x.png" class="modalHide" onclick="modalHide();">
					</div>

					<h4 class="modal-title">근태 추가</h4>

					<form action="empAttInsert" method="post" id="empAttInsertForm">
						<div class="modal-body">
							<table class="empAttTable" align="center">
								<tr>
									<th>근태일자</th>
									<td><input type="date" name="empAttTime" id="empAttTime"
										required></td>
								</tr>
								<tr>
									<th>사원명</th>
									<td><input type="hidden" name="empNo" id="empNo" required>
										<input type="text" name="empName" id="empName"
										onclick="modalShow2();" readonly required></td>
								</tr>
								<tr>
									<th>근태</th>
									<td><select name="attCode" id="attCode">
											<option></option>
									</select></td>
								</tr>
								<tr>
									<th>근태수</th>
									<td><input type="number" step="0.5" min="0.5"
										name="empAttCount" id="empAttCount"></td>
								</tr>

							</table>
						</div>
						<div class="modal-footer" align="center">
							<button class="insertBtn" type="submit" id="empAttInsert">추가하기</button>
						</div>
					</form>
				</div>
			</div>

			<div class="modal-overlay" id="empList">
				<div class="modal">
					<div class="modal-header">
						<img src="${contextPath}/icon/x.png" class="modalHide"
							onclick="modalHide2();">
					</div>

					<h4 class="modal-title">사원 목록</h4>

					<div class="modal-body">
						<select class="form-select" id="condition">
							<option value="empNo">사번</option>
							<option value="empName">사원명</option>
							<option value="department">부서</option>
						</select> <input type="text" id="keyword">
						<button class="insertBtn" onclick="empSearch();">검색</button>
						<button onclick="empList();">초기화</button>

						<table class="empAttTable" align="center" id="empListTable">
							<thead>
								<tr>
									<th>사번</th>
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




		<script>
		
		$(function(){
			userEmpCount(); //유저 개인 휴가수
			empAttList(); //목록
		});
		
		//유저 휴가수
		function userEmpCount(){
			var empNo = ${loginUser.empNo };
			
			$.ajax({
				url : "/erp/att/userEmpCount",
				data : {
					empNo : empNo
				},
				success : function(result){
					$("#userDiv p").text("( " + result + " 개 )");
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		//근태 리스트
		function empAttList(){
			
			$.ajax({
				url : "/erp/att/empAttList",
				success : function(list){
					
					var str = "";
					
					for(var att of list){
						str += "<tr>"
							 + "<td>"+ att.empAttTime +"</td>"
							 + "<td data-value='"+ att.empNo +"'>"+ att.empName +"</td>"
							 + "<td data-value='"+ att.attCode +"'>"+ att.attName +"</td>"
							 + "<td data-value='"+ att.empAttCount +"'>"+ att.empAttCount +"</td>"
							 + "<td>";
						
						if(att.empAttState == null){
							str += "</td>" + "<td style='text-align: center;'>";
						}else{
							str += att.empAttState +"</td>" + "<td style='text-align: center; width: 10%;'>";
						}
							 
						
						if(att.empAttState == 'Y'){
							str += "<button class='attChange attUpdate'>중지</button>";
						}else if(att.empAttState == 'N'){
							str += "<button class='attChange attUpdate2'>사용</button>";
						}else{
							str += "<button class='attChange attUpdate3'>확인</button>";
						}
						
						str += "<button  class='attDelete'>삭제</button>"
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
		
		//날짜 선택 조회
		function selectAttDate(){
			var inputDate1 = $("#inputDate1").val();
			var inputDate2 = $("#inputDate2").val();
			
			$.ajax({
				url : "/erp/att/selectAttDate",
				data : {
					inputDate1 : inputDate1,
					inputDate2 : inputDate2
				},
				success : function(list){
					
					var str = "";
					
					if(list == ""){
						str += "<tr>"
							 + "<td colspan='5' align='center'>조회된 내용이 없습니다.</td>";
						
						$("#comListTable tbody").html(str);
						return;
					}
					
					for(var att of list){
						str += "<tr>"
							 + "<td>"+ att.empAttTime +"</td>"
							 + "<td data-value='"+ att.empNo +"'>"+ att.empName +"</td>"
							 + "<td data-value='"+ att.attCode +"'>"+ att.attName +"</td>"
							 + "<td data-value='"+ att.empAttCount +"'>"+ att.empAttCount +"</td>"
							 + "<td>";
						
						if(att.empAttState == null){
							str += "</td>" + "<td style='text-align: center; width: 10%;'>";
						}else{
							str += att.empAttState +"</td>" + "<td style='text-align: center; width: 10%;'>";
						} 
						
						if(att.empAttState == 'Y'){
							str += "<button class='attChange attUpdate'>중지</button>";
						}else if(att.empAttState == 'N'){
							str += "<button class='attChange attUpdate2'>사용</button>";
						}else{
							str += "<button class='attChange attUpdate3'>확인</button>";
						}
						
						str += "<button  class='attDelete'>삭제</button>"
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
		
		//초기화
		function reset(){
			$("#inputDate1").val("");
			$("#inputDate2").val("");
			empAttList();
		}
		
		//셀렉트 옵션 리스트
		function optionList(){
			$.ajax({
				url : "/erp/att/attOptList",
				success : function(list){
					
					var str = "";
					
					for (var opt of list){
						str += "<option value='"+ opt.attCode +"'>" + opt.attName + "</option>";
					}
					
					$("#attCode").html(str);
					optionAttCount();
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		$("#attCode").on("change", function(){
			optionAttCount();
		});
		
		//옵션 근태수
		function optionAttCount(){
			var attCode = $("#attCode").val();
			
			$.ajax({
				url : "/erp/att/optionAttCount",
				data : {
					attCode : attCode
				},
				success : function(result){
					$("#empAttCount").val(result);
				},
				error : function(){
					console.log("통신 오류");	
				}
			});
		}
		
		//사원 목록 조회
		function empList(){
			$.ajax({
				url : "/erp/att/empList",
				success : function(list){
					var str = "";
					
					for(var emp of list){
						str += "<tr>"
							 + "<td>"+ emp.empNo +"</td>"
							 + "<td>"+ emp.empName +"</td>";
							 
						if(emp.deptCode == "ND"){
							str += "<td></td>";
						}else{
							str += "<td>"+ emp.deptName +"</td>";
						}
						
						str += "<td>"+ emp.vacation +"</td>"
							 + "</tr>";
					}
					$("#empNameSearch").val("");
					$("#empListTable tbody").html(str);
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		//사원 검색
		function empSearch(){
			var keyword = $("#keyword").val();
			var condition = $("#condition").val();
			
			$.ajax({
				url : "/erp/att/empSearch",
				data : {
					keyword : keyword,
					condition : condition
				},
				success : function(list){
					var str = "";
					
					for(var emp of list){
						str += "<tr>"
							 + "<td>"+ emp.empNo +"</td>"
							 + "<td>"+ emp.empName +"</td>";
							 
						if(emp.deptCode == "ND"){
							str += "<td></td>";
						}else{
							str += "<td>"+ emp.deptName +"</td>";
						}
						
						str += "<td>"+ emp.vacation +"</td>"
							 + "</tr>";
					}
					$("#keyword").val("");
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
			
			modalHide2();
		});
		
		//근태 추가
		
		
		//근태 항목 삭제
		$("#empAttList").on("click","tbody>tr .attDelete",function(){
				
			var tr = $(this).closest("tr");
			var empAttTime = tr.find("td:nth-child(1)").text();
			var empNo = tr.find("td:nth-child(2)").data("value");
			var attCode = tr.find("td:nth-child(3)").data("value");
			
			if (confirm("복구가 불가능합니다. 정말 삭제하시겠습니까?")) {
		        $.ajax({
		            url: "/erp/att/empAttDelete",
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
		            url: "/erp/att/empAttUpdate",
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
		            url: "/erp/att/empAttUpdate",
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
		            url: "/erp/att/empAttUpdate2",
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
		
		//모달
		function modalShow(){
			$("#insrtEmpAttForm").css("display", "flex");
			optionList(); //근태 추가 모달 옵션 목록
		};
		function modalHide(){
			$("#insrtEmpAttForm").css("display", "none");
			
			$("#empAttTime").val("");
			$("#empNo").val("");
			$("#empName").val("");
			
		}
		function modalShow2(){
			$("#empList").css("display", "flex");
			empList(); //근태 추가 모달 사원 목록
		};
		function modalHide2(){
			$("#empList").css("display", "none");
		}
		
	</script>
	</div>

</body>
</html>