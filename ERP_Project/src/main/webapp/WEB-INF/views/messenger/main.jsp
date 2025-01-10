<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/erp/css/messenger/messenger.css" rel="stylesheet">
<script src="/erp/js/messenger/messenger.js"></script>
<title>Insert title here</title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />

	<div id="messenger-main-page">
		<div id="messenger-wrap">
            <div id="messenger-header">
				<div id="messenger-status-text"></div>
            </div>
            <div id="messenger-content-wrap">
            
            
            
            
	            <div id="messenger-user-list">
	            	<!-- 사원 목록 화면 -->
	                <div id="messenger-profile-area">
	                	<table id="messenger-profile-table">
	                		<colgroup>
	                			<col style="width:20%">
	                			<col style="width:80%">
	                		</colgroup>
	                		<tbody>
	                			<tr>
	                				<td rowspan="2">
					                    <img src="${contextPath}/icon/mypage.png" class="my-icon"><br>
	                				</td>
	                				<td>${loginUser.deptName}</td>
	                			</tr>
	                			<tr>
	                				<td>${loginUser.rankName} ${loginUser.empName}</td>
	                			</tr>
	                		</tbody>
	                	</table>
	                    
	                </div>
	                <div id="user-search-area">
	                    <div id="user-search-input">
	                        <input type="text" placeholder="사원 검색" id="messenger-search-keyword">
	                        <script>
	
		    					$(function(){
		    						let timeout;
		                        	$("#messenger-search-keyword").on("input", function(){
									    clearTimeout(timeout);
									    timeout = setTimeout(function(){
			                        		messenger_emp_search_list('${loginUser.empNo}','${contextPath}');
									    },200); //입력후 0.2초마다 검색
		                        	});
		    					});
		    					
		    					//사원 클릭시
		    					$(function(){
		    						$("#messenger-emplist-table").on("click", ".messenger-emplist", function(){
		    							var empNo = $(this).find(".messenger-empNo").val();
		    							var empName = $(this).find(".messenger-emplist-name").text();
		    							chat_room(empNo,empName);
		    						})
		    					});
	                        </script>
	                    </div>
	                    <div id="user-search-result">
	                   		<table id="messenger-emplist-table">
		                		<colgroup>
		                			<col style="width:20%">
		                			<col style="width:70%">
		                			<col style="width:10%">
		                		</colgroup>
								<tbody>
									<tr class="messenger-emplist">
										<td>
											<input type="hidden" class="messenger-empNo">
			                			</td>
										<td>
				                    		<div class="messenger-emplist-dept">부서</div>
				                    		<div class="messenger-emplist-name">직급 이름</div>
										</td>
	                					<td>10</td>
									</tr>
								</tbody>
	                   		</table>
	                    </div>
	                </div>
	                
            	</div> 
                <div id="direct-message-area">
                </div>
                
                
                
            </div>
		</div>
	</div>
	<script>
		$(function(){
			$("#messenger-wrap").on("click",".exit-icon",function(){
				$("#messenger-user-list").show();
				$("#direct-message-area").html('');
			})
		})
	</script>
</body>
</html>