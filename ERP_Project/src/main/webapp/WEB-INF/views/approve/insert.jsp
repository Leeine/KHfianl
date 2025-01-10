<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
        
    </style>

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



<script>
    $(document).ready(function() {
        $("#documnetList>tbody tr").click(function() {
            var bno = $(this).children().first().text(); 
            $(".modal").css({"width":"1000px", "height" : "1000px"})
            do_type(bno);
            
           
                         
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
            $(".modal-overlay").fadeOut(); // 모달 숨기기
            $("#aptitle").val('');
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
    
    function approve_list(empNo){
    	$.ajax({
    		url:"/erp/employee/approve/list",
    		data : {
    			empNo : empNo
    		},
    		method: "GET",
    		success : function (result){
    			var select = $("<select>").addClass("approvelist");
    			for(var d of result){
    				select.append($("<option>").val(d.empNo).text(d.deptName+" "+d.empName));
    			}
    			$("#approve-table").find("#apmaster").html(select);
    		},
    		error: function (error){
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
            <table id="approve-table">
             <tr>
             	<th>결재자</th>   <!-- AP_MASTER -->
             	<td id="apmaster"></td>
             </tr>           
             <tr>
                 <th>결재 내용</th>
                 <td><input type="text" name="aptitle" id="aptitle"></td>    <!-- AP_TITLE -->
             </tr> 
            </table><br>
            <div id="modal-btn">
					<button id="insert-btn" onclick="approve_insert('${loginUser.empNo}');">작성</button>
			</div> <br>
			
			
            <textarea id="summernote" style="resize:'none'"></textarea>

            <div id="testdiv"></div>
           
        </div>
    </div>
</div>

</body>
</html>
