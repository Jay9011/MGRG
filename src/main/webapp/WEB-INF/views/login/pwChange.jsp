<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
	<title>비밀번호 변경</title>
	<script src="https://code.jquery.com/jquery-3.5.1.js"
		integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
		crossorigin="anonymous"></script>
	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
		integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
		crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/resources/CSS/mail.css">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/JS/login/pwChange.js"></script>
</head>
<body>

	<div class="wrapper">
		<div class="container">
			<h2>비밀번호 변경</h2>

			<form class="form" action="" method="post" id="pwchange" name="pwchange">
				<input type="text" name="id" placeholder="ID" id="input_id"> 
				<input type="password" name="password" placeholder="PW" id="input_pw">
				<input type="password" name="passwordnew" placeholder="NEW PW" id="input_pwnew" disabled="disabled">
				<input type="password" name="passwordnewChk" placeholder="Chack PW" id="intput_pwchk" disabled="disabled">
				<button type="button" id="change_btn" disabled="disabled">Send</button>
			</form>
		</div>

		<ul class="bg-bubbles">
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
			<li></li>
		</ul>
	</div>


	
</body>
</html>