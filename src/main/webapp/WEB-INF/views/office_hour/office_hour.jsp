<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />
<jsp:include page="../top.jsp" />
<jsp:include page="../topend.jsp" />
<script src="${pageContext.request.contextPath }/resources/JS/officehour/officehr.js"></script>
<script src="${pageContext.request.contextPath }/resources/JS/officehour/currenthr.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/CSS/officehour/officehour.css">
<link rel="stylesheet"  href="${pageContext.request.contextPath}/resources/CSS/table.css">

<title>출근 현황 페이지</title>
</head>

<body>
	<jsp:include page="../nav.jsp" />
	<!-- Page Content  -->
	<div id="content">
	<h1 class="float-left" style="margin: 10px 20px;">근태 관리</h1>
	<div class="clearfix"></div>
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
						<input type="button" value="검색" class="search-btn btn addBtn">
				</div>

			</form>

		</div>

		<div class="clearfix" onload="printClock()">
			<div id="clock"></div>
		</div>

		<div class="panel panel-default">
			<div class="tbl_user_data"></div>
		</div>
	</div>

</body>

</html>