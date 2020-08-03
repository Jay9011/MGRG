<%@page import="org.springframework.ui.Model"%>
<%@page import="com.mgrg.hrm.fileupload.docDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%  docDTO arr = (docDTO)request.getAttribute("view");   %>

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
<title>파일 업로드</title>
</head>
<body>
<jsp:include page="../../nav.jsp" />
<div id="content">
      <div class="col-xs-12 col-md-6" style="margin: auto;">
	<table class="table table-sm table-hover table-borderless tale col-ms-6" >
            <thead>
               <tr>
                  <th scope="col">No.</th>
                  <th class="noticeCenter" scope="col">문서 양식</th>
                  <th class="noticeCenter" scope="col">문서 파일</th>
               </tr>
            </thead>
            <tbody>
               <c:choose>
                  <c:when test="${empty list || fn:length(list) == 0 }">
                     <!--          배열이 비어있거나 있긴있지만 길이가 0개 짜리 배열일때를 체크 -->
                  </c:when>
                  <c:otherwise>
                     <c:forEach var="dto" items="${list}" begin="0" end="10">
                        <tr>
                           <td>${dto.doc_uid }</td>
                           <td class="noticeCenter"><span class="doc"
                              data-uid="${dto.doc_uid }" value="${dto.doc_uid }">
                              <a style="color: black;" href="view?view=${dto.doc_uid }">${dto.doc_title }</a></span></td>
                           <td><a style="color:black;"href="down?fileName=${dto.doc_file}">${dto.doc_file}</a></td>
                        </tr>
                     </c:forEach>
                  </c:otherwise>
               </c:choose>
            </tbody>
         </table>
         <button class="btn addBtn" style="clear: both;" onclick="location.href='uploadAjax'">글작성</button>
</div>

<div class="clearfix"></div>
      
	</div>
</body>
<script>

	$('.doc').click(function(){
// 		alert($(this).attr('data-uid'));
// 		alert(typeof($(this).attr('data-uid')));
         $.ajax({
            url : "view",
            type : "GET",
            cache : false,
            data : "view="+$(this).attr('data-uid'),
            success : function(data, status) {
               if (status == "success") {
                  
              	 
               }
            }

         });
		
	})


</script>
<script src="<%= request.getContextPath()%>/resources/JS/ajaxSetting.js"></script>



</html>