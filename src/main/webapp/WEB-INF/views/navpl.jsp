<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
<c:when test="${numin == 0}">
<script>
// $(document).ready(function(){
//     	$('#present').attr('disabled',false);
//     	$('#off').attr('disabled',true);
    	
// });
</script>
</c:when>
<c:when test="${numout >= 1}">
<script>
// $(document).ready(function(){
// 	$('#present').attr('disabled',true);
// 		$('#off').attr('disabled',true);
// });
</script>
</c:when>
<c:when test="${numin >= 1}">
<script>
// $(document).ready(function(){
//     	$('#present').attr('disabled',true);
//     	$('#off').attr('disabled',false);
// });
</script>
</c:when>
</c:choose>


<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <div class="container-fluid">
            <strong>MR</strong>
            <!-- <div class="collapse navbar-collapse" id="navbarSupportedContent"> -->
            <div id="navbarSupportedContent">
            

            <ul class="nav ">
                    <li class="nav-item">
		           	 <form method="post" id="presentform">
            	            <input type="hidden" name="emp_uid" value="${empuid }">
        	                <input id="present" type="button" class="nav-link rounded" value="출근" disabled="disabled">
        	                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
                    </form>
                    </li>
                    <li class="nav-item">
                        <form id="offform" method="post">
            	            <input type="hidden" name="emp_uid" value="${empuid }">
        	                <input id="off" type="button" class="nav-link rounded" value="퇴근" disabled="disabled">
        	                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
                    	</form>
                    </li>
                     <li class="nav-item">
                        <a id="cls" class="nav-link" href="<%=request.getContextPath() %>/customLogout">로그아웃</a>
                    </li>
                </ul>
            
            </div>
        </div>
    </nav>
    
    <script>
   	var token = $("meta[name='_csrf']").attr("content");
   	var header = $("meta[name='_csrf_header']").attr("content");
    $(function(){

    	initAttendance();

    	$('#present').click(function() {
	  		var data = $('#presentform').serialize();
	  		$.ajax({
	  		   url : "present",
	  		   type : "POST",
	  		   cache : false,
	  		   data : data,
	  		   success : function(data, status) {
	  		      if (status == "success") {
		  		      if(data.status == "OK"){
		  		    	Swal.fire({
		  		    	  icon: 'success',
		  		    	  title: '출근 완료!',
		  		    	  text: data.message
		  		    	});
		  		    	initAttendance();
		  		      } else if(data.status == "FAIL"){
		  		    	Swal.fire({
		  		    	  icon: 'error',
		  		    	  title: '출근 처리 실패!',
		  		    	  text: data.message
		  		    	});
		  		    	initAttendance();
		  		      }
	  		      }
	  		   }
   			});
    	});

   		$('#off').click(function() {
   		var data = $('#offform').serialize();
	   		$.ajax({
	   		   url : "off",
	   		   type : "POST",
	   		   cache : false,
	   		   data : data,
	   		   success : function(data, status) {
	   		      if (status == "success") {
	   		    	if(data.status == "OK"){
		  		    	Swal.fire({
		  		    	  icon: 'success',
		  		    	  title: '퇴근 완료!',
		  		    	  text: data.message
		  		    	});
		  		    	initAttendance();
		  		      }	else if(data.status == "FAIL"){
		  		    	Swal.fire({
		  		    	  icon: 'error',
		  		    	  title: '퇴근 처리 실패!',
		  		    	  text: data.message
		  		    	});
		  		    	initAttendance();
		  		      }
	   		      }
	   		   }
	   		});
   		});
    });

	function initAttendance(){
		$('body').loadingModal({
    		position:'auto',
    		text:'',
    		color:'#fff',
    		opacity:'0.7',
    		backgroundColor:'rgb(0,0,0)',
    		animation:'cubeGrid'
    	});
    	
	    $.ajaxSetup({
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			}
		});
		
		$.ajax({
			url : 'checkAttend',
			type : 'POST',
			cache : false,
			data : {
				'emp_uid' : ${empuid}
			},
			success : function(data, status){
				$('body').loadingModal('destroy');
				if(status == 'success'){
					if(data.status == 'OK'){
						var data = data.data[0];
						if(data == null || data.length < 1){
							// 출근 정보가 없을 때
							$("#present").attr('disabled',false);
							$('#off').attr('disabled',true);
						} else if(data.end == null){
							// 퇴근하기 전
							$("#present").attr('disabled',true);
							$('#off').attr('disabled',false);
						} else {
							// 퇴근 마친 후
							$("#present").attr('disabled',true);
							$('#off').attr('disabled',true);
						}
					} else {
						Swal.fire({
							  title: '다시 시도해 주세요.',
							  text: '직원 정보를 불러오는데 실패했습니다.',
							  icon: 'error',
							  showCancelButton: false,
							  confirmButtonColor: '#3085d6',
							  cancelButtonColor: '#d33',
							  confirmButtonText: '다시 시도하기'
							}).then((result) => {
							  if (result.value) {
								  location.reload();
							  }
						});
					}
				} else {
				}
			},
			error : function(xhr, ajaxSettings, thrownError) 
			{
				Swal.fire({
					  title: '인터넷 연결을 다시 확인해 주세요.',
					  text: '직원 정보를 불러오는데 실패했습니다.',
					  icon: 'error',
					  showCancelButton: false,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: '다시 시도하기'
					}).then((result) => {
					  if (result.value) {
					  }
				});
			},
			complete : function()
			{
			}
		});
		chartReset();
		holidayReload();
	}
    </script>