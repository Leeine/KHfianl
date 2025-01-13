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
			var opt = $("<option>").val("null").text("미선택(부서)");
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
			var opt = $("<option>").val("null").text("미선택(직급)");
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
function appointment(url,empNo, pk){
	console.log(empNo +" "+ pk);
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