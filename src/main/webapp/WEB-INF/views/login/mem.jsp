<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<jsp:include page="../top.jsp"/>

<jsp:include page="../topend.jsp"/>

<title>메인 화면</title>
</head>
<body>
<jsp:include page="../nav.jsp"/>
 <!-- Page Content  -->
        <div id="content">

            <h2>근태 현황</h2>
            <canvas id="myChart" height="400" width="400"></canvas>
            <div class="line"></div>

            <h2>공지사항</h2>
           
            <div class="col-xs-12 col-md-6 ">
                <table class="table table-sm table-hover table-borderless" >
                  <thead class="table-primary">
                    <tr>
                        <th scope="col">No.</th>
                      <th scope="col">제목</th>
                      <th scope="col">날짜</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      
                      <td>Mark</td>
                      <td>Otto</td>
                      <td class=>@mdo</td>
                    </tr>
                    <tr>
                      
                      <td>Jacob</td>
                      <td>Thornton</td>
                      <td>@fat</td>
                    </tr>
                    <tr>
                      
                      <td>Larry</td>
                      <td>Bird</td>
                      <td >@twitter</td>
                    </tr>
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