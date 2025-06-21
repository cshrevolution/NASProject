<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css">
	<title>TNAS</title>
	<style>
	
	</style>
</head>
<body>
	<div>
		<h1>${fileName}</h1>
		<br>
		<br>
		<form method="POST" action="/Preview">
			<input type="hidden" name="filePath" value="${filePath}"/>
			<p>텍스트 파일, 이미지 파일만 미리보기가 가능합니다!</p>
			<button type="submit">미리보기</button>
		</form>
		<br>
		<br>
		<form method="POST" action="/DownloadFile">
			<input type="hidden" name="fileName" value="${fileName}"/>
			<input type="hidden" name="filePath" value="${filePath}"/>
			<button type="submit">다운로드</button>
		</form>
	</div>
</body>
</html>