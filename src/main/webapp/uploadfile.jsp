<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp" %>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css">
    <style>
        .class-main {
            min-height: 100vh;
            display: grid;
            place-items: center;
        }
        .text {
            text-align: center;
            margin: 5%;
        }
	</style>
</head>
<body>
	<div class="class-main">
		<div class="jumbotron p-4 border rounded shadow bg-white">
			<h1 class="text">업로드 경로:</h1>
			<h3 class="text">${userDirectory}</h3>
    
			<form method="POST" action="/UploadFile" enctype="multipart/form-data" class="mt-5">
				<input type="hidden" name="action" value="doUpload" /> 
				<input type="hidden" name="currentDirectory" value="${currentDirectory}" />
                <div style="display: flex; flex-wrap: wrap; margin: 30px;">
                    <input type="file" name="uploadFile" class="btn btn-outline-primary mx-2"/>
				    <input type="submit" value="업로드" class="btn btn-primary mx-3 px-3"/>
                </div>
			</form>
		</div>
	</div>
</body>
</html>