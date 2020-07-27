<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <div class="container-fluid">
            <strong>MR</strong>
            <!-- <div class="collapse navbar-collapse" id="navbarSupportedContent"> -->
            <div id="navbarSupportedContent">
            <ul class="nav ">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">출근</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">퇴근</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="#">로그아웃</a>
                    </li>
                    <li>
                        <button type="button" id="sidebarCollapse" class="btn btnsh">
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
                    <a href="#homeSubmenu">
                        <i class="fas fa-home"></i>
                      	  마이페이지
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-briefcase"></i>
                       
                    </a>
                    <a href="#pageSubmenu" >
                        <i class="fas fa-copy"></i>
                        Pages
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fas fa-image"></i>
                        Portfolio
                    </a>
                </li>
            </ul>
        </nav>