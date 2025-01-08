<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
	<div id="notice-list-page">
		<div id=notice-list-input-area>
			<span id="notice-list-pagingbar"> 
				<input type="hidden" id="notice-startPage" value="1"> 
				<input type="text" id="notice-currentPage"> / <span id="notice-maxPage">1</span>
			</span> 
			<select id="notice-list-search-select">
				<option value="TITLE">제목</option>
				<option value="WRITER">작성자</option>
				<option value="DATE">날짜</option>
			</select>
			
			<input type="text" id="notice-list-search-keyword">
			<button id="notice-search-btn">search</button>
			<button class="add notice-write" onclick="notice_insert_modal();">공지작성</button>
		</div>
		
		
		<script>
			$(function() {
				//공지 리스트 불러오기
				notice_list();

				//search 버튼 클릭시
				$("#notice-search-btn").click(function() {
					$('#notice-currentPage').val('1');
					notice_search();
				});

				//currentPage 번호 입력시
				$('#notice-currentPage').on('blur', function() {
					var num = $('#notice-currentPage').val();
					if (num == '') {
						$(this).val('1');
					}
					num = $('#notice-currentPage').val();
					var maxPage = $('#notice-maxPage').text();
					var startPage = $("#notice-startPage").val();

					if (num > maxPage || num < startPage) {
						$('#notice-currentPage').val('1');
					}
					var keyword = $("#notice-list-search-keyword").val();

					if (keyword != '') {
						notice_search();
					} else {
						notice_list();
					}
				});

				//목록에서 선택시 공지 내용보기
				$("#notice-list-table").on("click","td",function(){
					var noticeNo = $(this).parents("tr").find("td").eq(0).text();
					notice_modal_detail(noticeNo);
				})
				
				//검색창 폼 변경
				$("#notice-list-search-select").change(function () {
					var val = $(this).val();
					var input = $("#notice-list-search-keyword");
					input.val('');
					if(val == "DATE"){
						input.attr("type","date");
					}else{
						input.attr("type","text");
					}
				})
				
				//모달 숨기기
				$(".modalHide").click(function() {
					clear();
					if($("#notice-list-search-keyword").val()==''){
						notice_list();
					}else{						
						notice_search();
					}
					modalHide();
				})
			});
		</script>
		
		
		<table id="notice-list-table">
			<colgroup>
				<col style="width: 150px">
				<col style="width: 350px">
				<col style="width: 200px">
				<col style="width: 150px">
				<col style="width: 350px">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="5">등록된 공지가 없습니다.</td>
				</tr>
			</tbody>
		</table>
		
		<!-- 공지 내용 보기 / 입력 모달 -->
		<div class="modal-overlay">
			<div class="modal">
				<div class="modal-header">
					<img src="${contextPath}/icon/x.png" class="modalHide">
				</div>
				<h3>NOTICE</h3>
				<table>
					<colgroup>
						<col style="width: 10%">
						<col style="width: 10%">
						<col style="width: 20%">
						<col style="width: 20%">
						<col style="width: 20%">
						<col style="width: 20%">
					</colgroup>
					<tbody>
						<tr>
							<th>번호</th>
							<td>
								<input type="text" id="modal-noticeNo" class="modal_data" >
							</td>
							<th>조회수</th>
							<td>
								<input type="text" id="modal-noticeCount" class="modal_data" >
							</td>
							<th>작성자</th>
							<td>
								<input type="text" id="modal-noticeWriter" class="modal_data" >
							</td>
						</tr>
						<tr>
							<th colspan="2">작성일</th>
							<td colspan="4">
								<input type="text" id="modal-createDate" class="modal_data" >
							</td>
						</tr>
						<tr>
							<th colspan="2">제목</th>
							<td colspan="4">
								<input type="text" id="modal-noticeTitle" class="modal_data modal_insert" >
							</td>
						</tr>
						<tr>
							<th colspan="2">내용</th>
							<td colspan="4">
								<span id="note">
									<textarea id="summernote" class="modal_insert"></textarea>
								</span>
								<div id="modal-noticeContent" class="modal_data"></div>
							</td>
						</tr>
					</tbody>
				</table>
				<div id="modal-btn-area">
					<button id="notice-edit-btn" onclick="notice_edit();">수정</button>
					<button id="notice-delete-btn" onclick="notice_delete();">삭제</button>
					<button id="notice-update-btn" onclick="notice_update();">등록</button>
					<button id="notice-insert-btn" onclick="notice_insert('${loginUser.empNo}');">작성</button>
				</div>
				<script>
			      $(function(){
			          $('#summernote').summernote({
			              placeholder: '내용을 입력해주세요',
			              tabsize: 2,
			              width: 800,
			              height: 550,
			              maxHeight: 550,
			              minHeight: 550,
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
			      })
			    </script>
			    <script>
			    	$(function(){
			    		var user = "${loginUser.empName}";
			    		if(user != "admin"){
			    			$("#modal-btn-area").hide();
			    		}
			    	})
			    </script>
			</div>
		</div>
	</div>
</body>
</html>