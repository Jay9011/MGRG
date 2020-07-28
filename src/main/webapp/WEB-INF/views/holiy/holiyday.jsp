<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />
<jsp:include page="../top.jsp" />
<jsp:include page="../datatable.jsp" />
<jsp:include page="../topend.jsp" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />
<link rel="stylesheet"  type="text/css" href="${pageContext.request.contextPath}/resources/CSS/Holiy/holiy.css">

<title>휴가 관리</title>
</head>
<body>
	<!-- 네브 -->
	<jsp:include page="../nav.jsp" />
	<!-- Page Content  -->
	<div id="content">

		<div class='col-md-3 col-xs-4'>
			<div class="form-group">
				<div class="input-group date" id="datetimepicker1"
					data-target-input="nearest">
					<input type="text" class="form-control datetimepicker-input"
						data-target="#datetimepicker1" name="startTime" >
					<div class="input-group-append" data-target="#datetimepicker1"
						data-toggle="datetimepicker">
						<div class="input-group-text">
							<i class="fa fa-calendar"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class='col-md-3 col-xs-4'>
			<div class="form-group">
				<div class="input-group date" id="datetimepicker2"
					data-target-input="nearest">
					<input type="text" class="form-control datetimepicker-input"
						data-target="#datetimepicker2" name="endTime">
					<div class="input-group-append" data-target="#datetimepicker2"
						data-toggle="datetimepicker">
						<div class="input-group-text">
							<i class="fa fa-calendar"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	


	</div>

		<script type="text/javascript">
			$(function() {
				$('#datetimepicker1').datetimepicker({
					format : 'YYYY-MM-DD',
					minDate : new Date()
				});
				$('#datetimepicker2').datetimepicker({
					format : 'YYYY-MM-DD',
					useCurrent : false,
					minDate : new Date()
				});
				$("#datetimepicker1").on("change.datetimepicker", function(e) {
					$('#datetimepicker2').datetimepicker('minDate', e.date);
				});
				$("#datetimepicker2").on("change.datetimepicker", function(e) {
					$('#datetimepicker1').datetimepicker('maxDate', e.date);
				});
			});
		</script>
</body>
</html>