function sendAdminNotice() {
	var str = $("#admin-notice-input-text").val().replace(/\n/g, "<br>").replace(/(\s+)/g, (match) => '&nbsp;'.repeat(match.length));
	const adminNotice = {
		send: "admin",
		receive: "all",
		notice: str
	};

	// JSON 객체를 문자열로 변환 후 전송
	socket.send(JSON.stringify(adminNotice));
	$("#admin-notice-input-text").val('');
}
function empList(){
	$.ajax({
		url : "/erp/admin/empList",
		method : "GET",
		success : function(list) {
			$("#employee-list-area").html('');
			for(var e of list){
				var div = $("<div>").addClass("employee").append(e.empNo+" / "+e.deptName+" / "+e.rankName+" / "+e.empName);
				$("#employee-list-area").append(div);
			}
		},
		error : function (error){
			console.log("AJAX 통신 오류", error);
		}
	})
}
function empInsert(){
	$.ajax({
		url : "/erp/admin/empInsert",
		method : "POST",
		data : {
			deptCode : $("#dept-select").val(),
			empRank : $("#empRank-select").val(),
			empName : $("#admin-insert-employeeName").val()
		},
		success : function(result) {
			if(result == "NNNNY"){
				alert("등록 성공");
			}else{
				alert("등록 실패");
			}
		},
		error : function (error){
			console.log("AJAX 통신 오류", error);
		},
		complete : function(){
			$("#admin-insert-employeeName").val('');
			empList();
		}
	})
	
}
function itemList(){
	$.ajax({
		url : "/erp/admin/itemList",
		method : "GET",
		success : function(list) {
			$("#item-list-area").html('');
			for(var i of list){
				var div = $("<div>").append(i.itemName).addClass("item");
				$("#item-list-area").append(div);
			}
		},
		error : function (error){
			console.log("AJAX 통신 오류", error);
		}
	})
}
function itemInsert(){
	$.ajax({
		url : "/erp/admin/itemInsert",
		method : "POST",
		data : {
			itemName : $("#admin-insert-itemName").val(),
			itemPrice : $("#admin-insert-itemPrice").val()
		},
		success : function(result) {
			if(result == "NNNNY"){
				alert("등록 성공");
			}else{
				alert("등록 실패");
			}
		},
		error : function (error){
			console.log("AJAX 통신 오류", error);
		},
		complete : function(){
			$("#admin-insert-itemName").val('');
			itemList();
		}
	})
}
function categoryList(){
	$.ajax({
		url : "/erp/admin/categoryList",
		method : "GET",
		success : function(list) {
			$("#category-list-area").html('');
			for(var c of list){
				var div = $("<div>").append(c.itemCategoryName).addClass("categoryList");
				$("#category-list-area").append(div);
			}
		},
		error : function (error){
			console.log("AJAX 통신 오류", error);
		}
	})
}
function categoryInsert(){
	$.ajax({
		url : "/erp/admin/categoryInsert",
		method : "POST",
		data : {
			itemCategoryName : $("#admin-insert-categoryName").val()
		},
		success : function(result) {
			if(result == "NNNNY"){
				alert("등록 성공");
			}else{
				alert("등록 실패");
			}
		},
		error : function (error){
			console.log("AJAX 통신 오류", error);
		},
		complete : function(){
			$("#admin-insert-categoryName").val('');
			categoryList();
		}
	})
}
function deptList(){
	$.ajax({
		url : "/erp/admin/deptList",
		method : "GET",
		success : function(list) {
			for(var d of list){
				var opt = $("<option>").val(d.deptCode).text(d.deptName);
				$("#dept-select").append(opt);
			}
		},
		error : function (error){
			console.log("AJAX 통신 오류", error);
		}
	})
}
function empRankList(){
	$.ajax({
		url : "/erp/admin/empRankList",
		method : "GET",
		success : function(list) {
			for(var r of list){
				var opt = $("<option>").val(r.empRank).text(r.rankName);
				$("#empRank-select").append(opt);
			}
		},
		error : function (error){
			console.log("AJAX 통신 오류", error);
		}
	})
}