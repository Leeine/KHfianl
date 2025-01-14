function modal_employee_appointment(){
	var th = $("#emp-appointment-table>thead>tr>th");
	th.eq(0).text($("#modal-empNo").val());
	th.eq(1).text($("#modal-deptName").val());
	th.eq(2).text($("#modal-rankName").val());
	th.eq(3).text($("#modal-empName").val());
	
	$("#emp-info-table").hide();
	$(".modal-submit-btn").hide();
	$("#emp-appointment-table").show();
	$(".appointment-btn").show();
	$(".modal>h3").text("인사 발령");
}
function modal_appointment_reset(){
	$("#emp-info-table").show();
	$(".modal-submit-btn").show();
	$("#emp-appointment-table").hide();
	$(".appointment-btn").hide();
	$(".modal>h3").text("사원 정보");
}

function appointment_dept_list(){
	$("#appointment-dept-list").empty();
	$.ajax({
		url: "/erp/admin/deptList",
		method: "GET",
		success: function(list) {
			var opt = $("<option>").val("NULL").text("미선택(부서)");
			$("#appointment-dept-list").append(opt);
			for (var d of list) {
				var opt = $("<option>").val(d.deptCode).text(d.deptName);
				$("#appointment-dept-list").append(opt);
			}
		},
		error: function(error) {
			console.log("AJAX 통신 오류", error);
		}
	})
}

function appointment_rank_list(){
	$("#appointment-rank-list").empty();
	$.ajax({
		url: "/erp/admin/empRankList",
		method: "GET",
		success: function(list) {
			var opt = $("<option>").val("NULL").text("미선택(직급)");
			$("#appointment-rank-list").append(opt);
			for (var r of list) {
				var opt = $("<option>").val(r.empRank).text(r.rankName);
				$("#appointment-rank-list").append(opt);
			}
		},
		error: function(error) {
			console.log("AJAX 통신 오류", error);
		}
	})
}

function appointment(url,empNo,pk){
	$.ajax({
		url: "/erp/employee/appointment/"+url,
		method: "POST",
		data :{
			empNo : empNo,
			data : pk
		},
		success: function(result) {
			if(result == "NNNNY"){
				alert("인사 발령 완료");
				employee_list();
				appointment_rank_list();
				appointment_dept_list();
                $('#appointment-select').val('dept').trigger('change');
				$(".modal-input").val('');
				modal_appointment_reset();
				modalHide();
			}else{
				alert("다시 시도해주십시오");
			}
		},
		error: function(error) {
			console.log("AJAX 통신 오류", error);
		}
	})
}
//인사 발령 리스트
function appointment_list(){
	$.ajax({
		url: "/erp/employee/appointment/list",
		method: "GET",
		data: {
			currentPage: $('#appointment-currentPage').val(),
		},
		success: function(data) {
			var pi = data.pi;
			var result = data.result;
			if (result.length == 0) {
				var tr = $("<tr>");
				tr.append($("<td colspan='6'>").text("조회된 기록이 없습니다."));
				$("#appointment-table>tbody").html(tr);
			} else {
				var tbody = $("<tbody>");
				for (var a of result) {
					var tr = $("<tr>");
					tr.append($("<td>").append(a.appointmentNo));
					tr.append($("<td>").append(a.empName));
					tr.append($("<td>").append(a.appointmentDate));
					tr.append($("<td>").append(a.appointmentTypeName));
					if(a.deptName == null){
						tr.append($("<td>").append("-"));
					}else{						
						tr.append($("<td>").append(a.deptName));
					}
					if(a.rankName == null){
						tr.append($("<td>").append("-"));
					}else{
						tr.append($("<td>").append(a.rankName));
					}
					tbody.append(tr);
				}
				$("#appointment-table>tbody").remove();
				$("#appointment-table").append(tbody);

				$("#appointment-currentPage").val(pi.currentPage);
				$("#appointment-maxPage").text(pi.maxPage);
			}
		},
		error: function(error) {
			console.log("AJAX 통신 오류", error);
		}
	})
}
//인사 발령 검색
function appointment_search(){
	console.log($("#appointment-search-keyword").val());
	$.ajax({
		url: "/erp/employee/appointment/search",
		method: "GET",
		data: {
			currentPage: $('#appointment-currentPage').val(),
			keyword: $("#appointment-search-keyword").val(),
			mode: $("#appointment-search-select").val()
		},
		success: function(data) {
			var pi = data.pi;
			var result = data.result;
			if (result.length == 0) {
				var tr = $("<tr>");
				tr.append($("<td colspan='6'>").text("조회된 기록이 없습니다."));
				$("#appointment-table>tbody").html(tr);
			} else {
				var tbody = $("<tbody>");
				for (var a of result) {
					var tr = $("<tr>");
					tr.append($("<td>").append(a.appointmentNo));
					tr.append($("<td>").append(a.empName));
					tr.append($("<td>").append(a.appointmentDate));
					tr.append($("<td>").append(a.appointmentTypeName));
					if(a.deptName == null){
						tr.append($("<td>").append("-"));
					}else{						
						tr.append($("<td>").append(a.deptName));
					}
					if(a.rankName == null){
						tr.append($("<td>").append("-"));
					}else{
						tr.append($("<td>").append(a.rankName));
					}
					tbody.append(tr);
				}
				$("#appointment-table>tbody").remove();
				$("#appointment-table").append(tbody);

				$("#appointment-currentPage").val(pi.currentPage);
				$("#appointment-maxPage").text(pi.maxPage);
			}
		},
		error: function(error) {
			console.log("AJAX 통신 오류", error);
		}
	})
}

//사원 추가
function appointment_insert_employee(){
	$.ajax({
		url: "/erp/employee/insert",
		method: "POST",
		data :{
			empName : $("#modal-empName").val(),
			deptCode : $("#select-dept").val(),
			empRank : $("#select-rank").val()
		},
		success: function(result) {
			if(result == "NNNNY"){
				alert("인사 발령 완료");
				$(".modal-input").val('');
				appointment_list();
				modalHide();
			}else{
				alert("다시 시도해주십시오");
			}
		},
		error: function(error) {
			console.log("AJAX 통신 오류", error);
		}
	})
}

//부서목록
function appointmentDeptList() {
	$.ajax({
		url: "/erp/admin/deptList",
		method: "GET",
		success: function(list) {
			for (var d of list) {
				var opt = $("<option>").val(d.deptCode).text(d.deptName);
				$("#select-dept").append(opt);
			}
		},
		error: function(error) {
			console.log("AJAX 통신 오류", error);
		}
	})
}
//직급목록
function appointmentRankList() {
	$.ajax({
		url: "/erp/admin/empRankList",
		method: "GET",
		success: function(list) {
			for (var r of list) {
				var opt = $("<option>").val(r.empRank).text(r.rankName);
				$("#select-rank").append(opt);
			}
		},
		error: function(error) {
			console.log("AJAX 통신 오류", error);
		}
	})
}