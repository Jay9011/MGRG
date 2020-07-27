<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>메일 보내기</h4>
    <form action="mailSending" method="post">
      <div>
        <input type="text" name="tomail" size="120"
        style="width: 100%" placeholder="비밀번호를 받을 이메일주소입력하세요"
        class="form-control">
      </div>
      <div>
        <input type="text" name="findid" size="120"
        style="width: 100%" placeholder="찾을아이디를 입력하세요"
        class="form-control">
      </div>
      <div align="center">
        <!-- 제목 -->
        <input type="hidden" name="title" size="120"
        style="width: 100%" value="비밀번호 입니다"
        class="form-control">
      </div>
<!--         <p> -->
<!--           <div align="center"> -->
<!--           내용 -->
<!--             <input name="content" value="" class="form-control"/> -->
<!--           </div> -->
<!--         <p> -->
        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
      <div align="center">
        <input type="submit" value="메일 보내기" class="btn btn-warning">
      </div>
    </form>
</body>
</html>