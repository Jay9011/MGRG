<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<jsp:include page="../top.jsp"/>
<jsp:include page="../datatable.jsp"/>
<jsp:include page="../topend.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/table.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/notice.css">
<script src="${pageContext.request.contextPath}/resources/JS/notice.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js" ></script>
    
	
<title>공지사항</title>
</head>
<body>
<jsp:include page="../nav.jsp"/>

             <!-- Page Content  -->
        <div id="content">
        
	<%-- 공지 목록 --%>
	<div id="list">
	<div class="clearfix">
	<h1 class="float-left">공지사항</h1>
<%--버튼 --%>
		<div class="d01 float-right ">
			<div class="btn2">
				<button type="button" id="btnWrite" class="btn">공지 작성</button>
			</div>
		</div>
		</div>
		<form id="frmList" name="frmList">
			<table id="tlc"  class="table table-hover" style="width:100%">
				<thead>
					<th style="width:3%"> </th>
					<th style="width:75%">제목</th>
					<th style="width:9%">작성일</th>
					<th style="width:8%">부서</th>
					<th style="width:5%">직책</th>
				</thead>

			</table>
		</form>
			<div class="btn2">
				<button type="button" id="btnDel" class="btn">공지 삭제</button>
			</div>


	</div>

		<div id="dlg_write" class="modal" style="overflow: hidden">
			<form class="modal-content animate" id="frmWrite" name="frmWrite"
				method="post">

				<div class="container">
					<h3 class="title">새 공지 작성</h3>

					<span class="close" title="Close Modal">&times;</span>
						<!-- <%--       삭제나 수정을 위해 필요 --%> -->
					<input type="hidden" name="uid" value="0">

					<div class="d01 btn_group_header">
						<div class="right">
							<p id="regdate"></p>
						</div>
						<div class="clear"></div>
                    </div>
					<input id="csrf" type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
                    <div>
                    <label><b>부서</b></label>
                    <label> <input type="radio" name="dep_uid" value="0" checked/>공통</label>
                    <label><input type="radio" name="dep_uid" value="1"/>인사부</label>
                    <label><input type="radio" name="dep_uid" value="2"/>총무부</label>
                    <label><input type="radio" name="dep_uid" value="3"/>경영지원부</label>
                    <label><input type="radio" name="dep_uid" value="4"/>영업부</label>
                    <label><input type="radio" name="dep_uid" value="5"/>기술부</label>
                </div>
                <div>
                    <label for="position"><b>직책</b></label>
                     <label><input type="radio" name="p_uid" value="1" checked/>사원</label>
                     <label><input type="radio" name="p_uid" value="2"/>대리</label>
                     <label><input type="radio" name="p_uid" value="3"/>팀장</label>
                     <label><input type="radio" name="p_uid" value="4"/>부장</label>
                     <label><input type="radio" name="p_uid" value="5"/>과장</label>
                     <label><input type="radio" name="p_uid" value="6"/>사장</label>
                </div>

					<label for="subject"><b>제목</b></label> <input type="text"
						placeholder="글 제목(필수)" name="subject" required>
					<label for="content"><b>내용</b></label>
					<textarea id="editor" name="content"></textarea>
					<p id="chkit"></p>
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
CKEDITOR.replace('editor',{
		allowedContent: true,	// HTML 태그 자동 삭제 방지 설정
		readOnly : true
	}); // 에디터로 생성

</script >
</body>
</html>