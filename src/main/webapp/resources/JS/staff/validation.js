/**
 * 
 */
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

var idChk;
var emailChk;
var nameChk;

$(document).ready(function(){
	
	$('#writeStaff #staff_name').on('propertychange change keyup paste input', function(e){
		nameChk = validateNameChk($(this));
	});
	$('#writeStaff #staff_birthday').blur(function(e){
		validateBirthChk($(this));
	});
	$('#writeStaff #staff_email').blur(function(e){
		validateEmailChk($(this));
	});
	$('#writeStaff #staff_id').on('propertychange change keyup paste input', function(e){
		validateIdChk($(this));
	});
	$('#writeStaff #staff_hiredate').blur(function(e){
		validatehiredateChk($(this));
	});
	$('#writeStaff #staff_salary').blur(function(e){
		validateSalaryChk($(this));
	});
});
 /**
  * 유효성 검사 진행
  * @returns boolean
  */
function validationChk(){
	validateNameChk($('#writeStaff #staff_name'));
	validateEmailChk($('#writeStaff #staff_email'));
	validateIdChk($('#writeStaff #staff_id'));
	var birthChk = validateBirthChk();
	var hireChk = validatehiredateChk();
	var salaryChk = validateSalaryChk();
	
	if(idChk && nameChk && emailChk && birthChk && hireChk && salaryChk){
		return true;
	}
	return false;
} // end validationChk()

function invalid(form, spanText){
	spanText.removeClass('valid-text');
	spanText.addClass('invalid-text');
	form.addClass('invalid-form');
} // end invalid

function valid(form, spanText){
	spanText.removeClass('invalid-text');
	spanText.addClass('valid-text');
	form.removeClass('invalid-form');
} // end invalid

// 이름 유효성 검사
function validateNameChk(form){
	var spanText = form.siblings('#nameChk');
	var regex = /^[a-zA-Z가-힣]{2,10}$/;
	
	if(!$.trim(form.val())){
		spanText.html("이름을 입력해 주세요.");
		invalid(form, spanText);
		return false;
	}
	if(form.val() != ""){
		
		if(form.val().length < 2){
			spanText.html("이름은 2자 ~ 10자 사이로 입력해 주세요.");
			invalid(form, spanText);
			return false;
		}
		if(!regex.test(form.val())){
			spanText.html("이름은 한글 또는 공백 없는 영문자만 가능합니다.");
			invalid(form, spanText);
			return false;
		}
	}
	valid(form, spanText);
	spanText.html("");
	return true;
}

// 생일 유효성 검사
function validateBirthChk(){
	var form = $('#writeStaff #staff_birthday');
	var spanText = form.siblings('#birthChk');
	if(form.val() == '' || form.val() == 'undefined' || form.val() == null){
		spanText.html("생일을 입력해 주세요.");
		invalid(form, spanText);
		return false;
	}
	valid(form, spanText);
	spanText.html("");
	return true;
}

// 이메일 유효성 검사
function validateEmailChk(form) {
	var spanText = form.siblings('#emailChk');
	var regex = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if(form.val() == '' || form.val() == 'undefined' || form.val() == null){
		spanText.html("이메일 주소는 필수입니다.");
		emailChk = false;
		invalid(form, spanText);
		return false;
	}
	if(!regex.test(form.val())){
		spanText.html("올바른 이메일 주소가 아닙니다.");
		emailChk = false;
		invalid(form, spanText);
		return false;
	}
	$.ajaxSetup({
		beforeSend : function(xhr){
			xhr.setRequestHeader(header, token);
		}
	}); // end ajaxSetup
	
	$.ajax({
		url : path + '/staff/validationEmail/',
		type : 'POST',
		cache : false,
		data : {
			email : form.val()
		},
		success : function(data, status){
			if(status == "success"){
				if(data.status == "OK"){
					spanText.html(data.message);
					emailChk = true;
					valid(form, spanText);
				} else if(data.status == "FAIL"){
					spanText.html(data.message);
					emailChk = false;
					invalid(form, spanText);
				}
			} else {
				
			}
		}
	}); // end ajax
	return false;
}

// 아이디 유효성 검사
function validateIdChk(form){
	var spanText = form.siblings('#idChk');
	var regex = /^[0-9a-zA-Z]{5,15}$/;

	if(form.val() == '' || form.val() == 'undefined' || form.val() == null){
		spanText.html("아이디는 필수입니다.");
		idChk = false;
		invalid(form, spanText);
		return false;
	}
	if(!regex.test(form.val())){
		spanText.html("아이디는 영문과 숫자 5자리 ~ 15자리 사이로 입력해 주세요.");
		idChk = false;
		invalid(form, spanText);
		return false;
	}
	
//	if(form.is(':focus')){
//		spanText.html("");
//	} else {
		$.ajaxSetup({
			beforeSend : function(xhr){
				xhr.setRequestHeader(header, token);
			}
		}); // end ajaxSetup
		
		$.ajax({
			url : path + '/staff/validationId/' + form.val(),
			type : 'POST',
			cache : false,
			success : function(data, status){
				if(status == "success"){
					if(data.status == "OK"){
						spanText.html(data.message);
						idChk = true;
						valid(form, spanText);
					} else if(data.status == "FAIL"){
						spanText.html(data.message);
						idChk = false;
						invalid(form, spanText);
					}
				} else {
					
				}
			}
		}); // end ajax
		return false;
//	} // end if(is focus)
}

//입사날짜 유효성 검사
function validatehiredateChk(){
	var form = $('#writeStaff #staff_hiredate');
	var spanText = form.siblings('#hiredateChk');
	if(form.val() == '' || form.val() == 'undefined' || form.val() == null){
		spanText.html("입사날짜를 입력해 주세요.");
		invalid(form, spanText);
		return false;
	}
	valid(form, spanText);
	spanText.html("");
	return true;
}

//연봉 유효성 검사
function validateSalaryChk(){
	var form = $('#writeStaff #staff_salary');
	var spanText = form.siblings('#salaryChk');
	
	if(!$.trim(form.val())){
		spanText.html("연봉을 입력해 주세요.");
		invalid(form, spanText);
		return false;
	}
	valid(form, spanText);
	spanText.html("");
	return true;
}