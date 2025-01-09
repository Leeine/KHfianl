//메신저 사원 리스트(본인 제외)
function messenger_emp_list(empNo,contextPath){
	$.ajax({
		url : "/erp/employee/messenger/list",
        method: 'GET',
        data : {
			empNo : empNo
		},
        success : function(data) {
			$("#messenger-emplist-table>tbody").remove();
			var tbody = $("<tbody>");
			for(var d of data){
				var tr = $("<tr>").addClass("messenger-emplist");
				var td1 = $("<td>");
				td1.append($("<input>").attr("type","hidden").val(d.empNo).addClass("messenger-empNo"));
				td1.append($("<img>").attr("src",contextPath+"/icon/mypage.png").addClass("user-icon"));
				tr.append(td1);
				var td2 = $("<td>");
				td2.append($("<div>").addClass("messenger-emplist-dept").text(d.deptName));
				td2.append($("<div>").addClass("messenger-emplist-name").text(d.rankName +" "+ d.empName));
				tr.append(td2);
				tbody.append(tr);
			}
			$("#messenger-emplist-table").append(tbody);
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}

//메신저 사원 검색 리스트(본인 제외)
function messenger_emp_search_list(empNo,contextPath){
	$.ajax({
		url : "/erp/employee/messenger/search",
        method: 'GET',
        data : {
			//검색하려는 사원명
			empName : $("#messenger-search-keyword").val(),
			//검색에서 제외할 내 사원번호
			empNo : empNo
		},
        success : function(data) {
			$("#messenger-emplist-table>tbody").remove();
			var tbody = $("<tbody>");
			for(var d of data){
				var tr = $("<tr>").addClass("messenger-emplist");
				var td1 = $("<td>");
				td1.append($("<input>").attr("type","hidden").val(d.empNo));
				td1.append($("<img>").attr("src",contextPath+"/icon/mypage.png").addClass("user-icon"));
				tr.append(td1);
				var td2 = $("<td>");
				td2.append($("<div>").addClass("messenger-emplist-dept").text(d.deptName));
				td2.append($("<div>").addClass("messenger-emplist-name").text(d.rankName +" "+ d.empName));
				tr.append(td2);
				tbody.append(tr);
			}
			$("#messenger-emplist-table").append(tbody);
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}

function chat_room(empNo){
	$.ajax({
		url : "/erp/employee/messenger/chatroom",
        method: 'GET',
		success: function (data) {
			$("#messenger-user-list").hide();
			$("#direct-message-area").html($(data).filter("#messenger-chatting-room")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        },
        complete : function(){
			$("#messenger-receive-user").val(empNo);
    		$('#chat-text-area').scrollTop($('#chat-text-area')[0].scrollHeight);
		}
	})
}
