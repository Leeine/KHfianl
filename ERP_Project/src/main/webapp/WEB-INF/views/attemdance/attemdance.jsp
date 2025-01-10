<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>

<link href="/erp/css/common/modal.css" rel="stylesheet">

<style>
body {
	background-color: rgb(225, 235, 255);
}

#main-content-header {
	margin: 30px;
	width: 93%;
	height: 100px;
	border-radius: 20px;
	background-color: white;
}

#main-content {
	margin-left: 60px;
}

#main-content-block {
	margin: 30px;
	padding: 1px 15px;
	background-color: white;
	border-radius: 20px;
	width: 93%;
}

#attListDiv {
	margin: 15px 0px 15px 0px;
}

#attList tbody tr:hover {
	background-color: #DDE5FF;
}

.insertBtn {
	margin: 10px 0px 10px 0px;
}

table {
	width: 80%;
	border: 2px solid #C0C9D1;
	margin: 30px auto 5px auto;
	border-collapse: collapse;
}

tr, td, th {
	border: 2px solid #C0C9D1;
	padding-left: 5px;
}

th {
	text-align: left;
	background-color: rgb(225, 235, 255);
}

.modal select {
	border: 0;
	width: 100%;
	outline: none;
}

.attChange:hover {
	background-color: rgb(55, 78, 121);
	color: white;
}
.attDelete:hover {
	background-color: red;
	color: white;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/sidemenu.jsp"%>
	<c:set var="contextPath"
		value="${pageContext.servletContext.contextPath}" />
	<div id="main-content">

		<c:if test="${not empty alertMsg}">
			<script>
				alert("${alertMsg}");
			</script>
			<c:remove var="alertMsg" />
		</c:if>

		<div id="main-content-header">
			<h2>근태 관리</h2>
		</div>


		<div id="main-content-block">
			<div id="attListDiv" align="center">
				<table id="attList">
					<thead>
						<tr>
							<th>근태코드</th>
							<th>근태명칭</th>
							<th>근태유형</th>
							<th colspan="2">사용</th>
							<!-- <th style="width: 10%;"></th> -->
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<button type="button" class="insertBtn" onclick="modalShow();">항목추가</button>
			</div>
		</div>

		<div class="modal-overlay" id="attInsert">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide"
						onclick="modalHide();">
				</div>

				<form action="attInsert" method="post">
					<div class="modal-body">
						<h4 class="modal-title">항목 추가</h4>
						<table align="center">
							<tr>
								<th>근태명칭</th>
								<td><input type="text" id="attName" name="attName" required></td>
							</tr>
							<tr>
								<th>근태유형</th>
								<td><select id="attTypeCode" name="attTypeCode" required>
										<option value="100">연차</option>
										<option value="101">반차</option>
										<option value="102">월차</option>
								</select></td>
							</tr>
							<tr>
								<th>근태수</th>
								<td><input type="number" step="0.5" min="0.5" id="attCount" name="attCount" required></td>
							</tr>
						</table>
					</div>
					<div class="modal-footer" align="center">
						<button type="submit" class="insertBtn" id="attInsert">추가하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>






	<script>
	
		$(function(){
			selectAttList();
		});
		
		function selectAttList(){
			$.ajax({
				url : "attList",
				success : function(list){
					
					var str = "";
					
					for(var att of list){
						str += "<tr>"
							 + "<td>"+ att.attCode +"</td>"
							 + "<td>"+ att.attName +"</td>"
							 + "<td>"+ att.attTypeName +"</td>"
							 + "<td>"+ att.attState +"</td>"
							 + "<td style='text-align: center; width: 10%;'>";
							 
						if(att.attState == 'Y'){
							str += "<button class='attChange attUpdate'>중지</button>";
						}else{
							str += "<button class='attChange attUpdate2'>사용</button>";
						}
						
						str += "<button  class='attDelete'>삭제</button>"
							 + "</td>"
							 + "</tr>";
					}
					$("#attList tbody").html(str);
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		//근태 항목 수정
		$("#attList").on("click","tbody>tr .attUpdate",function(){
				
			var code = $(this).closest("tr").children().first().text();
			
			if (confirm("해당 항목의 사용을 중지하시겠습니까?")){
				$.ajax({
					url : "attUpdate",
					data : {
						attCode : code
					},
					success : function(result){
						if (result == "NNNNY") {
		                    alert("수정이 완료되었습니다.");
		                    selectAttList();
		                } else {
		                    alert("수정 실패");
		                }
					},
					error : function(){
						
					}
				});
			}
		});
		
		$("#attList").on("click","tbody>tr .attUpdate2",function(){
			
			var code = $(this).closest("tr").children().first().text();
			
			if (confirm("해당 항목을 사용하시겠습니까?")){
				$.ajax({
					url : "attUpdate2",
					data : {
						attCode : code
					},
					success : function(result){
						if (result == "NNNNY") {
		                    alert("수정이 완료되었습니다.");
		                    selectAttList();
		                } else {
		                    alert("수정 실패");
		                }
					},
					error : function(){
						
					}
				});
			}
		});
		
		
		//근태 항목 삭제
		$("#attList").on("click","tbody>tr .attDelete",function(){
				
			var code = $(this).closest("tr").children().first().text();
			
			if (confirm("복구가 불가능합니다. 정말 삭제하시겠습니까?")) {
		        $.ajax({
		            url: "attDelete",
		            method: "GET",
		            data: { attCode: code },
		            success: function(result) {
		                if (result == "NNNNY") {
		                    alert("삭제가 완료되었습니다.");
		                    selectAttList();
		                } else {
		                    alert("삭제 실패");
		                }
		            },
		            error: function() {
		                alert("통신 오류가 발생했습니다.");
		            }
		        });
		    }
		});
		
		//근태 유형 option
		function attOption(){
			$.ajax({
				url : "attOption",
				success : function(list){
					
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		//모달
		function modalShow(){
			$(".modal-overlay").css("display", "flex");
		};
		function modalHide(){
			$(".modal-overlay").css("display", "none");
			
			$("#attName").val("");
			$("#attCount").val("");
		}
		
	</script>


</body>
</html>