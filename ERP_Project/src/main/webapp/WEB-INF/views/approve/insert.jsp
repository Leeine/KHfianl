<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>


</head>
<body>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
<div id="textdiv">
    <br>
    <table id="documnetList">
    <colgroup>
        <col style="width: 20%">
        <col style="width: 80%">
    </colgroup>
    <thead>
        <tr>
            <th>서류 번호</th>
            <th>결재 서류</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${empty documentList}">
                <tr>
                    <td colspan="6">조회된 서류가 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="item" items="${documentList}">
                    <tr>
                        <td>${item.doNo}</td>
                        <td>${item.doList}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>


<c:set var="a" value="${documentList[1]}" />

<script>
    $(document).ready(function() {
        $("#documnetList>tbody tr").click(function() {
            var bno = $(this).children().first().text(); 
            $(".modal").css({"width":"1000px", "height" : "800px"})
            do_type(bno);
            
           
                         
            $("#summernote").summernote({
            	placeholder: '내용을 입력해주세요',
                tabsize: 2,
                width:  1000,
                height: 700,
                focus: true,
                lang: 'ko-KR', 
                toolbar: [
                  ['style', ['style']],
                  ['font', ['bold', 'underline', 'clear']],
                  ['color', ['color']],
                  ['para', ['ul', 'ol', 'paragraph']],
                  ['table', ['table']],
                  ['insert', ['link', 'picture', 'video']],
                  ['view', ['fullscreen', 'codeview', 'help']]
                ]
            });

            $(".modal-overlay").css("display", "flex");
        });

        $(".modalHide").click(function() {
            $(".modal-overlay").fadeOut(); // 모달 숨기기
        });

        $(".modal-custom-button").click(function() {
            var bno = $(this).attr("data-bno");
            $(".modal-overlay").fadeOut(); // 모달 숨기기
        });
    });

   /* function selectType1() {
        var type1 = '${a.doContent}';
        $("#summernote").summernote("code", type1);
        console.log(type1);
    }*/
    
    function do_type(bno){
    	$.ajax({
    		url:"/erp/approve/type",
    		data : {
    			doNo : bno
    		},
    		method : "GET",
    		success : function (result){
    			console.log(result);
    			$("#summernote").summernote("code", result.doContent);
    		},
    		error : function (error){
    			console.log(error);
    		}
    	})
    }
</script>

   <!-- 모달 -->
    <div class="modal-overlay">
        <div class="modal">
            <div class="modal-header">
                <img src="${contextPath}/icon/x.png" class="modalHide">
            </div>
            <h2>결재 서류 작성</h2>
           <br><br>
            <textarea id="summernote" style="resize:'none'"></textarea>

            <div id="testdiv"></div>
            <button class="modal-custom-button">입력</button>
        </div>
    </div>
</div>

</body>
</html>
