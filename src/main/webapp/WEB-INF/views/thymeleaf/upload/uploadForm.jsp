<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>Insert title here</title>
</head>
<jsp:include page="../../top.jsp"/>
<body>

<div class="content">
  <div class="content-wrapper">
    <section class="content-header">
      <h1>
        	파일 업로드 테스트1
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 예제</a></li>
        <li class="active">read</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
        
        <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">파일업로드 테스트 1</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <!-- <form id="form1" action="/sample/upload/uploadForm" method="post" enctype="multipart/form-data"> -->
            <form id="form" action="uploadForm" method="post" enctype="multipart/form-data">
              <div class="box-body">
                <div class="form-group">
                  <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
                  <input type="file" name="file">
                </div>
              </div>

              <div class="box-footer">
                <button type="submit" class="btn btn-warning">제출</button>
              </div>
            </form>
          </div>

    </section>
  </div>
</div>
</body>
</html>