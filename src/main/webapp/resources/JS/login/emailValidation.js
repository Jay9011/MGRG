/**
 *  emailValidation (이메일 검증)
https://www.w3resource.com/javascript/form/email-validation.php
 */

function ValidateEmail(inputText) {
	var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	frm = document.forms["login"];
	if (inputText.value.match(mailformat)) {
		
		return true;
	}
	else {
		$(document).ready(function() {
			swal({
				title: 'Failed',
				text: '유효하지않은 email 형식입니다.',
				icon: 'warning',
				button: {
					text: '돌아가기',
					value: true,
				}
			})
		});
		
		return false;
	}
}

