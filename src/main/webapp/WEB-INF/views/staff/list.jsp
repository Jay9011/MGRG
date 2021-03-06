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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/JS/staff/Toast.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/staff/Toast.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/table.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/JS/staff/validation.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
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
		<h1 class="float-left">직원 목록</h1>
		<div class="float-right">
			<button type="button" id="btnWrite" class="btn">직원 추가</button>
		</div>
		
		<div class="clearfix"></div>
		<table id="staff_list" class="table table-hover nowrap" style="width:100%">
			<thead>
				<tr>
					<th style="width:1%; text-align:center;">*</th>
					<th style="width:10%; text-align:center;">이름</th>
					<th style="width:5%; text-align:center;">직책</th>
					<th style="width:12%; text-align:center;">전화번호</th>
					<th style="width:15%; text-align:center;">이메일</th>
					<th style="width:5%; text-align:center;">남은 휴가일수</th>
					<th style="width:10%; text-align:center;">생년월일</th>
					<th style="width:42%">주소</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div class="clearfix"></div>
		<div class="float-left">
			<a href="${pageContext.request.contextPath}/excelDown"><button type="button" class="btn bottom_btn excel_btn" data-toggle="tooltip" data-placement="bottom" title="모든 직원의 정보를 엑셀로 뽑아냅니다.">엑셀 다운로드</button></a>
			<button type="button" id="btnDelete" class="btn bottom_btn" data-toggle="tooltip" data-placement="bottom" title="선택된 직원을 삭제합니다.">직원 삭제</button>
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
								<input  class="editForm" name="name" class="editForm" id="staff_name" type="text" placeholder="이름을 입력하세요." maxlength="10"/>
								<span id="nameChk" class="hint"></span>
							</div>
							<div class="input-group date">
								<label for="staff_birthday"><span class="requied"></span>생일 </label>
								<input  class="editForm" name="birthday" class="editForm" id="staff_birthday" type="date" class="form-control" style="flex: none;"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
								<span id="birthChk" class="hint"></span>
							</div>
							<div class="input-group text">
								<label for="staff_phone">휴대폰 번호 </label>
								<input  class="editForm numberOnly" name="phonenum" class="editForm" id="staff_phone" type="text" placeholder="휴대번호는 숫자만 입력해 주세요."/>
								<span class="hint"></span>
							</div>
							<div class="input-group text">
								<label for="staff_email"><span class="requied"></span>E-mail </label>
								<input  class="editForm" name="email" class="editForm" id="staff_email" type="text" placeholder="E-mail 주소를 입력해 주세요."/>
								<span id="emailChk" class="hint"></span>
							</div>
							<div class="input-group text">
								<label for="staff_id"><span class="requied"></span>아이디 </label>
								<input  class="editForm" name="id" class="editForm" id="staff_id" type="text" placeholder="아이디를 입력해 주세요." maxlength="15"/>
								<span id="idChk" class="hint"></span>
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
								<div class="input-group addBtnLine">
									<input class="editForm" name="addrZoneCode" id="addrZoneCode" type="text" readonly="readonly"/>
									<input id="addrBtn" class="btn btn-light" type="button" onclick="DaumAddr(this)" value="주소 찾기"/>
								</div>
								<div class="input-group">
									<input class="editForm" name="addrRoad" id="addrRoad" type="text" readonly="readonly" style="margin-bottom:10px;"/>
									<input class="editForm" name="addrDetail" id="addrDetail" type="text" placeholder="상세주소 입력란 입니다."/>
								</div>
								<span class="hint"></span>
							</div>
							<div class="input-group date">
								<label for="staff_hiredate"><span class="requied"></span>입사 날짜 </label>
								<input class="editForm" name="hiredate" id="staff_hiredate" type="date" class="form-control" style="flex: none;"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
								<span id="hiredateChk" class="hint"></span>
							</div>
							<div class="input-group text">
								<label for="staff_salary"><span class="requied"></span>연봉 </label>
								<input class="editForm" name="salary" id="staff_salary" type="number"/>
								<span id="salaryChk" class="hint"></span>
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
							<div class="input-group text input-group-viewr">
								<label for="staff_name">이름 </label>
								<input class="editForm" name="name" id="staff_name" type="text" style="width:160px"/>
								<span id="nameChk"></span>
							</div>
							<div class="input-group date input-group-viewr">
								<label for="staff_birthday">생일 </label>
								<input class="editForm" name="birthday" id="staff_birthday" type="date" class="form-control" style="width: 160px; flex: none;"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
								<span class="birthday showText"></span>
							</div>
							<div class="input-group text input-group-viewr">
								<label for="staff_phone">휴대폰 번호 </label>
								<input class="editForm numberOnly" name="phonenum" id="staff_phone" type="text" style="width:300px"/>
								<span class="phonenum showText"></span>
							</div>
							<div class="input-group text input-group-viewr">
								<label for="staff_email">E-mail </label>
								<input class="editForm" name="email" id="staff_email" type="text" style="width:300px"/>
							</div>
							<div class="input-group text input-group-viewr">
								<label for="staff_id">아이디 </label>
								<input class="editForm" name="id" id="staff_id" type="text" style="width:300px; border: none;" readonly="readonly"/>
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
							<div class="input-group text addBody input-group-viewr">
								<div class="input-group addBtnLine">
									<input class="editForm" name="addrZoneCode" id="addrZoneCode" type="text" readonly="readonly" style="width: 80px; border: none"/>
									<input id="addrBtn" class="btn btn-light" type="button" onclick="DaumAddr(this)" value="주소 변경"/>
								</div>
								<div class="input-group">
									<input class="editForm" name="addrRoad" id="addrRoad" type="text" readonly="readonly" style="width:100%; margin-bottom:10px; border: none"/>
									<input class="editForm" name="addrDetail" id="addrDetail" type="text" style="width:100%"/>
								</div>
							</div>
							<div class="input-group date input-group-viewr">
								<label for="staff_hiredate">입사 날짜 </label>
								<input class="editForm" name="hiredate" id="staff_hiredate" type="date" class="form-control" style="width: 160px; flex: none;"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
								<span class="hiredate showText"></span>
							</div>
							<div class="input-group text input-group-viewr">
								<label for="staff_salary">연봉 </label>
								<input class="editForm" name="salary" id="staff_salary" type="number" style="width:300px"/>
								<span class="salary showText"></span>
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

		<div id="toast">
			<div id="toast_img"></div>
			<div id="toast_message"></div>
		</div>
	</div>
</body>
</html>