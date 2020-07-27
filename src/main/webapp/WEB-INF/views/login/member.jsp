<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<%	int puid= (Integer) session.getAttribute("puid") ;
    	int depuid= (Integer)	session.getAttribute("depuid");
    	System.out.println(puid);
    	System.out.println(depuid);
    	
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<jsp:include page="../top.jsp"/>
<jsp:include page="../topend.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/weather.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/weather-icons/2.0.10/css/weather-icons.css">
<script src="${pageContext.request.contextPath}/resources/JS/weather.js"></script>

<title>메인 화면</title>
</head>
<body>
<jsp:include page="../nav.jsp"/>
 <!-- Page Content  -->
        <div id="content">

            <h2>근태 현황</h2>
            <canvas id="myChart" height="400" width="400" style="display: inline-block;"></canvas>
<!--             날씨 -->
  <div id="san-francisco" class="card">
            <div class="card-header">
                <!-- INFO -->
                <div class="left-side">
                    <h2 class="city">오늘의 날씨</h2>
                    <!-- <span class="temperature">63°</span> -->
                    <span class="temperature"></span>
                </div>
                <div class="weather-icon">
                    <!-- PARTIALLY -->
                    <i id='icon' class="" style="font-size: 100px; padding-right: 20px;"></i>

                </div>
                <div class="header-bg" style="background-image: url(../resources/CSS/main.jpg)"></div>
                <div class="clearfix"></div>
            </div>
            <div class="coming-weather">
                <div class="col">
                    <span class="day">내일</span>
                    <div class="weather-icon">
                        <i id='day1'></i>
                    </div>
                </div>
                <div class="col">
                    <span class="day">모레</span>
                    <div class="weather-icon">
                        <i id='day2'></i>
                    </div>
                </div>
                <div class="col">
                    <span class="day">내일모레</span>
                    <div class="weather-icon">
                        <i id='day3'></i>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
            <div class="line"></div>
<!--     공지 게시판 -->
            <h2>공지사항</h2>
           
            <div class="col-xs-12 col-md-6 ">
                <table class="table table-sm table-hover table-borderless" >
                  <thead class="table-primary">
                    <tr>
                        <th scope="col">No.</th>
                      <th class="noticeCenter" scope="col">제목</th>
                      <th class="noticeCenter" scope="col">날짜</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:choose>
			<c:when test="${empty list || fn:length(list) == 0 }">
				<!-- 			배열이 비어있거나 있긴있지만 길이가 0개 짜리 배열일때를 체크 -->
			</c:when>
			<c:otherwise>
				<c:forEach var ="dto" items="${list }">
					<tr>
					<td>${dto.uid }</td>
					<td class="noticeCenter"><a class="noticea" href="view.do?uid=${dto.uid }">${dto.subject }</a></td>
					<td class="noticeCenter">${dto.regdate }</td>
					
				</tr>
				</c:forEach>
			</c:otherwise>

		</c:choose>
                  </tbody>
                </table>
                </div>

            <div class="line"></div>
        </div>
    </div>
       <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.js"></script>
      <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/js/all.min.js"></script>
 <script type="text/javascript">
 
        var ctx = document.getElementById('myChart');
        var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19, 3, 5, 2, 3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
              responsive: false,
                
            }
        });
    </script>
</body>
</html>