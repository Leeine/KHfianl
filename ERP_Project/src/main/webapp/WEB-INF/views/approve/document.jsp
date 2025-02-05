	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="EUC-KR">
	<title>결재 목록</title>
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	</head>
	<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
	<div id="listdiv">
	<table id="documnetList">
	    <colgroup>
	        <col style="width: 18%">
	        <col style="width: 12%">
	        <col style="width: 23%">
	        <col style="width: 30%">
	        <col style="width: 12%">
	        <col style="width: 5%">
	    </colgroup>
	    <thead>
	        <tr>
	            <th>결재 번호</th>
	            <th>사원 번호</th>
	            <th>신청일</th>
	            <th>결재명</th>
	            <th>결재자</th>
	            <th>상태</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:choose>
	            <c:when test="${empty docList}">
	                <tr>
	                    <td colspan="6">조회된 서류가 없습니다.</td>
	                </tr>
	            </c:when>
	            <c:otherwise>
	                <c:forEach var="b" items="${docList}">
	                    <tr>
	                        <td>${b.apNo}</td>
	                        <td>${b.empNo}</td>
	                        <td>${b.apCreateDate}</td>
	                        <td>${b.apTitle}</td>
	                        <td>${b.apMaster}</td>
	                        <td>
	                            <c:choose>
	                                <c:when test="${b.statusCode == '0'}">대기</c:when>
	                                <c:when test="${b.statusCode == '1'}">승인</c:when>
	                                <c:when test="${b.statusCode == '2'}">거절</c:when>
	                                <c:otherwise>알 수 없음</c:otherwise>
	                            </c:choose>
	                        </td>
	                    </tr>
	                    <script>
	                    </script>
	                </c:forEach>
	            </c:otherwise>
	        </c:choose>
	    </tbody>
	</table>
	
	<script>
	    $(document).ready(function() {
	        $("#documnetList>tbody tr").click(function() {
	            var bno = $(this).children().first().text();  
	            var apMaster = $(this).children().eq(4).text();  
	            var status = $(this).find("td").eq(5).text();
	            $("#apNo").val(bno);
	            $(".modal").css({"width":"1000px", "height" : "1000px"})
	            document_type(bno);
	            
	            if(apMaster == "${loginUser.empNo}") {
	                $("#modal-btn").show(); // 같으면 버튼을 보이게
	            } else {
	                $("#modal-btn").hide(); // 다르면 버튼을 숨기게
	            }
	            
	            
	          
	                         
	            $("#summernote").summernote({
	            	placeholder: '내용을 입력해주세요',
	                tabsize: 2,
	                width:  1000,
	                height: 700,
	                focus: true,
	                lang: 'ko-KR', 
	                toolbar: [
		      		    // 글꼴 설정
		      		    ['fontname', ['fontname']],
		      		    // 글자 크기 설정
		      		    ['fontsize', ['fontsize']],
		      		    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		      		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		      		    // 글자색
		      		    ['color', ['forecolor','color']],
		      		    // 표만들기
		      		    ['table', ['table']],
		      		    // 글머리 기호, 번호매기기, 문단정렬
		      		    ['para', ['ul', 'ol', 'paragraph']],
		      		    // 줄간격
		      		    ['height', ['height']],
		      		    // 코드보기
		      		    ['view', ['codeview']]
		      		  ],
		      		  // 추가한 글꼴
		      		fontNames: ['맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체','Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],
		      		 // 추가한 폰트사이즈
		      		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	            });
	
	            $(".modal-overlay").css("display", "flex");
	        });
	
	        
	        $(".modalHide").click(function() {
	            $(".modal-overlay").fadeOut(); 
	            $("#aptitle").val('');
	        });
	
	        $(".modal-custom-button").click(function() {
	            var bno = $(this).attr("data-bno");
	            $(".modal-overlay").fadeOut(); 
	        });
	    });
	
	    
	    
	    function document_type(bno){
	    	$.ajax({
	    		url:"/erp/approve/dotype",
	    		data : {
	    			apNo : bno
	    		},
	    		method : "GET",
	    		success : function (result){
	    			$("#summernote").summernote("code", result.apContent);
	    			var status = result.statusCode;
	    			
	    			if(status == '0'){
	    			    $("#wait_btn").hide();
	    			    $("#accept_btn").show(); 
	    			    $("#none_btn").show();
	    			} else if(status == '1'){
	    			    $("#accept_btn").hide();
	    			    $("#none_btn").show();
	    			    $("#wait_btn").show();
	    			} else {
	    			    $("#none_btn").hide();
	    			    $("#accept_btn").show();
	    			    $("#wait_btn").show();
	    			}
	    		},
	    		error : function (error){
	    			console.log(error);
	    		}
	    	})
	    }
	
	   
	   
	   
	    
	</script>
	
	
	    <div class="modal-overlay">
	        <div class="modal">
	            <div class="modal-header">
	                <img src="${contextPath}/icon/x.png" class="modalHide">
	            </div>
	            <h2>결재 처리</h2>
	            <input type="hidden" id="apNo">
	            
	            
	            <div id="modal-btn">
	                <button id="accept_btn" onclick="accept_update();">승인</button>
	                <button id="none_btn" onclick="none_update();">거절</button>
	                <button id="wait_btn" onclick="wait_update();">대기</button>
	            </div><br>
				
			
	            <textarea id="summernote" style="resize:'none'"></textarea>
	
	           
	        </div>
	    </div>
	
	</div>
	</body>
	</html>
