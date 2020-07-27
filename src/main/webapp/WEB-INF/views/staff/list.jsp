<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<jsp:include page="../top.jsp" />
<jsp:include page="../datatable.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/JS/staff/Main.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/staff/Main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/table.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="../topend.jsp" />
<script>
	$(document).ready(function(){
		$('#staff_list').DataTable();
	});
</script>
<title>사원 목록</title>
</head>
<body>
	<!-- 네브 -->
	<jsp:include page="../nav.jsp" />
	<!-- Page Content  -->
	<div id="content">
		<div class="float-right">
			<button type="button" id="btnWrite" class="btn">직원 추가</button>
		</div>
		
		<div class="clearfix"></div>
		
		<table id="staff_list" class="table table-hover nowrap">
			<thead>
				<tr>
					<th>*</th>
					<th>이름</th>
					<th>직책</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>남은 휴가일수</th>
					<th>생년월일</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="clearfix"></div>
		<div class="float-left">
			<button type="button" id="btnDelete" class="btn">직원 삭제</button>
		</div>
		<div class="clearfix"></div>
	
		<!-- Modal -->
		<div class="modal fade" id="writeStaff" tabindex="-1" role="dialog"
			aria-labelledby="writeStaffTitle" aria-hidden="true">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="writeStaffTitle" style="text-align:center;">사원 추가</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form id="addStaff" name="addStaff">
							<div class="input-group text">
								<label for="staff_name"><span class="requied"></span>이름 </label>
								<input  class="editForm" name="name" class="editForm" id="staff_name" type="text" style="width:160px"/>
							</div>
							<div class="input-group date">
								<label for="staff_birthday"><span class="requied"></span>생일 </label>
								<input  class="editForm" name="birthday" class="editForm" id="staff_birthday" type="date" class="form-control" style="width: 160px; flex: none;"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
							</div>
							<div class="input-group text">
								<label for="staff_phone">휴대폰 번호 </label>
								<input  class="editForm" name="phonenum" class="editForm" id="staff_phone" type="text" style="width:300px"/>
							</div>
							<div class="input-group text">
								<label for="staff_email"><span class="requied"></span>E-mail </label>
								<input  class="editForm" name="email" class="editForm" id="staff_email" type="text" style="width:300px"/>
							</div>
							<div class="input-group text">
								<label for="staff_id"><span class="requied"></span>아이디 </label>
								<input  class="editForm" name="id" class="editForm" id="staff_id" type="text" style="width:300px"/>
							</div>
							<!-- <div class="input-group password">
								<label for="staff_pw">비밀번호 </label>
								<input  class="editForm" name="pw" id="staff_pw" type="password" style="width:300px"/>
								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
									<path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
								</svg>
							</div>
							<div class="input-group password">
								<label for="staff_chkpw">비밀번호 확인 </label>
								<input id="staff_chkpw" type="password" style="width:300px"/>
								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
									<path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
								</svg>
							</div> -->
							<div class="addLable">주소</div>
							<div class="input-group text addBody">
								<div class="input-group">
									<input class="editForm" name="addrZoneCode" id="addrZoneCode" type="text" readonly="readonly" style="width: 80px;"/>
									<input id="addrBtn" class="btn btn-light" type="button" onclick="DaumAddr(this)" value="주소 찾기"/>
								</div>
								<div class="input-group">
									<input class="editForm" name="addrRoad" id="addrRoad" type="text" readonly="readonly" style="width:100%; margin-bottom:10px;"/>
									<input class="editForm" name="addrDetail" id="addrDetail" type="text" style="width:100%"/>
								</div>
							</div>
							<div class="input-group date">
								<label for="staff_hiredate"><span class="requied"></span>입사 날짜 </label>
								<input class="editForm" name="hiredate" id="staff_hiredate" type="date" class="form-control" style="width: 160px; flex: none;"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
							</div>
							<div class="input-group text">
								<label for="staff_salary"><span class="requied"></span>연봉 </label>
								<input class="editForm" name="salary" id="staff_salary" type="number" style="width:300px"/>
							</div>
							<div class="input-group select" style="margin-left:125px">
								<select name="dep_uid" id="staff_department" style="margin:0 5px">
									<option value="1">인사부</option>
									<option value="2">총무부</option>
									<option value="3">경영지원부</option>
									<option value="4">영업부</option>
									<option value="5">기술부</option>
								</select>
								<select name="p_uid" id="staff_position" style="margin:0 5px">
									<option value="1">사원</option>
									<option value="2">대리</option>
									<option value="3">팀장</option>
									<option value="4">부장</option>
									<option value="5">과장</option>
									<option value="6">사장</option>
									<option value="7">인사총괄</option>
								</select>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn addBtn">저장하기</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="viewStaff" tabindex="-1" role="dialog"
			aria-labelledby="viewStaffTitle" aria-hidden="true">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="viewStaffTitle" style="text-align:center;">사원 정보 자세히</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form id="modiStaff" name="modiStaff">
							<input name="uid" type="hidden" value="" />
							<div class="input-group text">
								<label for="staff_name">이름 </label>
								<input  class="editForm" name="name" id="staff_name" type="text" style="width:160px"/>
							</div>
							<div class="input-group date">
								<label for="staff_birthday">생일 </label>
								<input  class="editForm" name="birthday" id="staff_birthday" type="date" class="form-control" style="width: 160px; flex: none;"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
								<span class="birthday"></span>
							</div>
							<div class="input-group text">
								<label for="staff_phone">휴대폰 번호 </label>
								<input  class="editForm" name="phonenum" id="staff_phone" type="text" style="width:300px"/>
							</div>
							<div class="input-group text">
								<label for="staff_email">E-mail </label>
								<input  class="editForm" name="email" id="staff_email" type="text" style="width:300px"/>
							</div>
							<div class="input-group text">
								<label for="staff_id">아이디 </label>
								<input  class="editForm" name="id" id="staff_id" type="text" style="width:300px"/>
							</div>
							<!-- <div class="input-group password">
								<label for="staff_pw">비밀번호 </label>
								<input  class="editForm" name="pw" id="staff_pw" type="password" style="width:300px"/>
								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
									<path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
								</svg>
							</div>
							<div class="input-group password">
								<label for="staff_chkpw">비밀번호 확인 </label>
								<input id="staff_chkpw" type="password" style="width:300px"/>
								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
									<path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
								</svg>
							</div> -->
							<div class="addLable">주소</div>
							<div class="input-group text addBody">
								<div class="input-group">
									<input  class="editForm" name="addrZoneCode" id="addrZoneCode" type="text" readonly="readonly" style="width: 80px; border: none"/>
									<input id="addrBtn" class="btn btn-light" type="button" onclick="DaumAddr(this)" value="주소 변경"/>
								</div>
								<div class="input-group">
									<input  class="editForm" name="addrRoad" id="addrRoad" type="text" readonly="readonly" style="width:100%; margin-bottom:10px; border: none"/>
									<input  class="editForm" name="addrDetail" id="addrDetail" type="text" style="width:100%"/>
								</div>
							</div>
							<div class="input-group date">
								<label for="staff_hiredate">입사 날짜 </label>
								<input  class="editForm" name="hiredate" id="staff_hiredate" type="date" class="form-control" style="width: 160px; flex: none;"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
								<span class="hiredate"></span>
							</div>
							<div class="input-group text">
								<label for="staff_salary">연봉 </label>
								<input  class="editForm" name="salary" id="staff_salary" type="number" style="width:300px"/>
								<span class="salary"></span>
							</div>
							<div class="input-group select" style="margin-left:125px">
								<select name="dep_uid" id="staff_department" style="margin:0 5px">
									<option value="1">인사부</option>
									<option value="2">총무부</option>
									<option value="3">경영지원부</option>
									<option value="4">영업부</option>
									<option value="5">기술부</option>
								</select>
								<select name="p_uid" id="staff_position" style="margin:0 5px">
									<option value="1">사원</option>
									<option value="2">대리</option>
									<option value="3">팀장</option>
									<option value="4">부장</option>
									<option value="5">과장</option>
									<option value="6">사장</option>
									<option value="7">인사총괄</option>
								</select>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn modiBtn">저장하기</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>