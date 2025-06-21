<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp" %>
<html>
<head>

</head>
<body>
	<h1>업로드 경로:</h1>
	<h3>${userDirectory}</h3>

	<form method="POST" action="/UploadFile" enctype="multipart/form-data">
		<input type="hidden" name="action" value="doUpload" /> 
		<input type="hidden" name="currentDirectory" value="${currentDirectory}" />
		<input type="file" name="uploadFile" />
		<input type="submit" value="업로드 실행" />
	</form>
</body>
</html>
