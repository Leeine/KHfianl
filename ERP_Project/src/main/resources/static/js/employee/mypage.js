//사원정보
function employee_mypage_info(){
	$.ajax({
		url : "/erp/employee/mypage/info",
        method: 'GET',
        data : {
			empNo : $("#empNo").val()
		},
        success : function(data) {
			console.log(data);
			var div = $("<div>").addClass("employeeInfo");
			div.append($("<div>").text("사원 번호 : "+data.empNo));
			div.append($("<div>").text("이름 : "+data.empName));
			div.append($("<div>").text("직급 : "+data.rankName));
			div.append($("<div>").text("부서 : "+data.deptName));
			div.append($("<div>").text("나이 : "+data.age));
			div.append($("<div>").text("전화 : "+data.phone));
			div.append($("<div>").text("연차 : "+data.vacation));
			div.append($("<div>").text("입사일 : "+data.joinDate));
			$("#employee-mypage-page").append(div);
        },
        error : function(error) {
            console.error('AJAX 요청 실패:', error);
        }
	})
}