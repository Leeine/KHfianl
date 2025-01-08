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
				tr.append($("<td colspan='7'>").text("조회된 발주 목록이 없습니다."));
				$("#item-order-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var o of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(o.orderNo));
					tr.append($("<td>").append(o.customerName));
					tr.append($("<td>").append(o.itemName));
					tr.append($("<td>").append(o.orderCount));
					tr.append($("<td>").append(o.orderPrice));
					tr.append($("<td>").append(o.orderDate));
					tr.append($("<td>").append(o.empName));
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
				tr.append($("<td colspan='7'>").text("조회된 발주 목록이 없습니다."));
				$("#item-order-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var o of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(o.orderNo));
					tr.append($("<td>").append(o.customerName));
					tr.append($("<td>").append(o.itemName));
					tr.append($("<td>").append(o.orderCount));
					tr.append($("<td>").append(o.orderPrice));
					tr.append($("<td>").append(o.orderDate));
					tr.append($("<td>").append(o.empName));
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
function item_order_add(arr){
	$.ajax({
		url : "/erp/item/order/insert",
		method : 'POST',
		contentType : "application/json",
		data : JSON.stringify(arr),
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
				if(data.length == 1){
					if(str == "customer"){
						$("#modal-input-item").val(data[0].customerNo);
					}else{
						$("#modal-input-item").val(data[0].itemCode);
					}
				}else{
					$("#modal-input-item").val('');
				}
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
function modal_order_submit(){
	var tr = $("#item-order-submit-list>tbody>tr");
	if(tr.length > 0){
		const arr = [];
		tr.each(function(){
			var data = $(this).find(".item-order-list");
			var order = {
				customerNo : data.eq(0).text(),
				itemCode : data.eq(1).text(),
				orderCount : data.eq(2).text(),
				orderPrice : data.eq(3).text(),
				empNo : data.eq(4).text()
			};
			arr.push(order);
		})
		item_order_add(arr);
	}else{
		alert("발주 항목이 없습니다.");
	}

}

//발주서 추가
function item_order_submit_add(){
	
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
		
		var customerNo = $("#modal-input-customer").val();
		var itemCode = $("#modal-input-item").val();
		var count = $("#modal-input-count").val();
		var price = $("#modal-input-price").val();
		var employeeNo = $("#modal-input-employee").val();
		var info = [customerNo,itemCode,count,price,employeeNo];
		var tr = $("<tr>").append($("<td>").addClass("col-delete").text("x"));
		
		for (var i of info){
			var td = $("<td>").addClass("item-order-list");
			td.append(i)
			tr.append(td);
		}
		$("#item-order-submit-list>tbody").append(tr);
		
		$(".modal-input").val('');
	}
}
function item_order_modal(){
	$(".modal-input").val('');
	$("#item-order-submit-list>tbody").html('');
	modalShow();
}
