<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<div id="left-sidebar" class="left-sidebar">
	<!-- main-nav -->
	<div class="sidebar-scroll">
		<nav class="main-nav">
			<ul class="main-menu">
				<li class="${sessionScope.currentMenu == 'DASHBOARD' ? 'active' : '' }"><a href="${contextRoot}/dashboard/main"><i class="fa fa-tasks"></i><span class="text">Dashboard </span></a></li>
				<li class="${sessionScope.currentMenu == 'PROFILE' ? 'active' : '' }"><a href="${contextRoot}/profile/main"><i class="fa fa-address-card"></i><span class="text">Profile </span></a></li>
				<li class="${sessionScope.currentMenu == 'EMAIL' ? 'active' : '' }"><a href="${contextRoot}/email/main"><i class="fa fa-envelope"></i><span class="text">e-Mail </span></a></li>
				<li class="${sessionScope.currentMenu == 'FILE' ? 'active' : '' }"><a href="${contextRoot}/file/main"><i class="fa fa-folder-open"></i><span class="text">File Manager </span></a></li>
				<li class="${sessionScope.currentMenu == 'CALENDAR' ? 'active' : '' }"><a href="${contextRoot}/calendar/main"><i class="fa fa-calendar"></i><span class="text">Calendar </span></a></li>
				<li class="${sessionScope.currentMenu == 'NOTE' ? 'active' : '' }"><a href="${contextRoot}/note/main"><i class="fa fa-pencil"></i><span class="text">Note </span></a></li>
			</ul>
		</nav>
		<!-- /main-nav -->
	</div>
</div>