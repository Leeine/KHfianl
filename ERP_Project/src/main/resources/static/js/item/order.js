//발주 리스트
function item_order_list(){
	$.ajax({
		url : "/erp/item/order/list",
        method: 'GET',
        data : {
			currentPage : $("#order-currentPage").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 거래처가 없습니다."));
				$("#item-order-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var c of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(c.orderNo));
					tr.append($("<td>").append(c.customerName));
					tr.append($("<td>").append(c.itemName));
					tr.append($("<td>").append(c.orderCount));
					tr.append($("<td>").append(c.orderPrice));
					tr.append($("<td>").append(c.orderDate));
					tr.append($("<td>").append(c.empName));
					tbody.append(tr);
				}
				$("#item-order-table>tbody").remove();
				$("#item-order-table").append(tbody);
				
				$("#order-currentPage").val(pi.currentPage);
				$("#order-maxPage").text(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}




//발주서 검색
function item_order_search(){
	$.ajax({
		url : "/erp/item/order/search",
        method: 'GET',
        data : {
			currentPage : $('#order-currentPage').val(),
			keyword : $("#item-order-search-keyword").val(),
			mode : $("#item-order-search-select").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 발주가 없습니다."));
				$("#item-order-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var c of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(c.orderNo));
					tr.append($("<td>").append(c.customerName));
					tr.append($("<td>").append(c.itemName));
					tr.append($("<td>").append(c.orderCount));
					tr.append($("<td>").append(c.orderPrice));
					tr.append($("<td>").append(c.orderDate));
					tr.append($("<td>").append(c.empName));
					tbody.append(tr);
				}
				$("#item-order-table>tbody").remove();
				$("#item-order-table").append(tbody);
				
				$("#order-currentPage").val(pi.currentPage);
				$("#order-maxPage").text(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
};

//발주서 작성
function item_order_add(){
	var customer = $("#modal-input-customer").val();
	var item = $("#modal-input-item").val();
	var count = $("#modal-input-count").val();
	var price = $("#modal-input-price").val();
	var employee = $("#modal-input-employee").val();
	
	$.ajax({
		url : "/erp/item/order/insert",
		method : 'POST',
		data : {
			customerNo : customer,
			itemCode : item,
			orderCount : count,
			orderPrice : price,
			empNo : employee
		},
		success : function(result){
			if(result=="NNNNY"){
				$(".modal>table input").val('');
				modalHide();
				$("#item-order-search-keyword").val('');
				$('#order-currentPage').val('1');
				item_order_list();
				alert("등록 완료");
			}else{
				alert("등록 실패");
			}
		},
        error: function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
	
}; 



//발주서 작성 내 검색
function item_order_modal_search(keyword,str){
	$.ajax({
		url : "/erp/item/order/"+str,
		method : "GET",
		data : {
			keyword : keyword
		},
		success : function (data){
			if(data == ''){
				$("#order-"+str).html('');
				$("#modal-input-"+str).val('');
			}else{
				var box = $("<div>").addClass("suggestion_box");
				for(var d of data){
					var div = $("<div>").addClass("suggested_items");
					if(str == "customer"){
						var value1 = d.customerName;
						var value2 = d.customerNo;
					}else if(str == "item"){
						var value1 = d.itemName;
						var value2 = d.itemCode;
					}
					$("#modal-input-"+str).val(value2);
					div.text(value1);
					div.append($("<input>").attr("type","hidden").val(value2));
					box.append(div);
				}
				$("#order-"+str).html(box);
			}
		},
        error: function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}

//입력 버튼
function modal_submit(){
	var flag = true;
	$(".modal-input").each(function(){
		var category = $(this).closest("tr").find("th").text();
		var value = $(this).val();
		if(value=='' || value == 0){
			alert('"'+category+'"이(가) 존재하지 않습니다.');
			flag = false;
			return false;
		}
	})
	if(flag){		
		item_order_add();
	}
}
