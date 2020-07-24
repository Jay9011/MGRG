<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 관리자 페이지 -->
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <div class="container-fluid">
            <strong>MR</strong>
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
             <ul class="list-unstyled components">
                <!-- <li class="active"> -->
                    <li>
                    <a href="#homeSubmenu">
                        <i class="fas fa-home"></i>
                        	근태 관리
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-briefcase"></i>
                       	직원 명부
                    </a>
                    <a href="#pageSubmenu" >
                        <i class="fas fa-copy"></i>
                      	  급여 관리
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-image"></i>
                       	공지 사항
                    </a>
                </li>
            </ul>
        </nav>
