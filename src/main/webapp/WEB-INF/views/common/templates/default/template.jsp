<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<tiles:insertAttribute name="globals" />

<head>
	<title>Dashboard | KingAdmin - Admin Dashboard</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="description" content="KingAdmin - Bootstrap Admin Dashboard Theme">
	<meta name="author" content="The Develovers">
	<!-- CSS -->
	<tiles:insertAttribute name="includes_css" />

	<!-- Javascript -->
	<tiles:insertAttribute name="includes_js" />

</head>

<body class="ontop-nav topnav-fixed dashboard4">
	<!-- WRAPPER -->
	<div id="wrapper" class="wrapper" style="padding-top: 100px;">
	
		<!-- TOP BAR -->
		<tiles:insertAttribute name="header" />
		<!-- END TOP BAR -->
	
		<!-- MAIN CONTENT WRAPPER -->
		<div class="row">
				<!-- START BODY -->
				<tiles:insertAttribute name="body" />
				<!-- END BODY -->
		</div>
		<!-- END CONTENT WRAPPER -->
	</div>
	<!-- END WRAPPER -->
</body>
<!-- END FOOTER -->

<%--Setting--%>
<script src="${contextRoot}/assets/js/custom/menu-setting.js"></script>
</html>
