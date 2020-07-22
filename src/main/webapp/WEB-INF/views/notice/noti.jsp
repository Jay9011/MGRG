<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/notice.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="${pageContext.request.contextPath}/resources/JS/notice.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.css"/> 
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css"/> 
    <script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js" ></script>
	
<title>공지사항</title>
</head>
<body>
	<%-- 공지 목록 --%>
	<div id="list">
	<h2>공지사항</h2>
		<div class="d01">
			<div class="left" id="pageinfo"></div>
			<div class="right" id="pageRows"></div>
		</div>

		<div class="clear"></div>
		<form id="frmList" name="frmList">
			<table id="tlc" class="table table-striped table-bordered" style="width:100%">
				<thead>
					<th> </th>
					<th>제목</th>
					<th>작성일</th>
					<th>부서</th>
					<th>직책</th>
				</thead>

			</table>
		</form>
		<%--버튼 --%>
		<div class="d01">
			<div class="left">
				<button type="button" id="btnDel" class="btn danger">공지 삭제</button>
			</div>
			<div class="right">
				<button type="button" id="btnWrite" class="btn success">공지 작성</button>
			</div>
		</div>


	</div>
	<br>

		<%--글작성/ 글보기 /글수정 대화상자 --%>
		<div id="dlg_write" class="modal">

			<form class="modal-content animate" id="frmWrite" name="frmWrite"
				method="post">

				<div class="container">
					<h3 class="title">새 공지 작성</h3>

					<span class="close" title="Close Modal">&times;</span>

						<!-- <%--       삭제나 수정을 위해 필요 --%> -->
					<input type="hidden" name="uid">

					<div class="d01 btn_group_header">
						<div class="right">
							<p id="regdate"></p>
						</div>
						<div class="clear"></div>
                    </div>
                    <div>
                    <label><b>부서</b></label>
                    <input type="radio" name="department" value="인사부"/>인사부
                    <input type="radio" name="department" value="총무부"/>총무부
                    <input type="radio" name="department" value="경영지원부"/>경영지원부
                    <input type="radio" name="department" value="영업부"/>영업부
                    <input type="radio" name="department" value="기술부"/>기술부
                </div>
                <div>
                    <label for="position"><b>직책</b></label>
                    <input type="radio" name="position" value=""/>공통
                    <input type="radio" name="position" value="1"/>사원
                    <input type="radio" name="position" value="2"/>대리
                    <input type="radio" name="position" value="3"/>팀장
                    <input type="radio" name="position" value="4"/>부장
                    <input type="radio" name="position" value="5"/>과장
                    <input type="radio" name="position" value="6"/>사장
                </div>

					<label for="subject"><b>제목</b></label> <input type="text"
						placeholder="글 제목(필수)" name="subject" required>
					<label for="content"><b>내용</b></label>
					<textarea id="editer"name="content"></textarea>
					<div class="d01 btn_group_write">
						<button type="submit" class="btn success">작성</button>
					</div>
					<div class="d01 btn_group_view">
						<div class="left">
							<button type='button' class="btn danger" id="viewDelete">삭제</button>
						</div>
						<div class="right">
							<button type='button' class="btn info" id="viewUpdate">수정</button>
						</div>
						<div class="clear"></div>
					</div>

					<div class="d01 btn_group_update">
						<div>
							<button type="button" class="btn info fullbtn" id="updateOk">수정 완료</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script >
CKEDITOR.replace('editer',{
	allowedContent: true	// HTML 태그 자동 삭제 방지 설정
}); // 에디터로 생성
</script >
</body>
</html>