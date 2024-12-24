//거래처 등록 페이지
function item_customer_search(){
	$.ajax({
		url : "/erp/item/customer/search",
        method: 'GET',
        data : {
			currentPage : '1',
			keyword : $("#item-customer-search-keyword").val()
		},
        success: function (data) {
			console.log(data);
			
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};