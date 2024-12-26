//거래처 리스트
function item_customer_list(){
	$.ajax({
		url : "/erp/item/customer/list",
        method: 'GET',
        data : {
			currentPage : $("#customer-currentPage").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 거래처가 없습니다."));
				$("#item-customer-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var c of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(c.customerNo));
					tr.append($("<td>").append(c.customerName));
					tr.append($("<td>").append(c.customerTel));
					tr.append($("<td>").append(c.customerAddress));
					tbody.append(tr);
				}
				$("#item-customer-table>tbody").remove();
				$("#item-customer-table").append(tbody);
				
				$("#customer-currentPage").val(pi.currentPage);
				$("#customer-maxPage").val(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}




//거래처 검색
function item_customer_search(){
	$.ajax({
		url : "/erp/item/customer/search",
        method: 'GET',
        data : {
			currentPage : $('#customer-currentPage').val(),
			keyword : $("#item-customer-search-keyword").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 거래처가 없습니다."));
				$("#item-customer-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var c of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(c.customerNo));
					tr.append($("<td>").append(c.customerName));
					tr.append($("<td>").append(c.customerTel));
					tr.append($("<td>").append(c.customerAddress));
					tbody.append(tr);
				}
				$("#item-customer-table>tbody").remove();
				$("#item-customer-table").append(tbody);
				
				$("#customer-currentPage").val(pi.currentPage);
				$("#customer-maxPage").val(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
};


//거래처 추가
function item_customer_add(){
	var name = $(".modal-input1").val();
	var tel = $(".modal-input2").val();
	var address = $(".modal-input3").val();
	$.ajax({
		url : "/erp/item/customer/insert",
		method : 'GET',
		data : {
			customerName : name,
			customerTel : tel,
			customerAddress : address
		},
		success : function(result){
			if(result=="NNNNY"){
				$(".modal>table input").val('');
				modalHide();
				$("#item-customer-search-keyword").val('');
				$('#customer-currentPage').val('1');
				item_customer_list();
				alert("추가완료");
			}
		},
        error: function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
}; 

//거래처 정보 수정
function item_customer_info(){
	
};

//모달 내부 dom 변경
function item_customer_modal_add(){	//거래처 추가
	modalShow();
	$(".modal .modalMode").val('1');
	$(".modal h3").text("거래처 추가");
}
function item_customer_modal_info(list){	//거래처 수정
	modalShow();
	$(".modal .modalMode").val('2');
	$(".modal h3").text("거래처 정보 수정");
	
	$(".modal-customerNo").val(list[0]);
	$(".modal-input1").val(list[1]);
	$(".modal-input2").val(list[2]);
	$(".modal-input3").val(list[3]);
}