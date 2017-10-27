<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<div class="top-bar navbar-fixed-top">
  <div class="container">
    <div class="clearfix">
      <!-- navbar-toggle -->
      <button type="button" class="btn btn-default navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar-collapse" aria-expanded="false">
        <i class="fa fa-bars"></i>
      </button>
      <!-- end navbar-toggle -->
      <!-- logo -->
      <div class="pull-left logo">
        <a href="index.html"><img src="${contextRoot}/assets/img/kingadmin-logo-white.png" alt="KingAdmin - Admin Dashboard" /></a>
        <h1 class="sr-only">KingAdmin Admin Dashboard</h1>
      </div>
      <!-- end logo -->
      <div class="collapse navbar-collapse" id="main-navbar-collapse">
        <ul class="nav navbar-nav">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-dashboard fa-fw"></i>Dashboard <i class="fa fa-caret-down"></i></a>
            <ul class="dropdown-menu">
              <li><a href="${contextRoot}/dashboard/main"><i class="fa fa-tasks"></i><span class="text"> Dashboard </span></a></li>
				<li><a href="${contextRoot}/profile/main"><i class="fa fa-address-card"></i><span class="text"> Profile </span></a></li>
				<li><a href="${contextRoot}/email/main"><i class="fa fa-envelope"></i><span class="text"> e-Mail </span></a></li>
				<li><a href="${contextRoot}/file/main"><i class="fa fa-folder-open"></i><span class="text"> File Manager </span></a></li>
				<li><a href="${contextRoot}/calendar/main"><i class="fa fa-calendar"></i><span class="text"> Calendar </span></a></li>
				<li><a href="${contextRoot}/note/main"><i class="fa fa-pencil"></i><span class="text"> Note </span></a></li>
            </ul>
          </li>
          <li>
            <a href="page-inbox.html"><i class="fa fa-envelope-o"></i> Inbox <span class="badge red-bg">32</span></a>
          </li>
          <li>
            <a href="index.html"><i class="fa fa-reply"></i> Back to Main Page</a>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="${contextRoot}/assets/img/user-avatar.png" alt="User Avatar" />
              <span class="name">Stacy Rose</span> <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
              <li>
                <a href="#">
                  <i class="fa fa-user"></i>
                  <span class="text">Profile</span>
                </a>
              </li>
              <li>
                <a href="#">
                  <i class="fa fa-cog"></i>
                  <span class="text">Settings</span>
                </a>
              </li>
              <li>
                <a href="#">
                  <i class="fa fa-power-off"></i>
                  <span class="text">Logout</span>
                </a>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <!-- /container -->
</div>
<!-- END TOP BAR -->