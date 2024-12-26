


//------------제품 관리-------------

//거래처 등록 페이지 불러오기
function itemCustomerPage(){
	$.ajax({
		url : "/erp/item/customer",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h2>거래처 관리</h2>")
			$("#main-content-block").html($(data).filter("#item-customer-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//재고 현황 페이지 불러오기
function itemListPage(){
	$.ajax({
		url : "/erp/item/list",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h2>재고 현황</h2>")
			$("#main-content-block").html($(data).filter("#item-list-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

function testDocument(){
	$.ajax({
		url : "/erp/approve/insert",
		method: 'GET',
		success: function (data){ 
			$("#main-content-header").html("<h2>결재 서류</h2>")
            $("#main-content-block").html($(data).filter("#textdiv")[0]);
            
		},
		error: function (error) {
            console.error('AJAX 요청 실패:', error);
        },
        complete : function(){
			testsummernote();
		}
		
	})
}
