<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header"
	content="${_csrf.headerName}" />
<jsp:include page="../../top.jsp" />
<script src="<%=request.getContextPath()%>/resources/JS/ajaxSetting.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/table.css">
<jsp:include page="../../topend.jsp"/>
<title>Insert title here</title>
</head>
<body>
	<!-- 문서 더보기 모달 -->
     	
                  <table id="notitable"
                     class="table table-sm table-hover table-borderless tale tale2">
                     <thead class="table-primary">
                        <tr>
                           <th style="width: 1%">No.</th>
                           <th style="width: 33%; text-align: center;">문서 양식</th>
                           <th style="width: 33%">문서 파일</th>
                           <th style="width: 33%">문서 내용</th>
                        </tr>
                     </thead>
                     <tbody>
                        <tr>
                              <td>${view.doc_uid }</td>
                              <td style="text-align: center;"><span class="doc" data-uid="${view.doc_uid }" onclick="location.href='./upload/down?fileName=${view.doc_file}'">${view.doc_title }</span></td>
                              <td>${view.doc_file }</td>
                              <td>${view.doc_content }</td>
                           </tr>
                     </tbody>
                  </table>
               
</body>
</html>