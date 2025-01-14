//index 페이지 div 숨기고 main페이지 div 표시
function pageChange(){
	$(".modal-overlay").remove();
	$("#index-content-block").hide();
	$("#main-content-block").show();
}


//------------전자 결재-------------

//결재 등록 페이지
function testDocument(){
	pageChange();
	$.ajax({
		url : "/erp/approve/insert",
		method: 'GET',
		success: function (data){ 
			$("#main-content-header").html("<h1>결재 서류</h1>");
            $("#main-content-block").html($(data).filter("#textdiv")[0]);
            
		},
		error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
		
	})
}

//결재 목록 페이지
function approveList(){
	pageChange();
	$.ajax({
		url : "/erp/approve/list",
		method: 'GET',
		success: function(data){
			$("#main-content-header").html("<br><h1>결재 서류 목록</h1>")
            $("#main-content-block").html($(data).filter("#listdiv")[0]);
		},
		error: function (error){
			console.error('AJAX 요청 실패:', error);
		}
	})
}

//------------인사 관리-------------

//사원목록 페이지 불러오기
function employeeListPage(){
	pageChange();
	$.ajax({
		url : "/erp/employee/list/page",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>사원 현황</h1>");
			$("#main-content-block").html($(data).filter("#employee-list-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};
//인사발령 페이지 불러오기
function personnelAppointmentPage(){
	pageChange();
	$.ajax({
		url : "/erp/employee/appointment/page",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>인사 발령</h1>");
			$("#main-content-block").html($(data).filter("#appointment-list-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//------------제품 관리-------------

//거래처 등록 페이지 불러오기
function itemCustomerPage(){
	pageChange();
	$.ajax({
		url : "/erp/item/customer",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>거래처 관리</h1>");
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
			$("#main-content-header").html("<h1>재고 현황</h1>");
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
			$("#main-content-header").html("<h1>발주 현황</h1>");
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
			$("#main-content-header").html("<h1>판매 현황</h1>");
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
			$("#main-content-header").html("<h1>출하 현황</h1>");
			$("#main-content-block").html($(data).filter("#item-release-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//------------근태-------------

//근태 항목 페이지 불러오기
function attemdance(){
	pageChange();
	$.ajax({
		url : "/erp/att/attListPage",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>근태 항목 관리</h1>");
			$("#main-content-block").html($(data).filter("#attemdance-main-page")[0]);
			console.log($(data).filter("#attemdance-main-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//사원 출퇴근 페이지 불러오기
function commute(){
	pageChange();
	$.ajax({
		url : "/erp/att/comPage",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>출퇴근 관리</h1>");
			$("#main-content-block").html($(data).filter("#attemdance-commute-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//사원 근태 페이지 불러오기
function empAttemdance(){
	pageChange();
	$.ajax({
		url : "/erp/att/empAttListPage",
        method: 'GET',
        success: function (data) {
			$("#main-content-header").html("<h1>사원 근태 관리</h1>");
			$("#main-content-block").html($(data).filter("#attemdance-emp-page")[0]);
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
			$("#main-content-header").html("<br><h1>내 정보</h1>")
			$("#main-content-block").html($(data).filter("#mypage_container")[0]);
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
			$("#main-content-header").html("<h1>공지</h1>");
			$("#main-content-block").html($(data).filter("#notice-list-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};

//-------------- 관리자 -----------------
function adminNoticePage(){
	pageChange();
	$.ajax({
		url : "/erp/admin/page",
        method: 'POST',
        success: function (data) {
			$("#main-content-header").html("<h1>관리자</h1>");
			$("#main-content-block").html($(data).filter("#admin-page")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};



