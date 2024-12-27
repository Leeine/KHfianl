<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
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
			<h3>근태</h3>
				<table id="attList" class="table table-hover" align="center">
		        	<thead>
		            	<tr>
		                	<th>근태코드</th>
		                	<th>근태명칭</th>
		                	<th>근태유형</th>
		                	<th>사용</th>
		                	<th></th>
		            	</tr>
			       	</thead>
			    	<tbody>
		        	</tbody>
				</table>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insrtAttForm">항목추가</button>
		</div>
			
			<div class="modal fade" id="insrtAttForm">
		        <div class="modal-dialog modal-dialog-centered">
		            <div class="modal-content">
		
		                <!-- Modal Header -->
		                <div class="modal-header">
		                    <h4 class="modal-title">항목 추가</h4>
		                    <button type="button" class="close" data-dismiss="modal">&times;</button>
		                </div>
		
		                <form action="attInsert" method="post">
		                    <!-- Modal body -->
		                    <div class="modal-body">
		                    	<table align="center">
					            	<tr>
					                	<th>근태명칭</th>
					                	<td><input type="text" class="form-control" id="attName" name="attName"></td>
					            	</tr>
					            	<tr>
					            		<th>근태유형</th>
					            		<td>
					            			<select id="attTypeCode" name="attTypeCode">
					            				<option value="100">연차</option>
					            				<option value="101">반차</option>
					            				<option value="102">월차</option>
					            			</select>
					            		</td>
					            	</tr>
					            	<tr>
					            		<th>근태수</th>
					            		<td><input type="number" class="form-control" id="attCount" name="attCount"></td>
					            	</tr>
					            	<tr>
					            		<th>적요</th>
					            		<td><input type="text" class="form-control"></td>
					            	</tr>
						    	</table>
		                    </div>
		                    <!-- Modal footer -->
		                    <div class="modal-footer" align="center">
		                        <button type="button" class="btn btn-primary" id="attInsert">추가하기</button>
		                    </div>
		                </form>
		            </div>
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
					//console.log(list);
					
					var str = "";
					
					for(var att of list){
						str += "<tr>"
							 + "<td>"+ att.attCode +"</td>"
							 + "<td>"+ att.attName +"</td>"
							 + "<td>"+ att.attTypeName +"</td>"
							 + "<td>"+ att.attState +"</td>"
							 + "<td>";
							 
						if(att.attState == 'Y'){
							str += "<button class='btn btn-secondary btn-sm attUpdate'>중지</button>";
						}else{
							str += "<button class='btn btn-secondary btn-sm attUpdate2'>사용</button>";
						}
						
						str += "<button  class='btn btn-danger btn-sm attDelete'>삭제</button>"
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
		
		//항목 추가
		$("#attInsert").click(function(){
			
			$.ajax({
				url : "attInsert",
				type : "post",
				data : {
					attName : $("#attName").val(),
					attTypeCode : $("#attTypeCode").val(),
					attCount : $("#attCount").val()
				},
				success : function(result) {
	                if (result == "NNNNY") {
	                    alert("추가되었습니다.");
	                    
	                    $("#attName").val("");
	                    $("#attTypeCode").val("");
	                    $("#attCount").val("");
	                    
	                    //$("#insrtAttForm").hide();
	                    //$(".modal-backdrop").remove(); // 모달 배경 제거
	                    $("#insrtAttForm").modal("hide");
	                    
	                    selectAttList();
	                } else {
	                    alert("추가 실패");
	                }
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		});
		
		//근태 항목 수정
		$("#attList").on("click","tbody>tr .attUpdate",function(){
				
			var code = $(this).closest("tr").children().first().text();
			//console.log(code);
			
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
			//console.log(code);
			
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
			//console.log(code);
			
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
		
	</script>
	
	
</body>
</html>