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