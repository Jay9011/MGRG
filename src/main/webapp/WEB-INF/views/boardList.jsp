<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Home</title>
<style>
	table, td, tr{
		border: 1px solid black;
	}
	td{
		border-collapse: true;
	}
</style>
</head>
<body>
	<h1>Board List</h1>
	<div>
	
	[<a href="<c:url value='/excelDown.do' />">엑셀</a>]
	</div>
	<table>
	<thead>
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>직책</th>
		<th>급여</th>
		<th>생년월일</th>
	</tr>
	</thead>
	<tbody>
		<c:forEach var="item" items="${list}">
		<tr>
			<td>${item.uid}</td>
			<td>${item.name}</td>
			<td>${item.position}</td>
			<td>${item.salary}</td>
			<td>${item.birth}</td>
		</tr>
		</c:forEach>
	</tbody>
	</table>
</body>
</html>
