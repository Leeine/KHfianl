//-------------- index --------------
function indexNoticePage(){
	$.ajax({
		url : "/erp/notice/index",
        method: 'GET',
        success: function (data) {
			$("#index-notice-div").html($(data).filter("#table-wrap")[0]);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        },
        complete : function (){
			indexNoticeList();
		}
	})
};

//-------------- index페이지 -----------------
function indexNoticeList(){
	$.ajax({
		url : "/erp/notice/index/list",
        method: 'GET',
        success: function (data) {
			if(data.length == 0){
				var tr = $("<tr>");
				tr.append($("<td colspan='4'>").text("조회된 공지가 없습니다."));
				$("#index-notice-table>tbody").html(tr);
			}else{
				var tbody = $("<tbody>");
				for(var n of data){
					var tr = $("<tr>");
					tr.append($("<td>").append(n.noticeNo));
					tr.append($("<td>").append(n.noticeTitle));
					tr.append($("<td>").append(n.noticeCount));
					tr.append($("<td>").append(n.createDate));
					tbody.append(tr);
				}
				$("#index-notice-table>tbody").remove();
				$("#index-notice-table").append(tbody);
			}
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
	
}

// 메인페이지 내정보
function employeeMypage(empNo){
	$.ajax({
		url : "/erp/employee/mypage",
        method: 'GET',
        success: function (data) {
			$("#employee-info-block").html($(data).filter("#mypage_container")[0]);
        
        	employeeDetail(empNo);
        },
        error: function (error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
};


// 메인>마이페이지 로그인정보 불러와서 넣기
function employeeDetail(empNo){
	$.ajax({
		url : "/erp/employee/detail",
		method : 'GET',
		data : {
			empNo : empNo
		},
		success : function (data){
		
			
			//수정가능한 값 value
			$('#name').val(data.empName); 
            $('#phone').val(data.phone);  
            $('#addr').val(data.address);  
            $('#email').val(data.email);  
            
            //수정불가능 출력값 span
            $('#nameSpan').text(data.empName); 
            $('#birthSpan').text(data.birthday.split(" ")[0]); 
            $('#deptSpan').text(data.deptName); 
            $('#emailSpan').text(data.email); 
            $('#rankSpan').text(data.rankName); 
            $('#phoneSpan').text(data.phone);
            $('#joinSpan').text(data.joinDate.split(" ")[0]);
		},
		error : function(error){
			 console.error('AJAX 요청 실패:', error);
		}
	})
};

// 정보 업데이트
function employeeUpdate(empNo){
	$.ajax({
		url : "/erp/employee/update",
		method : 'POST',
		data : {
			empNo : empNo ,
			empName : $("#name").val(),
			phone : $("#phone").val(),
			address : $("#addr").val(),
			email : $("#email").val()
		},
		success : function(result){
			if(result =="NNNNY"){
				alert("수정 완료");
			}else{
				alert("수정 실패");
			}
		},
		error : function(error){
			console.error('AJAX 요청 실패:', error);
		},
		complete : function(){
			employeeMypage(empNo);
		}
	})
};
     

