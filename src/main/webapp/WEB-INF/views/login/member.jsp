<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<%	int puid= (Integer) session.getAttribute("puid") ;
    	int depuid= (Integer)session.getAttribute("depuid");
    	int empuid= (Integer) session.getAttribute("empuid");
    	String empname = (String)session.getAttribute("empname");
    	System.out.println(puid);
    	System.out.println(depuid);
    	System.out.println(empuid);
    	System.out.println(empname);
    	
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<jsp:include page="../top.jsp"/>
<jsp:include page="../datatable.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/table.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/weather.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/member/evo-calendar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/CSS/mem.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/weather-icons/2.0.10/css/weather-icons.css">
<script src="${pageContext.request.contextPath}/resources/JS/weather.js"></script>
<script src="${pageContext.request.contextPath}/resources/JS/umain.js"></script>
<script src="${pageContext.request.contextPath}/resources/JS/member/evo-calendar.js"></script>
<jsp:include page="../topend.jsp"/>

<title>메인 화면</title>
</head>
<body>
<jsp:include page="../navpl.jsp"/>
 <!-- Page Content  -->
        <div id="content">

            <h2>근태 현황</h2>
            <div style="display: inline-block;">
            <div class="text-right">
      			<button type="button" id="viewcom" class="btn btnadd"><small>현황 더보기</small> +</button>
			</div>
            <canvas id="myChart" height="400" width="400" style="display: inline-block;"></canvas>
            </div>
<!--             	근태현황 테이블 -->
            <span id="comShow" style="display: none;" >
            	<div>
            	근태 현황ㅇ입니다.
            	</div>
            </span>
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
          <div class="col-xs-12 col-md-6 ">
          	<div>
            <h2 class="float-left">공지사항</h2>
           	<div class="float-right">
      			<button type="button" id="viewnotice" class="btn btnadd"><small>공지 더보기</small> +</button>
			</div>
			</div>	
                <table class="table table-sm table-hover table-borderless tale" >
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
				<c:forEach var ="dto" items="${list}" begin="0" end="3">
					<tr>
					<td>${dto.uid }</td>
					<td class="noticeCenter"><span class="noticea" data-uid="${dto.uid }">${dto.subject }</span></td>
					<td class="noticeCenter">${dto.regdate }</td>
					
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
                  </tbody>
                </table>
                </div>
            <div class="line"></div>
            
            <!-- 공지사항 더보기 모달 -->
		<div class="modal fade" id="viewmodal" data-keyboard="false"  role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="staticBackdropLabel">공지사항</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body margin">
		       	 <table id="notitable" class="table table-sm table-hover table-borderless tale tale2" >
		       	 <thead class="table-primary">
                    <tr>
                        <th style="width:1%">No.</th>
                      <th style="width:95%">제목</th>
                      <th  style="width:4%">날짜</th>
                    </tr>
                  </thead>
		       	<tbody>
		       	 <c:forEach var ="dto" items="${list}" >
					<tr>
					<td>${dto.uid }</td>
					<td ><span class="noticea" data-uid="${dto.uid }">${dto.subject }</span></td>
					<td >${dto.regdate }</td>
					
				</tr>
				</c:forEach>
		       	 <tbody>
		       	 </table>
		       	
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- 공지사항 내용 보기 -->
		<div class="modal fade" id="uviewModal" data-keyboard="false"  role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="staticBackdropLabel">제목</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body margin">
		     <div class="text-right"> 작성일 : <span id="reg">날짜</span></div>

			      <div id="cont">
			       	내용
			       	<div>
		      </div>
		    </div>
		  </div>
		</div>
            
            
            
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
    <script>
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    	$(document).ready(function(){
    		// ajax를 보내기전에 header세팅해주기
    		$.ajaxSetup({
    	        beforeSend: function(xhr) {
    	        	xhr.setRequestHeader(header, token);
    	        }
    	    });
    		
    		$('#present').click(function(){
    			
    		$.ajax({
    			url : "/hrm/offhour/present",
    			type : "POST",
    			cache : false,
    			
    			success : function(data, status){
    				if(status == "success"){
    					//alert('수정 성공');
    				}
    			}
    			
    		});
    		})
    		
    		
    		
    	});
    	
    </script>
</body>
</html>