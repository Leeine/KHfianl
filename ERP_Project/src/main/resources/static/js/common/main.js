function itemPage(){
	$.ajax({
		url : "/erp/item/managementPage",
        method: 'GET',
        success: function (data) {
			$("#main-content-block").html($(data).filter("#item-management-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};