<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name = "viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/CSS/login/403.css">
<title>Access ERROR Page</title>
</head>
<body>
<!-- 	<h1>Access ERROR</h1> -->
<%-- 	<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage() }"/></h2> --%>
<%-- 	<h2><c:out value="${msg }"/></h2> --%>

	<div id="layoutError">
            <div id="layoutError_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <div class="text-center mt-4">
                                    <h2 class="display-1">403</h2>
                                    <p class="lead">${SPRING_SECURITY_403_EXCEPTION.getMessage() }</p>
                                    <p>${msg }</p>
                                    <a href="<%= request.getContextPath() %>/login/mainLoginPage">
                                        <i class="fas fa-arrow-left mr-1"></i>
                                        Return to login
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            
        </div>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</html>