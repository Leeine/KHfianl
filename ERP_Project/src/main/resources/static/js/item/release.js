//거래처 리스트
function item_release_list(){
	$.ajax({
		url : "/erp/item/release/list",
        method: 'GET',
        data : {
			currentPage : $("#release-currentPage").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 출하 기록이 없습니다."));
				$("#item-release-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var r of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(r.releaseNo));
					tr.append($("<td>").append(r.itemName));
					tr.append($("<td>").append(r.releaseCount));
					tr.append($("<td>").append(r.releaseDate));
					tbody.append(tr);
				}
				$("#item-release-table>tbody").remove();
				$("#item-release-table").append(tbody);
				
				$("#release-currentPage").val(pi.currentPage);
				$("#release-maxPage").text(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}




//거래처 검색
function item_release_search(){
	$.ajax({
		url : "/erp/item/release/search",
        method: 'GET',
        data : {
			currentPage : $('#release-currentPage').val(),
			keyword : $("#item-release-search-keyword").val(),
			mode : $("#item-release-search-select").val()
		},
        success : function(data) {
			var pi = data.pi;
			var result = data.result;
			if(result.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 출하 기록이 없습니다."));
				$("#item-release-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var r of result){
					var tr = $("<tr>");
					tr.append($("<td>").append(r.releaseNo));
					tr.append($("<td>").append(r.itemName));
					tr.append($("<td>").append(r.releaseCount));
					tr.append($("<td>").append(r.releaseDate));
					tbody.append(tr);
				}
				$("#item-release-table>tbody").remove();
				$("#item-release-table").append(tbody);
				
				$("#release-currentPage").val(pi.currentPage);
				$("#release-maxPage").text(pi.maxPage);
			}
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	});
};
