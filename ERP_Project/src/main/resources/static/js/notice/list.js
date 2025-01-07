//공지글 리스트
function notice_list(){
	$.ajax({
		url : "/erp/notice/list",
        method: 'GET',
        data : {
			empNo : $("#empNo").val()
		},
        success : function(data) {
			console.log(data);
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}