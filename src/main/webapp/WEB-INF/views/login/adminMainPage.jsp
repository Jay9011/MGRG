<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin MainPage</title>
</head>
<script
	src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/16327/gsap-latest-beta.min.js"></script>
<script
	src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/16327/CSSRulePlugin3.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/CSS/login/adminLoginMain.css">
<body>
	<div class="container">
		<div class="slider">

			<div class="box1 box">
				<div class="bg"></div>
				<div class="details">
					<h1>직원 근태 현황</h1>
					<p>직원들의 출근/지각/결근/휴가 현황을 확인하실수 있습니다.</p>
					<button onclick="location.href='/hrm/officehour/list'">Check Now</button>
				</div>

				<div class="illustration">
					<div class="inner"></div>
				</div>
			</div>


			<div class="box2 box">
				<div class="bg"></div>
				<div class="details">
					<h1>I'm the second Box</h1>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
						Integer lacinia dui lectus. Donec scelerisque ipsum diam, ac
						mattis orci pellentesque eget.</p>
					<button>Check Now</button>
				</div>

				<div class="illustration">
					<div class="inner"></div>
				</div>
			</div>

			<div class="box3 box">
				<div class="bg"></div>
				<div class="details">
					<h1>I'm the third Box</h1>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
						Integer lacinia dui lectus. Donec scelerisque ipsum diam, ac
						mattis orci pellentesque eget.</p>
					<button>Check Now</button>
				</div>

				<div class="illustration">
					<div class="inner"></div>
				</div>
			</div>

			<div class="box4 box">
				<div class="bg"></div>
				<div class="details">
					<h1>I'm the fourth Box</h1>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
						Integer lacinia dui lectus. Donec scelerisque ipsum diam, ac
						mattis orci pellentesque eget.</p>
					<button>Check Now</button>
				</div>

				<div class="illustration">
					<div class="inner"></div>
				</div>
			</div>

			<div class="box5 box">
				<div class="bg"></div>
				<div class="details">
					<h1>I'm the fifth Box</h1>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
						Integer lacinia dui lectus. Donec scelerisque ipsum diam, ac
						mattis orci pellentesque eget.</p>
					<button>Check Now</button>
				</div>

				<div class="illustration">
					<div class="inner"></div>
				</div>
			</div>

		</div>

		<svg xmlns="http://www.w3.org/2000/svg" class="prev" width="56.898"
			height="91" viewBox="0 0 56.898 91">
			<path d="M45.5,0,91,56.9,48.452,24.068,0,56.9Z"
				transform="translate(0 91) rotate(-90)" fill="#fff" /></svg>
		<svg xmlns="http://www.w3.org/2000/svg" class="next" width="56.898"
			height="91" viewBox="0 0 56.898 91">
			<path d="M45.5,0,91,56.9,48.452,24.068,0,56.9Z"
				transform="translate(56.898) rotate(90)" fill="#fff" /></svg>
		<div class="trail">
			<div class="box1 active">1</div>
			<div class="box2">2</div>
			<div class="box3">3</div>
			<div class="box4">4</div>
			<div class="box5">5</div>
		</div>
	</div>
	<script src="<%= request.getContextPath() %>/resources/JS/login/adminLoginMain.js" ></script>
</body>
</html>