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
        .class-main {
            min-height: 100vh;
            display: grid;
            place-items: center;
        }
	</style>
</head>
<body>
	<div class="class-main">
        <div class="jumbotron p-4 border rounded shadow bg-white">
            <h1 style="text-align: center;">${fileName}</h1>
            <div style="display: flex; flex-wrap: wrap; margin: 20px;">
                <form method="POST" action="/Preview" class="m-4">
                    <input type="hidden" name="filePath" value="${filePath}"/>
                    <button type="submit" class="btn btn-primary form-control px-5 py-2">미리보기</button>
                </form>
                <form method="POST" action="/DownloadFile" class="m-4">
                    <input type="hidden" name="fileName" value="${fileName}"/>
                    <input type="hidden" name="filePath" value="${filePath}"/>
                    <button type="submit" class="btn btn-primary form-control px-5 py-2">다운로드</button>
                </form>
            </div>
            <p style="text-align: center;">텍스트, 이미지 파일만 미리보기가 가능합니다!</p>
        </div>
		
	</div>
</body>
</html>