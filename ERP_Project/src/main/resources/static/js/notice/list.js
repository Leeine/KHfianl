//공지글 리스트
function notice_list(){
	$.ajax({
		url : "/erp/notice/list",
        method: 'GET',
        data : {
			empNo : $("#empNo").val()
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

//detail

function notice_modal_detail(noticeNo){
	$(".modal_data").val('');
	$.ajax({
		url : "/erp/notice/detail",
        method: 'GET',
        data : {
			noticeNo : noticeNo
		},
        success : function(data) {
			$("#modal-noticeNo").val(data.noticeNo);
			$("#modal-noticeTitle").val(data.noticeTitle);
			$("#modal-noticeContent").val(data.noticeContent);
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