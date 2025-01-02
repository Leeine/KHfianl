//거래처 리스트
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
				tr.append($("<td colspan='4'>").text("조회된 거래처가 없습니다."));
				$("#item-sell-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var c of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(c.sellNo));
					tr.append($("<td>").append(c.sellName));
					tr.append($("<td>").append(c.sellTel));
					tr.append($("<td>").append(c.sellAddress));
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




//거래처 검색
function item_sell_search(){
	$.ajax({
		url : "/erp/item/sell/search",
        method: 'GET',
        data : {
			currentPage : $('#sell-currentPage').val(),
			keyword : $("#item-sell-search-keyword").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 거래처가 없습니다."));
				$("#item-sell-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var c of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(c.sellNo));
					tr.append($("<td>").append(c.sellName));
					tr.append($("<td>").append(c.sellTel));
					tr.append($("<td>").append(c.sellAddress));
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


//거래처 추가
function item_sell_add(){
	var name = $(".modal-input1").val();
	var tel = $(".modal-input2").val();
	var address = $(".modal-input3").val();
	$.ajax({
		url : "/erp/item/sell/insert",
		method : 'POST',
		data : {
			sellName : name,
			sellTel : tel,
			sellAddress : address
		},
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
