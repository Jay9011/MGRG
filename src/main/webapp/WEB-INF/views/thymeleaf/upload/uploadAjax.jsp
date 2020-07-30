<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />
<jsp:include page="../../top.jsp" />
<jsp:include page="../../nav.jsp" />
<script src="<%=request.getContextPath()%>/resources/JS/ajaxSetting.js"></script>
<script src="${pageContext.request.contextPath}/resources/JS/notice.js"></script>
<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js" ></script>
<style>
small {
	margin-left: 3px;
	font-weight: bold;
	color: gray;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/notice.css">
</head>
<body>

<div id="dlg_write" style="overflow: hidden">
			<form id="form" action="uploadForm" method="post"
							enctype="multipart/form-data">

				<div class="container">
					<h3 class="title">새 공지 작성</h3>
					<div class="d01 btn_group_header">
						
						<div class="clearfix"></div>
                    </div>
					<input id="csrf" type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
                    <div>
                </div>
                <div>
                </div>
					<label for="subject"><b>제목</b></label> <input type="text"
						placeholder="글 제목(필수)" name="subject" required>
					<label for="content"><b>내용</b></label>
					<textarea id="editor" name="content"></textarea>
					<p id="chk"></p>
					<div class="d01 btn_group_write">
						<div class="uploadedList"></div>
						<input id="taa" type="file" name="file" onchange="chkchange();">
						<button type="submit" class="btn btn-warning">제출</button>
					</div>
				</div>
			</form>
		</div>

<!-- 	<form id="form" action="uploadForm" method="post" -->
<!-- 		enctype="multipart/form-data"> -->
<!-- 		<div class="box-body"> -->
<!-- 			<div class="form-group"> -->
<%-- 				<input type="hidden" name="${_csrf.parameterName }" --%>
<%-- 					value="${_csrf.token}" /> --%>
<!-- 				<div class="uploadedList"></div> -->
<!-- 				<input id="taa" type="file" name="file" onchange="chkchange();"> -->
<!-- 			</div> -->
<!-- 		</div> -->
	
<!-- 		<div class="box-footer"> -->
<!-- 			<button type="submit" class="btn btn-warning">제출</button> -->
<!-- 		</div> -->
<!-- 	</form> -->

</body>


<script src="<%= request.getContextPath()%>/resources/JS/fileupload.js"></script>
<jsp:include page="../../topend.jsp"/>
<script >
CKEDITOR.replace('editor',{
		allowedContent: true,	// HTML 태그 자동 삭제 방지 설정
		readOnly : true
	}); // 에디터로 생성

</script >
</html>