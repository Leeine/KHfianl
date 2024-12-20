<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<!-- jQuery ���̺귯�� -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- ��Ʈ��Ʈ������ �����ϰ� �ִ� ��Ÿ�� -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- ��Ʈ��Ʈ������ �����ϰ� �ִ� ��ũ��Ʈ -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- alertify alertâ ��ȭ -->
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
                	<th>�����ڵ�</th>
                	<th>���¸�Ī</th>
                	<th>��������</th>
                	<th>���</th>
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
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insrtAttForm">�׸��߰�</button>
	</div>
	
	<div class="modal fade" id="insrtAttForm">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">�׸� �߰�</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <form action="attInsert" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                    	<table align="center">
			            	<tr>
			                	<th>���¸�Ī</th>
			                	<td><input type="text" class="form-control" name="attName"></td>
			            	</tr>
			            	<tr>
			            		<th>��������</th>
			            		<td>
			            			<select name="attTypeCode">
			            				<option value="100">����</option>
			            				<option value="101">����</option>
			            				<option value="102">����</option>
			            			</select>
			            		</td>
			            	</tr>
			            	<tr>
			            		<th>���¼�</th>
			            		<td><input type="number" class="form-control" name="attCount"></td>
			            	</tr>
			            	<tr>
			            		<th>����</th>
			            		<td><input type="text" class="form-control"></td>
			            	</tr>
				    	</table>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" align="center">
                        <button type="submit" class="btn btn-primary">�߰��ϱ�</button>
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
                    <h4 class="modal-title">�׸� ����</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <form action="attInsert" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                    	<table align="center">
			            	<tr>
			                	<th>���¸�Ī</th>
			                	<td><input type="text" class="form-control" name="attName"></td>
			            	</tr>
			            	<tr>
			            		<th>��������</th>
			            		<td>
			            			<select name="attTypeCode">
			            				<option value="100">����</option>
			            				<option value="101">����</option>
			            				<option value="102">����</option>
			            			</select>
			            		</td>
			            	</tr>
			            	<tr>
			            		<th>���¼�</th>
			            		<td><input type="number" class="form-control" name="attCount"></td>
			            	</tr>
			            	<tr>
			            		<th>����</th>
			            		<td><input type="text" class="form-control"></td>
			            	</tr>
				    	</table>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer" align="center">
                        <button type="submit" class="btn btn-primary" id="attInsert">�߰��ϱ�</button>
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
							 	+"<button class='btn btn-primary attUpdate'>����</button>"
							 	+"<button  class='btn btn-danger attDelete'>����</button>"
							 + "</td>"
							 + "</tr>"
					}
					$("#attList tbody").html(str);
				},
				error : function(){
					console.log("��� ����");
				}
			});
		}
		
		//���� �׸� �߰�
		$("#attInsert").click(function(){
			$.ajax({
				url : "attInsert",
				data : {
					
				}
			});
		});
		
		//���� �׸� ���� ��� �ʿ�
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
		
		//���� �׸� ����
		
		
		
		//���� �׸� ����
		$("#attList").on("click","tbody>tr .attDelete",function(){
				
			var code = $(this).closest("tr").children().first().text();
			console.log(code);
			
			if (confirm("������ �Ұ����մϴ�. ���� �����Ͻðڽ��ϱ�?")) {
		        $.ajax({
		            url: "attDelete",
		            method: "GET",
		            data: { attCode: code },
		            success: function(response) {
		                if (response === "NNNNY") {
		                    alert("������ �Ϸ�Ǿ����ϴ�.");
		                    selectAttList();
		                } else {
		                    alert("���� ����");
		                }
		            },
		            error: function() {
		                alert("��� ������ �߻��߽��ϴ�.");
		            }
		        });
		    }
		});
		
	</script>
	
	
</body>
</html>