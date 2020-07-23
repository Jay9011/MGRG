<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../top.jsp" />
<jsp:include page="../datatable.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/JS/staff/Main.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/staff/Main.css">
<jsp:include page="../topend.jsp" />
<title>사원 목록</title>
</head>
<script>
	$(document).ready(function(){
		$('#staff_list').DataTable();
	});
</script>
<body>
	<!-- 네브 -->
	<jsp:include page="../nav.jsp" />
	<!-- Page Content  -->
	<div id="content">
		<table id="staff_list" class="table table-striped nowrap">
			<thead class="thead-dark">
				<tr>
					<td>*</td>
					<td>이름</td>
					<td>직책</td>
					<td>전화번호</td>
					<td>이메일</td>
					<td>주소</td>
					<td>생년월일</td>
					<td>남은 휴가일수</td>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	
		<!-- Modal -->
		<div class="modal fade" id="viewStaff" tabindex="-1" role="dialog"
			aria-labelledby="viewStaffTitle" aria-hidden="true">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="viewStaffTitle">Modal title</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<label for="staff_name">이름 : </label>
						<input id="staff_name" type="text" value="name"/>
						
						<div class="input-group date">
							<label for="staff_birthday">생일 : </label>
							<input id="staff_birthday" type="date" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
						</div>
	
						<label for="staff_phone">휴대폰 번호 : </label>
						<input id="staff_phone" type="text" value="phonenum"/>
					
						<label for="staff_email">E-mail : </label>
						<input id="staff_email" type="text" value="email"/>
							
						<label for="staff_id">아이디 : </label>
						<input id="staff_id" type="text" value="id"/>
						
						<div class="password">
							<label for="staff_pw">비밀번호 : </label>
							<input id="staff_pw" type="password" value="pw"/>
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
								<path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
							</svg>
						</div>
	
						<div class="password">
							<label for="staff_chkpw">비밀번호 확인 : </label>
							<input id="staff_chkpw" type="password" value="pw"/>
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-eye-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/>
								<path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>
							</svg>
						</div>
						
						<label for="staff_address">주소 : </label>
						<input id="staff_address" type="text" value="address"/>
						
						<div class="input-group date">
							<label for="staff_hiredate">입사 날짜 : </label>
							<input id="staff_hiredate" type="date" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
						</div>
						
						<label for="staff_salary">연봉 : </label>
						<input id="staff_salary" type="number" value="salary"/>
						
						<label for="staff_position">직책 : </label>
						<input id="staff_position" type="text" value="position"/>
						
						<label for="staff_department">부서 : </label>
						<input id="staff_department" type="text" value="department"/>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>