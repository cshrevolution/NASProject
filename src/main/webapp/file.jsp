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
	<form method="POST" action="/UploadFile" enctype="multipart/form-data">
		<input type="file" name="fileData" /><br>
		<input type="submit" value="업로드" />
	</form>
	
	<h1><%= request.getAttribute("userDirectory") %></h1>
	
	<c:forEach items="${sortedFiles}" var="file" varStatus="status">
		<hr>
		<form action="/LoadFile" method="post">
  			<input type="hidden" name="dir" value="${file}" />
  			<button type="submit">${sortedNames[status.index]}</button>
		</form>
	</c:forEach>
</body>
</html>
