//거래처 리스트
function item_customer_list(){
	$.ajax({
		url : "/erp/item/customer/list",
        method: 'GET',
        data : {
			currentPage : $("#customer-currentPage").val()
		},
        success: function (data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				$("#item-customer-table>tbody").remove();
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
        error: function (error) {
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
        success: function (data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				$("#item-customer-table>tbody").remove();
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
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};


