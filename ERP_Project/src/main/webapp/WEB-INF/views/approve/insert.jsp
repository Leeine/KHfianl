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

 

<c:set var="a" value="${documentList[2]}" />

<script>
    $(document).ready(function() {
        // 서류 번호 추출 및 모달 표시
        $("#documnetList>tbody tr").click(function() {
            var bno = $(this).children().first().text(); // 서류 번호 추출
            console.log("추출된 서류 번호: " + bno);

            // 서류 번호를 모달 버튼에 전달
            $(".modal").find(".modal-custom-button").attr("data-bno", bno); 

            // 여기에 summernote 초기화를 추가
            $("#summernote").summernote({
            	placeholder: '내용을 입력해주세요',
                tabsize: 2,
                width:  800,
                height: 300,
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

            // 모달 표시
            $(".modal-overlay").fadeIn();
        });

        // 모달 닫기
        $(".modalHide").click(function() {
            $(".modal-overlay").fadeOut(); // 모달 숨기기
        });

        // 모달 커스텀 버튼 클릭시 서류 번호 가져오기
        $(".modal-custom-button").click(function() {
            var bno = $(this).attr("data-bno");
            console.log("모달에서 선택된 서류 번호: " + bno);
            $(".modal-overlay").fadeOut(); // 모달 숨기기
        });
    });

    function selectType1() {
        var type1 = '${a.doContent}';
        $("#summernote").summernote("code", type1);
    }
    
</script>

   <!-- 모달 -->
    <div class="modal-overlay">
        <div class="modal">
            <div class="modal-header">
                <img src="${contextPath}/icon/x.png" class="modalHide">
            </div>

            <textarea id="summernote" style="resize:'none'"></textarea>
            <button onclick="selectType1();">양식1</button>

            <div id="testdiv"></div>
            <button class="modal-custom-button">입력</button>
        </div>
    </div>
</div>

</body>
</html>
