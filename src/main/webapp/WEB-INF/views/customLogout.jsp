<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/CSS/login/403.css">
<body>
<div id="layoutError">
            <div id="layoutError_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <div class="text-center mt-4">
                                    <h2 class="display-1">Log out</h2>
                                    <p class="lead">successfully</p>
                                    <a href="<%= request.getContextPath() %>/login/main">
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>


