<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 관리자 페이지 -->
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <div class="container-fluid">
            <a href="${pageContext.request.contextPath}/login/admain" class=""><strong>MR</strong></a>
            <!-- <div class="collapse navbar-collapse" id="navbarSupportedContent"> -->
            <div id="navbarSupportedContent">
            <ul class="nav ">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">로그아웃</a>
                    </li>
                    <li>
                        <button type="button" id="sidebarCollapse" class="btn btnsh  text-dark">
                            <i class="fas fa-align-left"></i>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="wrapper">
        <!-- Sidebar  -->
        <nav id="sidebar">
             <ul class="list-unstyled components lio">
                <!-- <li class="active"> -->
                    <li>

                    <a href="${pageContext.request.contextPath}/officehour/list">
              <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-briefcase-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
				  <path fill-rule="evenodd" d="M0 12.5A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5V6.85L8.129 8.947a.5.5 0 0 1-.258 0L0 6.85v5.65z"/>
				  <path fill-rule="evenodd" d="M0 4.5A1.5 1.5 0 0 1 1.5 3h13A1.5 1.5 0 0 1 16 4.5v1.384l-7.614 2.03a1.5 1.5 0 0 1-.772 0L0 5.884V4.5zm5-2A1.5 1.5 0 0 1 6.5 1h3A1.5 1.5 0 0 1 11 2.5V3h-1v-.5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5V3H5v-.5z"/>
				</svg>
                       	근태 관리
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/staff">
                     <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-diagram-3-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
					  <path fill-rule="evenodd" d="M8 5a.5.5 0 0 1 .5.5V7H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V5.5A.5.5 0 0 1 8 5zm-8 6.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5v-1zm6 0A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5v-1zm6 0a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5v-1z"/>
					  <path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6h-1A1.5 1.5 0 0 1 6 4.5v-1z"/>
					</svg>
                       	직원 명부
                    </a>
                    </li>
                <li>
                <a href="#pageSubmenu" >
                      <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-cash-stack" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path d="M14 3H1a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1h-1z"/>
						  <path fill-rule="evenodd" d="M15 5H1v8h14V5zM1 4a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V5a1 1 0 0 0-1-1H1z"/>
						  <path d="M13 5a2 2 0 0 0 2 2V5h-2zM3 5a2 2 0 0 1-2 2V5h2zm10 8a2 2 0 0 1 2-2v2h-2zM3 13a2 2 0 0 0-2-2v2h2zm7-4a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
						</svg>
                      	  급여 관리
                    </a>
                    </li>
               	 <li>
                    <a href="#">
					<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-file-earmark-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M4 1h5v1H4a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V6h1v7a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2z"/>
  <path d="M9 4.5V1l5 5h-3.5A1.5 1.5 0 0 1 9 4.5z"/>
  <path fill-rule="evenodd" d="M5 11.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
</svg>
                       	문서 관리
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/notice">
					<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-info-square" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
					  <path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
					  <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
					  <circle cx="8" cy="4.5" r="1"/>
					</svg>
                       	공지 사항
                    </a>
                </li>
            </ul>
        </nav>
