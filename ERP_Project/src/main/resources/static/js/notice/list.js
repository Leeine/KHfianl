//공지글 리스트
function notice_list(){
	$.ajax({
		url : "/erp/notice/list",
        method: 'GET',
        data : {
			currentPage : $('#notice-currentPage').val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='5'>").text("조회된 공지가 없습니다."));
				$("#notice-list-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var n of result){
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
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}

//공지글 검색
function notice_search(){
	$.ajax({
		url : "/erp/notice/search",
        method: 'GET',
        data : {
			currentPage : $('#notice-currentPage').val(),
			keyword : $("#notice-list-search-keyword").val(),
			mode : $("#notice-list-search-select").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='5'>").text("조회된 공지가 없습니다."));
				$("#notice-list-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var n of result){
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
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
};


//상세보기
function notice_modal_detail(noticeNo){
	clear();
	$(".modal").css({
		"width" : "1200px",
		"height" : "800px"
	});
	$(".modal tbody").find("tr").eq(0).show();
	$(".modal tbody").find("tr").eq(1).show();
	$("#modal-noticeContent").show();
	$("#note").hide();
	$(".modal_data").each(function(){
		$(this).attr("readonly","true");
	});
	$.ajax({
		url : "/erp/notice/detail",
        method: 'GET',
        data : {
			noticeNo : noticeNo
		},
        success : function(data) {
			$("#modal-noticeNo").val(data.noticeNo);
			$("#modal-noticeTitle").val(data.noticeTitle);
			$("#modal-noticeContent").html(data.noticeContent);
			$("#modal-noticeWriter").val(data.empName);
			$("#modal-noticeCount").val(data.noticeCount);
			$("#modal-createDate").val(data.createDate);

        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
	modalShow();
}

//입력 초기화
function clear(){
	$(".modal_data").val('');
	$("#modal-noticeContent").html('');
	$("#summernote").val('');
}


//공지 입력 모달 띄우기
function notice_insert_modal(){
	$(".modal").css({
		"width" : "1200px",
		"height" : "800px"
	});
	$(".modal_data").each(function(){
		$(this).removeAttr("readonly");
	});
	$("#modal-noticeContent").hide();
	$("#note").show();
	modalShow();
	$(".modal tbody").find("tr").eq(0).hide();
	$(".modal tbody").find("tr").eq(1).hide();
}

//공지 입력 AJAX
function notice_insert(writer){
	$.ajax({
		url : "/erp/notice/insert",
		method : "POST",
		data : {
			noticeWriter : writer,
			noticeTitle : $("#modal-noticeTitle").val(),
			noticeContent : $("#summernote").val()
		},
		success : function (result){
			if(result =="NNNNY"){
				alert("작성 완료");
			}else{
				alert("작성 실패");
			}
		},
		error : function (error){
			console.log("AJAX 통신 실패" , error);
		},
		complete : function(){
			clear();
			notice_list();
			modalHide();
		}
	})
}