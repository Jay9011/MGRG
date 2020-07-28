<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/CSS/login/adminMain2.css">
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<jsp:include page="../topend.jsp"/>
<body>
<jsp:include page="../nav.jsp"/>
	<div class="page">
  <div class="content">
    <h1>
      Get your <br>work done. <br>Together.
    </h1>
  </div>
  <div class="content2">
  	<div class="clock">
  <div class="hours">
    <div class="first">
      <div class="number">0</div>
    </div>
    <div class="second">
      <div class="number">0</div>
    </div>
  </div>
  <div class="tick">:</div>
  <div class="minutes">
    <div class="first">
      <div class="number">0</div>
    </div>
    <div class="second">
      <div class="number">0</div>
    </div>
  </div>
  <div class="tick">:</div>
  <div class="seconds">
    <div class="first">
      <div class="number">0</div>
    </div>
    <div class="second infinite">
      <div class="number">0</div>
    </div>
  </div>
</div>
  </div>
  <div class="box box-1 navy"></div>
  <div class="box box-2 cyan"></div>
  <div class="box box-4 tan"></div>
  <div class="box box-3 orange"></div>
 
</div>
</body>
<script src="<%= request.getContextPath()%>/resources/JS/login/adminMain2.js"></script>
</html>