<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- 부트스트랩에서 제공하고 있는 스타일 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 부트스트랩에서 제공하고 있는 스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- alertify alert창 변화 -->
    <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>
	<!-- Bootstrap theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/bootstrap.min.css"/>
	 
</head>
<body>
	<div>
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
	    	<!-- 
            	<tr>
				    <td>${list[0].attCode }</td>
				    <td>${list[0].attTypeName }</td>
				    <td>${list[0].attName }</td>
				    <td>${list[0].attState }</td>
			    </tr>
	    	 -->
        	</tbody>
		</table>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insrtAttForm">항목추가</button>
	</div>
	
	<div class="modal fade" id="insrtAttForm">
        <div class="modal-dialog">
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
			                	<td><input type="text" class="form-control" name="attName"></td>
			            	</tr>
			            	<tr>
			            		<th>근태유형</th>
			            		<td>
			            			<select name="attTypeCode">
			            				<option value="100">연차</option>
			            				<option value="101">반차</option>
			            				<option value="102">월차</option>
			            			</select>
			            		</td>
			            	</tr>
			            	<tr>
			            		<th>근태수</th>
			            		<td><input type="number" class="form-control" name="attCount"></td>
			            	</tr>
			            	<tr>
			            		<th>적요</th>
			            		<td><input type="text" class="form-control"></td>
			            	</tr>
				    	</table>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" align="center">
                        <button type="submit" class="btn btn-primary">추가하기</button>
                    </div>
                </form>
            </div>
            
            <script>
            	
            </script>
		</div>
    </div>
    
    <div class="modal fade" id="insrtAttForm">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">항목 수정</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <form action="attInsert" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                    	<table align="center">
			            	<tr>
			                	<th>근태명칭</th>
			                	<td><input type="text" class="form-control" name="attName"></td>
			            	</tr>
			            	<tr>
			            		<th>근태유형</th>
			            		<td>
			            			<select name="attTypeCode">
			            				<option value="100">연차</option>
			            				<option value="101">반차</option>
			            				<option value="102">월차</option>
			            			</select>
			            		</td>
			            	</tr>
			            	<tr>
			            		<th>근태수</th>
			            		<td><input type="number" class="form-control" name="attCount"></td>
			            	</tr>
			            	<tr>
			            		<th>적요</th>
			            		<td><input type="text" class="form-control"></td>
			            	</tr>
				    	</table>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" align="center">
                        <button type="submit" class="btn btn-primary" id="attInsert">추가하기</button>
                    </div>
                </form>
            </div>
            
            <script>
            	
            </script>
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
							 + "<td>"
							 	+"<button class='btn btn-primary attUpdate'>수정</button>"
							 	+"<button  class='btn btn-danger attDelete'>삭제</button>"
							 + "</td>"
							 + "</tr>"
					}
					$("#attList tbody").html(str);
				},
				error : function(){
					console.log("통신 오류");
				}
			});
		}
		
		//근태 항목 추가
		$("#attInsert").click(function(){
			$.ajax({
				url : "attInsert",
				data : {
					
				}
			});
		});
		
		//근태 항목 수정 모달 필요
		$("#attList").on("click","tbody>tr .attUpdate",function(){
				
			var code = $(this).closest("tr").children().first().text();
			//console.log(code);
			
			$.ajax({
				url : "attUpdate",
				data : {
					attCode : code,
					attName : $("#att"),
					attTypeCode : $,
					attCount : 
					
				}
			});
			
		});
		
		//근태 항목 수정
		
		
		
		//근태 항목 삭제
		$("#attList").on("click","tbody>tr .attDelete",function(){
				
			var code = $(this).closest("tr").children().first().text();
			console.log(code);
			
			if (confirm("복구가 불가능합니다. 정말 삭제하시겠습니까?")) {
		        $.ajax({
		            url: "attDelete",
		            method: "GET",
		            data: { attCode: code },
		            success: function(response) {
		                if (response === "NNNNY") {
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