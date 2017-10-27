<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentMenu" scope="session" value="${sessionScope.currentMenu}" />

<script>
    var currentMenu = "<c:out value="${currentMenu}"/>";
</script>