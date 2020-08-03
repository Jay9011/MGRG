<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
<c:when test="${numin == 0}">
<script>
$(document).ready(function(){
    	$('#present').attr('disabled',false);
    	$('#off').attr('disabled',true);
    	
});
</script>
</c:when>
<c:when test="${numout >= 1}">
<script>
$(document).ready(function(){
	$('#present').attr('disabled',true);
		$('#off').attr('disabled',true);
});
</script>
</c:when>
<c:when test="${numin >= 1}">
<script>
$(document).ready(function(){
    	$('#present').attr('disabled',true);
    	$('#off').attr('disabled',false);
});
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
        	                <input id="present" type="submit" class="nav-link rounded" value="출근">
        	                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
                    </form>
                    </li>
                    <li class="nav-item">
                        <form id="offform" method="post">
            	            <input type="hidden" name="emp_uid" value="${empuid }">
        	                <input id="off" type="submit" class="nav-link rounded" value="퇴근" disabled>
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
    