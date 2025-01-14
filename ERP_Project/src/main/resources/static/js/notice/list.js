//공지글 리스트
function notice_list() {
	$.ajax({
		url: "/erp/notice/list",
		method: 'GET',
		data: {
			currentPage: $('#notice-currentPage').val()
		},
		success: function(data) {
			var pi = data.pi;
			var result = data.result;
			if (result.length == 0) {
				var tr = $("<tr>");
				tr.append($("<td colspan='5'>").text("조회된 공지가 없습니다."));
				$("#notice-list-table>tbody").html(tr);
			} else {
				var tbody = $("<tbody>");
				for (var n of result) {
					var tr = $("<tr>");
					tr.append($("<td>").append(n.noticeNo));
					tr.append($("<td>").append(n.noticeTitle));
					tr.append($("<td>").append(n.empName));
					tr.append($("<td>").append(n.noticeCount));
					tr.append($("<td>").append(n.createDate));
					tbody.append(tr);
				}
				$("#notice-list-table>tbody").remove();
				$("#notice-list-table").append(tbody);

				$("#notice-currentPage").val(pi.currentPage);
				$("#notice-maxPage").text(pi.maxPage);
			}
		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		}
	})
}

//공지글 검색
function notice_search() {
	$.ajax({
		url: "/erp/notice/search",
		method: 'GET',
		data: {
			currentPage: $('#notice-currentPage').val(),
			keyword: $("#notice-list-search-keyword").val(),
			mode: $("#notice-list-search-select").val()
		},
		success: function(data) {
			var pi = data.pi;
			var result = data.result;
			if (result.length == 0) {
				var tr = $("<tr>");
				tr.append($("<td colspan='5'>").text("조회된 공지가 없습니다."));
				$("#notice-list-table>tbody").html(tr);
			} else {
				var tbody = $("<tbody>");
				for (var n of result) {
					var tr = $("<tr>");
					tr.append($("<td>").append(n.noticeNo));
					tr.append($("<td>").append(n.noticeTitle));
					tr.append($("<td>").append(n.empName));
					tr.append($("<td>").append(n.noticeCount));
					tr.append($("<td>").append(n.createDate));
					tbody.append(tr);
				}
				$("#notice-list-table>tbody").remove();
				$("#notice-list-table").append(tbody);

				$("#notice-currentPage").val(pi.currentPage);
				$("#notice-maxPage").text(pi.maxPage);
			}
		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		}
	});
};


//상세보기
function notice_modal_detail(noticeNo) {
	//기존 모달창에서 입력된값 모두 비우기
	clear();
	//모달 사이즈 변경
	$(".modal").css({
		"width": "1200px",
		"height": "800px"
	});
	//부장급인 경우만 해당
	//수정, 삭제 버튼만 보여주기
	$("#notice-edit-btn").show();
	$("#notice-delete-btn").show();
	$("#notice-update-btn").hide();
	$("#notice-insert-btn").hide();
	//입력시 숨겨놨던 공지 번호, 작성자, 조회수, 작성일 띄우기
	$(".modal tbody").find("tr").eq(0).show();
	$(".modal tbody").find("tr").eq(1).show();
	//summernote 숨기고 공지내용 div 보여주기
	$("#modal-noticeContent").show();
	$("#note").hide();
	//input 요소 읽기 전용으로 바꾸기
	$(".modal_data").each(function() {
		$(this).attr("readonly", "true");
	});

	//dom요소 변경이 끝났으니 ajax로 공지 세부정보 가져오기
	$.ajax({
		url: "/erp/notice/detail",
		method: 'GET',
		data: {
			noticeNo: noticeNo
		},
		success: function(data) {
			$("#modal-noticeNo").val(data.noticeNo);
			$("#modal-noticeTitle").val(data.noticeTitle);
			$("#modal-noticeContent").html(data.noticeContent);
			$("#modal-noticeWriter").val(data.empName);
			$("#modal-noticeCount").val(data.noticeCount);
			$("#modal-createDate").val(data.createDate);

		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		},
		complete: function() {
			//공지까지 모두 불러온 후 모달창 띄우기
			modalShow();
		}
	})

}

