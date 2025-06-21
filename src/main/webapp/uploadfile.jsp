<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp" %>
<html>
<head>

</head>
<body>
	<h3>업로드할 파일:</h3>
	<p>파일명: ${fileName}</p>

	<form method="POST" action="/UploadFile" enctype="multipart/form-data">
		<input type="hidden" name="action" value="upload" /> 
		<input type="hidden" name="uploadPath" value="${uploadPath}" />
		<input type="file" name="uploadFile" />
		<input type="submit" value="업로드 실행" />
	</form>
</body>
</html>
