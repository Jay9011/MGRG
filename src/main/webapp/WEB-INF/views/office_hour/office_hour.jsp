<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />
<jsp:include page="../top.jsp" />
<jsp:include page="../topend.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/CSS/officehour/officehour.css">
<script
	src="${pageContext.request.contextPath }/resources/JS/officehour/officehr.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/JS/officehour/currenthr.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>출근 현황 페이지</title>
</head>

<body>
	<jsp:include page="../nav.jsp" />
	<!-- Page Content  -->
	<div id="content">
		<div class="header">
			<form action="" class="search-content datepicker-content">
				<div class="search">
					<select id="search-opt" name="searchOpt" class="form-control">
						<option value="0" selected>::: 분류별 검색 :::</option>
						<option value="1">직원 이름</option>
						<option value="2">부서명</option>
						<option value="3">직책명</option>
					</select> <input type="text" id="search-input" name="searchInput"
						class="form-control">
				</div>

				<div class="datepicker">
					<label for="startDate">From</label> <input type="text"
						id="startDate" name="startDate" class="form-control"> <label
						for="endDate">To</label> <input type="text" id="endDate"
						name="endDate" class="form-control">
						<input type="button" value="검색" class="search-btn btn btn-primary">
				</div>

			</form>

		</div>

		<div class="clear" onload="printClock()">
			<div id="clock"></div>
		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				<b> 출근현황 </b>
			</div>
			<div class="tbl_user_data"></div>
		</div>
	</div>

</body>

</html>