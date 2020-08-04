<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
			<h2>비밀번호 찾기</h2>

			<form class="form" action="mailSending" method="post" id="mail" name="mail">
				<input type="email" name="tomail" placeholder="email" id="tomail"> 
				<input type="text" name="findid" placeholder="ID" id="findid">
				<!-- 제목 -->
				<input type="hidden" name="title" value="비밀번호 입니다">
				<button type="submit" id="login-button">Send</button>
				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token}" />
			</form>
			<a class="backk" href="<%= request.getContextPath() %>/login/mainLoginPage" >
			<svg id="backicon" width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-arrow-left-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
			  <path fill-rule="evenodd" d="M8.354 11.354a.5.5 0 0 0 0-.708L5.707 8l2.647-2.646a.5.5 0 1 0-.708-.708l-3 3a.5.5 0 0 0 0 .708l3 3a.5.5 0 0 0 .708 0z"/>
			  <path fill-rule="evenodd" d="M11.5 8a.5.5 0 0 0-.5-.5H6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 .5-.5z"/>
			</svg>
			</a>
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