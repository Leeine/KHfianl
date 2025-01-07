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
				tr.append($("<td colspan='5'>").text("조회된 제품이 없습니다."));
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
				tr.append($("<td colspan='5'>").text("조회된 제품이 없습니다."));
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
	});
};


//제품 정보 수정
function item_stock_info(){
	var code = $(".modal-itemCode").val();
	var name = $(".modal-input1").val();
	var price = $(".modal-input2").val();
	var clist = [];
	$(".item-category-checkbox:checked").each(function(){
		var cNo = $(this).parents("tr").children().eq(1).text();
		clist.push(cNo);
	});
	var category = clist.join(", ");
	$.ajax({
		url : "/erp/item/stock/update",
		method : 'POST',
		data : { 
			itemCode : code,
			itemName : name,
			itemPrice : price,
			itemCategoryName : category
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

//제품 정보 불러오기
function item_detail(itemCode){
	$.ajax({
		url : "/erp/item/stock/detail",
		method : "POST",
		data : {
			itemCode : itemCode
		},
		success : function(data){
			var item = data.item;
			var category = data.category;
			$(".modal-itemCode").val(item.itemCode);
			$(".modal-input1").val(item.itemName);
			$(".modal-input2").val(item.itemPrice);
			$(".modal-input3").val(item.itemCategoryName);arguments
			
			//해당되는 카테고리에 체크
			for(var c of category){
				$(".item-category-checkbox").each(function(){
					var cNo = $(this).parents("tr").children().eq(1).text();
					if(c.itemCategoryNo == cNo){
						$(this).prop("checked", true);
					}
				});
			}	
		},
		error : function(error){
            console.error('AJAX 요청 실패:', error);
		}
	})
}

//카테고리 리스트
function item_category_list(itemCode){
	$.ajax({
		url : "/erp/item/stock/categorylist",
		method : "POST",
		success : function(data){
			var tbody = $("<tbody>");
			for(var c of data){
				var tr = $("<tr>");
				tr.append($("<td>").append($("<input>").attr("type","checkbox").addClass("item-category-checkbox")));
				tr.append($("<td>").append(c.itemCategoryNo));
				tr.append($("<td>").append(c.itemCategoryName));
				tbody.append(tr);
			}
			$("#item-catagory-select-body>tbody").remove();
			$("#item-catagory-select-body").append(tbody);
		},
		error : function(error){
            console.error('AJAX 요청 실패:', error);
		},
		complete : function(){
			item_detail(itemCode);
		}
	})
}



//제품 정보
function item_stock_modal_info(list){	
	modalShow();
	$(".modal h3").text("제품 정보 수정");
	item_category_list(list[0]);
}
