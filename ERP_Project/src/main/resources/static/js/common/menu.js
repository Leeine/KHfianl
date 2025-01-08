//
function pageChange(){
	$(".modal-overlay").remove();
	$("#index-content-block").hide();
	$("#main-content-block").show();
}


//------------제품 관리-------------

//거래처 등록 페이지 불러오기
function itemCustomerPage(){
	pageChange();
	$.ajax({
		url : "/erp/item/customer",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>거래처 관리</h1>")
			$("#main-content-block").html($(data).filter("#item-customer-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//재고 현황 페이지 불러오기
function itemListPage(){
	pageChange();
	$.ajax({
		url : "/erp/item/stock",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>재고 현황</h1>")
			$("#main-content-block").html($(data).filter("#item-stock-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//발주 페이지 불러오기
function itemOrderPage(){
	pageChange();
	$.ajax({
		url : "/erp/item/order",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>발주 현황</h1>")
			$("#main-content-block").html($(data).filter("#item-order-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//판매 페이지 불러오기
function itemSellPage(){
	pageChange();
	$.ajax({
		url : "/erp/item/sell",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>판매 현황</h1>")
			$("#main-content-block").html($(data).filter("#item-sell-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//출하 페이지 불러오기
function itemReleasePage(){
	pageChange();
	$.ajax({
		url : "/erp/item/release",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>출하 현황</h1>")
			$("#main-content-block").html($(data).filter("#item-release-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};


//------------마이페이지-------------
function employeeMypage(){
	pageChange();
	$.ajax({
		url : "/erp/employee/mypage",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>내 정보</h1>")
			$("#main-content-block").html($(data).filter("#employee-mypage-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//-------------- 공지 -----------------
function noticePage(){
	pageChange();
	$.ajax({
		url : "/erp/notice/page",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>공지</h1>")
			$("#main-content-block").html($(data).filter("#notice-list-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

