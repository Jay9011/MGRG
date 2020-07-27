<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login MainPage</title>
</head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/CSS/login/login.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<body>
	<div class="container" onclick="onclick">
        <div class="top"></div>
        <div class="bottom"></div>
        <div class="center">
            <h2>MR.hrms</h2>
            <form method="post" action="${pageContext.request.contextPath}/login" name="login" id="login" onsubmit="return ValidateEmail(document.login.email);">
<%--             <form method="post" action="${pageContext.request.contextPath}/login" name="login" id="login"> --%>
            
<!-- 	            <input type="email" placeholder="email" name="username" id="email"/> -->
	            <input type="text" placeholder="id" name="username" id="text"/>
	            <input type="password" placeholder="password" name="password" id="pw"/>
	            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
	            <input type="submit" value="로그인">
            </form>
            <a href="<%=request.getContextPath() %>/mailgo"><small><sub>비밀번호 찾기</sub></small></a>
        </div>
    </div>
</body>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/js/all.min.js"></script>
</html>