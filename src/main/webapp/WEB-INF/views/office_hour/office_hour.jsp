<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"  integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="  crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.3/moment.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/CSS/officehour/officehour.css">
    <script src="${pageContext.request.contextPath }/resources/JS/officehour/officehr.js"></script>

    <title>출근 현황 페이지</title>
</head>


<div class="search">
    <form action="" class="search-content">
        <select class="form-control">
            <option value="">직원이름</option>
            <option value="">직책</option>
        </select>
        <input type="text" class="form-control">
        <input type="button" value="검색" class="btn btn-primary">
    </form>
</div>

<div class="panel panel-default">
    <div class="panel-heading"><b> 출근현황 </b>
    </div>
    <div class="tbl_user_data"></div>
</div>

</body>

</html>