//입력 초기화
function clear() {
	$(".modal_data").val('');
	$("#modal-noticeContent").html('');
	$("#summernote").summernote("code", "");
}


//공지 입력 모달 띄우기
function notice_insert_modal() {
	//모달창 사이즈 변경
	$(".modal").css({
		"width": "1200px",
		"height": "800px"
	});
	//공지 입력을 위해 input의 readonly 속성값 삭제하기 (기본값 readonly)
	$(".modal_data").each(function() {
		$(this).removeAttr("readonly");
	});

	//공지 내용 div 숨기고 summernote 보여주기
	$("#modal-noticeContent").hide();
	$("#note").show();

	//작성 관련된 버튼만 보여주기
	$("#notice-edit-btn").hide();
	$("#notice-delete-btn").hide();
	$("#notice-update-btn").hide();
	$("#notice-insert-btn").show();

	//제목, 내용을 제외한 항목 숨기기
	$(".modal tbody").find("tr").eq(0).hide();
	$(".modal tbody").find("tr").eq(1).hide();

	//모든 dom요소 변경이 끝났으니 모달 띄워서 사용자에게 보여주기
	modalShow();
}

//공지 입력
function notice_insert(writer) {
	$.ajax({
		url: "/erp/notice/insert",
		method: "POST",
		data: {
			noticeWriter: writer,
			noticeTitle: $("#modal-noticeTitle").val(),
			noticeContent: $("#summernote").val()
		},
		success: function(result) {
			if (result == "NNNNY") {
				alert("작성 완료");
			} else {
				alert("작성 실패");
			}
		},
		error: function(error) {
			console.log("AJAX 통신 실패", error);
		},
		complete: function() {
			clear();
			notice_list();
			modalHide();
		}
	})
}

//수정 버튼 눌렀을 시 모달 내부 dom 요소 변경
function notice_edit() {
	//수정을 위해 input의 readonly 속성 삭제하기
	$(".modal_data").each(function() {
		$(this).removeAttr("readonly");
	});

	//저장된 공지 summernote에 불러오기
	$("#summernote").summernote("code", $("#modal-noticeContent").html());

	//공지 내용 div 숨기고 공지 내용 불러온 summernote textarea 표시하기
	$("#modal-noticeContent").hide();
	$("#note").show();

	//수정 관련된 버튼만 보여주기
	$("#notice-edit-btn").hide();
	$("#notice-delete-btn").hide();
	$("#notice-insert-btn").hide();
	$("#notice-update-btn").show();

	//제목과 내용 항목 제외하고 숨기기
	$(".modal tbody").find("tr").eq(0).hide();
	$(".modal tbody").find("tr").eq(1).hide();
}

//공지 수정
function notice_update() {
	$.ajax({
		url: "/erp/notice/update",
		method: "POST",
		data: {
			noticeNo: $("#modal-noticeNo").val(),
			noticeTitle: $("#modal-noticeTitle").val(),
			noticeContent: $("#summernote").val()
		},
		success: function(result) {
			if (result == "NNNNY") {
				alert("수정 완료");
			} else {
				alert("수정 실패");
			}
		},
		error: function(error) {
			console.log("AJAX 통신 실패", error);
		},
		complete: function() {
			clear();
			notice_list();
			modalHide();
		}
	})
}

//공지 삭제
function notice_delete() {
	$.ajax({
		url: "/erp/notice/delete",
		method: "POST",
		data: {
			noticeNo: $("#modal-noticeNo").val()
		},
		success: function(result) {
			if (result == "NNNNY") {
				alert("삭제 완료");
			} else {
				alert("삭제 실패");
			}
		},
		error: function(error) {
			console.log("AJAX 통신 실패", error);
		},
		complete: function() {
			clear();
			notice_list();
			modalHide();
		}
	})
}