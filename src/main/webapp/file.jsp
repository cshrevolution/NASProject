<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>TNAS</title>
</head>
<body>
	<form method="POST" action="/LogoutProcess">
		<input type="submit" value="로그아웃">
	</form>
	
	<h1><%= request.getAttribute("currentDirectory") %></h1>
	
	<c:forEach items="${sortedFiles}" var="file">
		<p><a href="file.jsp?dir=${file}">${file}</a></p>
	</c:forEach>
	
</body>
</html>