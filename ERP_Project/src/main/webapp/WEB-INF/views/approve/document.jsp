<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>결재 목록</title>
</head>
<body>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
<div id="listdiv">
<table id="documnetList">
    <colgroup>
        <col style="width: 18%">
        <col style="width: 12%">
        <col style="width: 25%">
        <col style="width: 40%">
        <col style="width: 5%">
    </colgroup>
    <thead>
        <tr>
            <th>결재 번호</th>
            <th>사원 번호</th>
            <th>신청일</th>
            <th>결재명</th>
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
                        <td>
                            <c:choose>
                                <c:when test="${b.statusCode == '0'}">대기</c:when>
                                <c:when test="${b.statusCode == '1'}">승인</c:when>
                                <c:when test="${b.statusCode == '2'}">불승인</c:when>
                                <c:when test="${b.statusCode == '3'}">임시저장</c:when>
                                <c:otherwise>알 수 없음</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>

<script>
    $(document).ready(function() {
        $("#documnetList>tbody tr").click(function() {
            var bno = $(this).children().first().text(); 
            $(".modal").css({"width":"1000px", "height" : "1000px"})
            console.log(bno);
            //bn = apNo(결재고유번호)
            
           
                         
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


    function do_type(bno){
    	$.ajax({
    		url:"/erp/approve/type",
    		data : {
    			doNo : bno
    		},
    		method : "GET",
    		success : function (result){
    			$("#summernote").summernote("code", result.doContent);
    		},
    		error : function (error){
    			console.log(error);
    		},
    		complete : function(){
    			approve_list("${loginUser.empNo}");
    		}
    	})
    }
    
    
</script>


</div>
</body>
</html>
