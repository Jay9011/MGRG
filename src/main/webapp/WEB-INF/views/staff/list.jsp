<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- datatables css,js -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css"/> 
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css"/> 
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>


<script>const path = "${pageContext.request.contextPath}";</script>
<script src="${pageContext.request.contextPath}/resources/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap-datepicker/locales/bootstrap-datepicker.ko.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap-datepicker/css/bootstrap-datepicker3.min.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/JS/staff/Main.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/CSS/staff/Main.css">
<title>사원 목록</title>
</head>
<script>
	$(document).ready(function(){
		$('#staff_list').DataTable();
	});
</script>
<body>
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
					
					생년월일 : 
					<span>1990-01-01</span>

					<label for="staff_phone">휴대폰 번호 : </label>
					<input id="staff_phone" type="text" value="phonenum"/>
				
					<label for="staff_email">E-mail : </label>
					<input id="staff_email" type="text" value="email"/>
						
					<label for="staff_id">아이디 : </label>
					<input id="staff_id" type="text" value="id"/>
					
					<label for="staff_address">주소 : </label>
					<input id="staff_address" type="text" value="address"/>
					
					<div class="input-group date">
						<label for="staff_hiredate">입사 날짜 : </label>
						<input id="staff_hiredate" type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
					</div>
					
					<label for="test">이름 : </label>
					<input id="staff_name" type="text" value="name"/>
					
					<label for="test">이름 : </label>
					<input id="staff_name" type="text" value="name"/>
					
					<label for="test">이름 : </label>
					<input id="staff_name" type="text" value="name"/>
					
					<label for="test">이름 : </label>
					<input id="staff_name" type="text" value="name"/>
					
					<label for="test">이름 : </label>
					<input id="staff_name" type="text" value="name"/>
					
					<label for="test">이름 : </label>
					<input id="staff_name" type="text" value="name"/>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>