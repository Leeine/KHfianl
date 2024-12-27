//재고 리스트
function item_stock_list(){
	$.ajax({
		url : "/erp/item/stock/list",
        method: 'GET',
        data : {
			currentPage : $("#stock-currentPage").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 거래처가 없습니다."));
				$("#item-stock-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var c of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(c.itemCode));
					tr.append($("<td>").append(c.itemName));
					tr.append($("<td>").append(c.itemPrice));
					tr.append($("<td>").append(c.itemCount)); 
					tr.append($("<td>").append(c.itemCategoryName));
					tbody.append(tr);
				}
				$("#item-stock-table>tbody").remove();
				$("#item-stock-table").append(tbody);
				
				$("#stock-currentPage").val(pi.currentPage);
				$("#stock-maxPage").text(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}




//재고 검색
function item_stock_search(){
	$.ajax({
		url : "/erp/item/stock/search",
        method: 'GET',
        data : {
			currentPage : $('#stock-currentPage').val(),
			keyword : $("#item-stock-search-keyword").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 거래처가 없습니다."));
				$("#item-stock-table>tbody").html(tr);
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
				$("#item-stock-table>tbody").remove();
				$("#item-stock-table").append(tbody);
				
				$("#stock-currentPage").val(pi.currentPage);
				$("#stock-maxPage").text(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
};


//제품 정보 수정
function item_stock_info(){
	var no = $(".modal-stockNo").val();
	var name = $(".modal-input1").val();
	var tel = $(".modal-input2").val();
	var address = $(".modal-input3").val();
	$.ajax({
		url : "/erp/item/stock/update",
		method : 'GET',
		data : { 




		},
		success : function(result){
			if(result=="NNNNY"){
				$(".modal>table input").val('');
				modalHide();
				$("#item-stock-search-keyword").val('');
				$('#stock-currentPage').val('1');
				item_stock_list();
				alert("수정 완료");
			}else{
				alert("수정 실패");
			}
		},
        error: function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
};

//모달 내부 dom 변경
function item_stock_modal_info(list){	//제품 정보 수정
	modalShow();
	$(".modal h3").text("제품 정보 수정");
	
	$(".modal-itemNo").val(list[0]);
	$(".modal-input1").val(list[1]);
	$(".modal-input2").val(list[2]);
	$(".modal-input3").val(list[3]);
}
