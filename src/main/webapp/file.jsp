<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css">
	<title>TNAS</title>
	<style>
		html::-webkit-scrollbar {
			display: none;
		}
		.class-head {
			display: flex;
			justify-content: space-between;
			margin: 20px 30px 50px;
		}
		.class-body {
			margin: 0px 30px 80px;
			display: flex;
			flex-wrap: wrap;
			gap: 40px;
		}
		.class-directory {
			background-image: url('resources/directory_icon.webp');
			background-size: contain;
			background-repeat: no-repeat;
			background-position: center center;
			width: 100px;
			height: 100px;
			border: 0px;
			background-color: white;
		}
		.class-file {
			background-image: url('resources/file_icon.webp');
			background-size: contain;
			background-repeat: no-repeat;
			background-position: center center;
			width: 100px;
			height: 100px;
			border: 0px;
			background-color: white;
		}
	</style>
</head>
<body>
	<div class="class-head">
		<h1>${userDirectory}</h1>
	</div>
	
	<div class="class-body">
		<c:forEach items="${dirArray}" var="file" varStatus="status">
			<form method="POST" action="/LoadFile">
	  			<input type="hidden" name="dir" value="${file}" />
	  			<button type="submit" class="class-directory"></button>
	  			<p>${dirNames[status.index]}</p>
			</form>
		</c:forEach>
		<c:forEach items="${fileArray}" var="file" varStatus="status">
			<form method="POST" action="/LoadFile">
	  			<input type="hidden" name="dir" value="${file}" />
	  			<button type="submit" class="class-file"></button>
	  			<p>${fileNames[status.index]}</p>
			</form>
		</c:forEach>
	</div>
	<footer class="text-center text-muted position-fixed bottom-0 w-100">
		<form method="POST" action="/LoadFile">
			<% 
				String dir = request.getAttribute("currentDirectory").toString();
				int index = dir.lastIndexOf('/');
				String upperDirPath = dir.substring(0, index);
			%>
			<input type="hidden" name="dir" value="<%= upperDirPath %>" />
			<input type="submit" value="뒤로가기" class="btn btn-primary m-1"/>
		</form>
		<form method="POST" action="/UploadFile" class="form-control">
		    <input type="hidden" name="action" value="uploadForm" />
		    <input type="hidden" name="currentDirectory" value="${currentDirectory}" />
		    <input type="submit" value="파일 업로드" class="btn btn-primary m-1"/>
		</form>
	</footer>	
</body>
</html>