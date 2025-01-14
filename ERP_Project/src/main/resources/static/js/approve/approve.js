//결재 등록 AJAX
function approve_insert(writer){
	$.ajax({
		url : "/erp/approve/insert",
		method : "POST",
		data : {
			empNo : writer,
			apMaster : $(".approvelist").val(),
			apTitle : $("#aptitle").val(),
			apContent : $("#summernote").val()
		},
		success : function (result){
			if(result =="NNNNY"){
				alert("결재 등록");
			}else{
				alert("결재 등록 실패");
			}
			$("#aptitle").val('');
			$(".modal-overlay").fadeOut();
		},
		error : function (error){
			console.log("AJAX 통신 실패", error);
		}
	})
}


//결재 승인
function accept_update(){
	$.ajax({
		url : "/erp/approve/update",
		method : "POST",
		data:{
			apNo : $("#apNo").val()
		},
		success : function (result){
			if(result =="NNNNY"){
				alert("결재 승인");
				$("#apNo").val('');
			}else{
				alert("결재 등록 실패");
			} 
		},
		error : function(error){
			console.log("AJAX 통신 실패", error);
		},
		complete : function(){
			approveList();
		}
	})
}

//결재 거절
function none_update(){
	$.ajax({
		url : "/erp/approve/refuse",
		method : "POST",
		data:{
			apNo : $("#apNo").val()
		},
		success : function (result){
			if(result =="NNNNY"){
				alert("결재 거절");
				$("#apNo").val('');
			}else{
				alert("결재 등록 실패");
			} 
		},
		error : function(error){
			console.log("AJAX 통신 실패", error);
		},
		complete : function(){
			approveList();
		}
	})
}

//결재 대기
function wait_update(){
	$.ajax({
		url : "/erp/approve/wait",
		method : "POST",
		data:{
			apNo : $("#apNo").val()
		},
		success : function (result){
			if(result =="NNNNY"){
				alert("결재 대기");
				$("#apNo").val('');
			}else{
				alert("결재 등록 실패");
			} 
		},
		error : function(error){
			console.log("AJAX 통신 실패", error);
		},
		complete : function(){
			approveList();
		}
	})
}
