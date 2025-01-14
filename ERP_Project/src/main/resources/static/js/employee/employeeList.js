//거래처 리스트
function employee_list() {
	$.ajax({
		url: "/erp/employee/list",
		method: 'GET',
		data: {
			currentPage: $("#employee-currentPage").val()
		},
		success: function(data) {
			var pi = data.pi;
			var result = data.result;
			if (result.length == 0) {
				var tr = $("<tr>");
				tr.append($("<td colspan='5'>").text("조회된 사원이 없습니다."));
				$("#employee-table>tbody").html(tr);
			} else {
				var tbody = $("<tbody>");
				for (var e of result) {
					var tr = $("<tr>");
					tr.append($("<td>").append(e.empNo));
					tr.append($("<td>").append(e.deptName));
					tr.append($("<td>").append(e.rankName));
					tr.append($("<td>").append(e.empName));
					tr.append($("<td>").append(e.joinDate.split(" ")[0]));
					tbody.append(tr);
				}
				$("#employee-table>tbody").remove();
				$("#employee-table").append(tbody);

				$("#employee-currentPage").val(pi.currentPage);
				$("#employee-maxPage").text(pi.maxPage);
			}
		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		}
	})
}




//사원 검색
function employee_search() {
	$.ajax({
		url: "/erp/employee/search",
		method: 'GET',
		data: {
			currentPage: $('#employee-currentPage').val(),
			keyword: $("#employee-search-keyword").val(),
			mode: $("#employee-search-select").val()
		},
		success: function(data) {
			var pi = data.pi;
			var result = data.result;
			if (result.length == 0) {
				var tr = $("<tr>");
				tr.append($("<td colspan='5'>").text("조회된 사원이 없습니다."));
				$("#employee-table>tbody").html(tr);
			} else {
				var tbody = $("<tbody>");
				for (var e of result) {
					var tr = $("<tr>");
					tr.append($("<td>").append(e.empNo));
					tr.append($("<td>").append(e.deptName));
					tr.append($("<td>").append(e.rankName));
					tr.append($("<td>").append(e.empName));
					tr.append($("<td>").append(e.joinDate.split(" ")[0]));
					tbody.append(tr);
				}
				$("#employee-table>tbody").remove();
				$("#employee-table").append(tbody);

				$("#employee-currentPage").val(pi.currentPage);
				$("#employee-maxPage").text(pi.maxPage);
			}
		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		}
	});
};

function employee_info(empNo) {
	$.ajax({
		url: "/erp/employee/info",
		method: 'GET',
		data: {
			empNo: empNo
		},
		success: function(data) {
			$("#modal-empNo").val(data.empNo);
			$("#modal-deptName").val(data.deptName);
			$("#modal-rankName").val(data.rankName);
			$("#modal-empName").val(data.empName);
			$("#modal-phone").val(data.phone);
			$("#modal-email").val(data.email);
			$("#modal-address").val(data.address);
			$("#modal-birthday").val(data.birthday);
			$("#modal-joinDate").val(data.joinDate.split(" ")[0]);

		},
		error: function(error) {
			console.error('AJAX 요청 실패:', error);
		},
		complete: function() {
			modalShow();
		}
	});
};
