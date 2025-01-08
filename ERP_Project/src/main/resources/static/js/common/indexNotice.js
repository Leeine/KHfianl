//-------------- index --------------
function indexNoticePage(){
	$.ajax({
		url : "/erp/notice/index",
        method: 'GET',
        success: function (data) {
			$("#index-notice-div").html($(data).filter("#table-wrap")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        },
        complete : function (){
			indexNoticeList();
		}
	})
};

//-------------- index페이지 -----------------
function indexNoticeList(){
	$.ajax({
		url : "/erp/notice/index/list",
        method: 'GET',
        success: function (data) {
			if(data.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 공지가 없습니다."));
				$("#index-notice-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var n of data){
					var tr = $("<tr>");
					tr.append($("<td>").append(n.noticeNo));
					tr.append($("<td>").append(n.noticeTitle));
					tr.append($("<td>").append(n.noticeCount));
					tr.append($("<td>").append(n.createDate));
					tbody.append(tr);
				}
				$("#index-notice-table>tbody").remove();
				$("#index-notice-table").append(tbody);
			}
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
	
}

