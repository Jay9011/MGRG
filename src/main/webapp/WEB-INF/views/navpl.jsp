<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int empuid= (Integer) session.getAttribute("empuid");
    %>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <div class="container-fluid">
            <strong>MR</strong>
            <!-- <div class="collapse navbar-collapse" id="navbarSupportedContent"> -->
            <div id="navbarSupportedContent">
            
            <ul class="nav">
                    <li class="nav-item active">
		           	 <form action="<%= request.getContextPath() %>/officehour/present" method="post">
            	            <input type="hidden" name="emp_uid" value="<%= empuid%>">
        	                <input id="present" type="submit" class="nav-link" value="출근"></a>
        	                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}"/>
                    </form>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">퇴근</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath() %>/customLogout">로그아웃</a>
                    </li>
                </ul>
            
            </div>
        </div>
    </nav>
    