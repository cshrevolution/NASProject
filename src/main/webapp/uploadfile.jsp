<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head><title>파일 업로드 확인</title></head>
<body>
    <h3>업로드할 파일:</h3>
    <p>파일명: ${fileName}</p>

    <form method="POST" action="UploadFile">
    	<input type="hidden" name="action" value="upload" />
        <input type="hidden" name="step" value="confirm" />
        <input type="hidden" name="fileName" value="${fileName}" />
        <input type="hidden" name="tempPath" value="${tempPath}" />
        <input type="submit" value="업로드 확정" />
    </form>
</body>
</html>
