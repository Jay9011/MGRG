<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/CSS/mail.css">
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<body>

	<!--     /////////////////////////////////// -->
	<div class="wrapper">
		<div class="container">
			<h1>Find..</h1>

			<form class="form" action="mailSending" method="post" id="mail" name="mail">
				<input type="email" name="tomail" placeholder="email.." id="tomail"> 
				<input type="text" name="findid" placeholder="ID.." id="findid">
				<!-- 제목 -->
				<input type="hidden" name="title" value="비밀번호 입니다">
				<button type="submit" id="login-button">Send</button>
				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" />
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