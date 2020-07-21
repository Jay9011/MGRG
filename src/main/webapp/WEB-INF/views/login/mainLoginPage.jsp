<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login MainPage</title>
</head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/CSS/login/login.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/JS/login/emailValidation.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script> -->
<body>
	<div class="container" onclick="onclick">
        <div class="top"></div>
        <div class="bottom"></div>
        <div class="center">
            <h2>Please Sign In</h2>
<%--             <form method="post" action="${pageContext.request.contextPath}/login" name="login" id="login" onsubmit="return ValidateEmail(document.login.email)"> --%>
            <form method="post" action="${pageContext.request.contextPath}/login" name="login" id="login">
            
<!-- 	            <input type="email" placeholder="email" name="username" id="email"/> -->
	            <input type="text" placeholder="email" name="username" id="email"/>
	            <input type="password" placeholder="password" name="password" id="pw"/>
	            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
	            <input type="submit" value="로그인">
            </form>
            <h2>&nbsp;</h2>
        </div>
    </div>
</body>
<script type="text/javascript">
$("#login").validate({ // login에 validate를 적용
    rules: {
      
        email: {
            required: true,
            email: true
        },

    },
    messages: {
      	//양식에 맞지 않을 시 email 입력란 하단에 나오는 메세지
        email: "유효한 이메일을 입력해주세요"
    	},
});
</script>
</html>