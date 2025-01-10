<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���</title>
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
            <th>���� ��ȣ</th>
            <th>��� ��ȣ</th>
            <th>��û��</th>
            <th>�����</th>
            <th>����</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${empty docList}">
                <tr>
                    <td colspan="6">��ȸ�� ������ �����ϴ�.</td>
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
                                <c:when test="${b.statusCode == '0'}">���</c:when>
                                <c:when test="${b.statusCode == '1'}">����</c:when>
                                <c:when test="${b.statusCode == '2'}">�ҽ���</c:when>
                                <c:when test="${b.statusCode == '3'}">�ӽ�����</c:when>
                                <c:otherwise>�� �� ����</c:otherwise>
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
            //bn = apNo(���������ȣ)
            
           
                         
            $("#summernote").summernote({
            	placeholder: '������ �Է����ּ���',
                tabsize: 2,
                width:  1000,
                height: 700,
                focus: true,
                lang: 'ko-KR', 
                toolbar: [
	      		    // �۲� ����
	      		    ['fontname', ['fontname']],
	      		    // ���� ũ�� ����
	      		    ['fontsize', ['fontsize']],
	      		    // ����, ����Ӳ�, ����,��� ��, ���������
	      		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	      		    // ���ڻ�
	      		    ['color', ['forecolor','color']],
	      		    // ǥ�����
	      		    ['table', ['table']],
	      		    // �۸Ӹ� ��ȣ, ��ȣ�ű��, ��������
	      		    ['para', ['ul', 'ol', 'paragraph']],
	      		    // �ٰ���
	      		    ['height', ['height']],
	      		    // �ڵ庸��
	      		    ['view', ['codeview']]
	      		  ],
	      		  // �߰��� �۲�
	      		fontNames: ['���� ���','�ü�','����ü','����','����ü','����ü','Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],
	      		 // �߰��� ��Ʈ������
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
