/**
 * 
 */
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$(function(){
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	}); // end ajaxSetup
	
	var input_id = $('#input_id');
	var input_pw = $('#input_pw');
	var input_pwnew = $('#input_pwnew');
	var input_pwchk = $('#intput_pwchk');
	var change_btn = $('#change_btn');
	
	input_pw.on('propertychange change keyup paste input', function(e){
		if(input_id != null && input_id.val() != ''){
			chk_idUser(input_id, input_pw, input_pwnew, input_pwchk, change_btn);
		}
	});
	input_id.on('propertychange change keyup paste input', function(e){
		if(input_pw != null && input_pw.val() != ''){
			chk_idUser(input_id, input_pw, input_pwnew, input_pwchk, change_btn);
		}
	});
	change_btn.on('click', function(){
		change_user_Pw(input_id, input_pw, input_pwnew);
	});
});

function chk_idUser(form_id, form_pw, form_pwnew, form_pwchk, form_btn){
	id = form_id.val();
	pw = form_pw.val();
	$.ajax({
		url : 'changePw/findId',
		type : 'POST',
		cache : false,
		data : {
			'id' : id,
			'pw' : pw
		},
		success : function(data, status){
			if(status == 'success'){
				if(data.status == 'OK'){
					form_pwnew.attr('disabled', false);
					form_pwchk.attr('disabled', false);
					form_btn.attr('disabled', false);
				} else if(data.status == 'FAIL'){
					form_pwnew.attr('disabled', true);
					form_pwchk.attr('disabled', true);
					form_btn.attr('disabled', true);
				} // end data == OK
			} // end success
		} 
	}); // end ajax
}

function change_user_Pw(form_id, form_pw, form_pwnew){
	id = form_id.val();
	pw = form_pw.val();
	pwnew = form_pwnew.val();
	$.ajax({
		url : 'changePw/changePw',
		type : 'POST',
		cache : false,
		data : {
			'id' : id,
			'pw' : pw,
			'pwnew' : pwnew
		},
		success : function(data, status){
			if(status == 'success'){
				if(data.status == 'OK'){
					Swal.fire({
					  title: '비밀번호 변경 완료',
					  text: data.message,
					  icon: 'success',
					  showCancelButton: false,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: '완료'
					}).then((result) => {
					  if (result.value) {
					    location.replace('./');
					  }
					});
				} else if(data.status == 'FAIL'){
					Swal.fire({
					  icon: 'error',
					  title: '비밀번호 변경 실패',
					  text: data.message
					});
				} // end data == OK
			} // end success
		} 
	}); // end ajax
}