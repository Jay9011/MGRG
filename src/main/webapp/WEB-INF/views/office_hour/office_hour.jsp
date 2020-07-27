<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<jsp:include page="../top.jsp" />
<!--     <script src="https://code.jquery.com/jquery-2.2.4.min.js"  integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="  crossorigin="anonymous"></script> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.3/moment.min.js"></script>
<!--     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!--     <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
  <jsp:include page="../topend.jsp" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/CSS/officehour/officehour.css">
    <script src="${pageContext.request.contextPath }/resources/JS/officehour/officehr.js"></script>
    <script src="${pageContext.request.contextPath }/resources/JS/officehour/currenthr.js"></script>
	
    <title>출근 현황 페이지</title>
</head>

<body>
	<jsp:include page="../nav.jsp" />
	<!-- Page Content  -->
	<div id="content">
<div class="search">
    <form action="" class="search-content">
        <select class="form-control">
            <option value="">직원 이름</option>
            <option value="">부서명</option>
            <option value="">직책명</option>
        </select>
        <input type="text" class="form-control">
        <input type="button" value="검색" class="btn btn-primary">
    </form>
</div>


<div class="clear" onload="printClock()">
	<div id="clock"></div>
</div>

<div class="panel panel-default">
    <div class="panel-heading"><b> 출근현황 </b>
    </div>
    <div class="tbl_user_data"></div>
</div>
</div>

</body>

</html>