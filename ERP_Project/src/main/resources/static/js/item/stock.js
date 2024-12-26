//거래처 리스트
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
					tr.append($("<td>").append(c.stockNo));
					tr.append($("<td>").append(c.stockName));
					tr.append($("<td>").append(c.stockTel));
					tr.append($("<td>").append(c.stockAddress));
					tbody.append(tr);
				}
				$("#item-stock-table>tbody").remove();
				$("#item-stock-table").append(tbody);
				
				$("#stock-currentPage").val(pi.currentPage);
				$("#stock-maxPage").val(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}




//거래처 검색
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
					tr.append($("<td>").append(c.stockNo));
					tr.append($("<td>").append(c.stockName));
					tr.append($("<td>").append(c.stockTel));
					tr.append($("<td>").append(c.stockAddress));
					tbody.append(tr);
				}
				$("#item-stock-table>tbody").remove();
				$("#item-stock-table").append(tbody);
				
				$("#stock-currentPage").val(pi.currentPage);
				$("#stock-maxPage").val(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
};


//거래처 추가
function item_stock_add(){
	var name = $(".modal-input1").val();
	var tel = $(".modal-input2").val();
	var address = $(".modal-input3").val();
	$.ajax({
		url : "/erp/item/stock/insert",
		method : 'GET',
		data : {
			stockName : name,
			stockTel : tel,
			stockAddress : address
		},
		success : function(result){
			if(result=="NNNNY"){
				$(".modal>table input").val('');
				modalHide();
				$("#item-stock-search-keyword").val('');
				$('#stock-currentPage').val('1');
				item_stock_list();
				alert("추가완료");
			}
		},
        error: function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
}; 