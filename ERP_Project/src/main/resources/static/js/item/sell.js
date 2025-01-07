//판매 기록 전체 리스트
function item_sell_list(){
	$.ajax({
		url : "/erp/item/sell/list",
        method: 'GET',
        data : {
			currentPage : $("#sell-currentPage").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='7'>").text("조회된 판매기록이 없습니다."));
				$("#item-sell-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var s of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(s.sellNo).addClass("sell-no"));
					tr.append(
						$("<td>").append(
							$("<input>").attr("type","hidden").val(s.itemCode).addClass("sell_itemCode")
							).append(s.itemName)
						);
					
					tr.append($("<td>").append(s.sellCount).addClass("sell-count"));
					tr.append($("<td>").append(s.sellPrice));
					tr.append($("<td>").append(s.sellPrice * s.sellCount));
					tr.append($("<td>").append(s.sellDate));
					if(s.releaseStatus=='N'){
						tr.append($("<td>").append($("<button>").text("출하").addClass("sell_release")));
					}else{
						tr.append($("<td>").append("완료"));
					}
					tbody.append(tr);
				}
				$("#item-sell-table>tbody").remove();
				$("#item-sell-table").append(tbody);
				
				$("#sell-currentPage").val(pi.currentPage);
				$("#sell-maxPage").text(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}




//판매 기록 검색
function item_sell_search(){
	$.ajax({
		url : "/erp/item/sell/search",
        method: 'GET',
        data : {
			currentPage : $('#sell-currentPage').val(),
			keyword : $("#item-sell-search-keyword").val(),
			mode : $("#item-sell-search-select").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='7'>").text("조회된 판매기록이 없습니다."));
				$("#item-sell-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var s of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(s.sellNo).addClass("sell-no"));
					tr.append(
						$("<td>").append(
							$("<input>").attr("type","hidden").val(s.itemCode).addClass("sell_itemCode")
							).append(s.itemName)
						);
					tr.append($("<td>").append(s.sellCount).addClass("sell-count"));
					tr.append($("<td>").append(s.sellPrice));
					tr.append($("<td>").append(s.sellPrice * s.sellCount));
					tr.append($("<td>").append(s.sellDate));
					if(s.releaseStatus=='N'){
						tr.append($("<td>").append($("<button>").text("출하").addClass("sell_release")));
					}else{
						tr.append($("<td>").append("완료"));
					}
					tbody.append(tr);
				}
				$("#item-sell-table>tbody").remove();
				$("#item-sell-table").append(tbody);
				
				$("#sell-currentPage").val(pi.currentPage);
				$("#sell-maxPage").text(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
};


//판매 기록 입력
function item_sell_add(arr){
	$.ajax({
		url : "/erp/item/sell/insert",
		method : 'POST',
		contentType : "application/json",
		data : JSON.stringify(arr),
		success : function(result){
			if(result=="NNNNY"){
				$(".modal>table input").val('');
				modalHide();
				$("#item-sell-search-keyword").val('');
				$('#sell-currentPage').val('1');
				item_sell_list();
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

//판매기록 작성 내 검색
function item_sell_modal_search(keyword){
	$.ajax({
		url : "/erp/item/order/item",
		method : "GET",
		data : {
			keyword : keyword
		},
		success : function (data){
			if(data == ''){
				$("#sell-item").html('');
				$("#modal-input-item").val('');
			}else{
				var box = $("<div>").addClass("suggestion_box");
				if(data.length == 1){
					$("#modal-input-item").val(data[0].itemCode);
				}else{
					$("#modal-input-item").val('');
				}
				for(var d of data){
					var div = $("<div>").addClass("suggested_items");
					div.text(d.itemName);
					div.append($("<input>").attr("type","hidden").val(d.itemCode));
					box.append(div);
				}
				$("#sell-item").html(box);
			}
		},
        error: function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}
//행 추가
function item_sell_submit_add(){
	
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
		
		var itemCode = $("#modal-input-item").val();
		var count = $("#modal-input-count").val();
		var price = $("#modal-input-price").val();
		var info = [itemCode,count,price];
		var tr = $("<tr>").append($("<td>").addClass("col-delete").text("x"));
		
		for (var i of info){
			var td = $("<td>").addClass("item-sell-list");
			td.append(i)
			tr.append(td);
		}
		$("#item-sell-submit-list>tbody").append(tr);
		
		$(".modal-input").val('');
	}
}

//입력 버튼
function modal_sell_submit(){
	var tr = $("#item-sell-submit-list>tbody>tr");
	if(tr.length > 0){
		const arr = [];
		tr.each(function(){
			var data = $(this).find(".item-sell-list");
			var sell = {
				itemCode : data.eq(0).text(),
				sellCount : data.eq(1).text(),
				sellPrice : data.eq(2).text()
			};
			arr.push(sell);
		})
		item_sell_add(arr);
	}else{
		alert("발주 항목이 없습니다.");
	}

}

//출하버튼
function sell_release(sellNo,itemCode,sellCount){
	$.ajax({
		url : "/erp/item/sell/release",
		method : "POST",
		data : {
			sellNo : sellNo,
			itemCode : itemCode,
			sellCount : sellCount
		},
		success : function (result){
			if(result=="NNNNY"){
				$(".modal>table input").val('');
				modalHide();
				$("#item-sell-search-keyword").val('');
				$('#sell-currentPage').val('1');
				item_sell_list();
				alert("출하 완료");
			}else{
				alert("출하 실패");
			}
		},
        error: function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}

function item_sell_modal(){
	$(".modal-input").val('');
	$("#item-sell-submit-list>tbody").html('');
	modalShow();
	
}
