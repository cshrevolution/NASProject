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
		.class-preview {
			min-height: 100vh;
			display: grid;
			place-items: center;
		}
	</style>
</head>
<body>
	<div class="class-preview">
		<div class="w-75 h-75 jumbotron p-4 border rounded shadow bg-white" style="display: flex; justify-content: center; text-align: center; align-items: center;">
			<%@ page import="java.io.*, java.util.Base64" %>
			<%
				if (request.getAttribute("fileType") == "img") {
					String filePath = session.getAttribute("FILE").toString();
				    File file = new File(filePath);
				    String base64 = "";
				    try (FileInputStream fis = new FileInputStream(file)) {
				        byte[] bytes = new byte[(int) file.length()];
				        fis.read(bytes);
				        base64 = Base64.getEncoder().encodeToString(bytes);%>
					    <img src="data:image/jpeg;base64,<%= base64 %>" alt="이미지 불러오기 실패" style="max-width: 100%; max-height: 100%; object-fit: contain; display: block;">
			<%
				    } catch (Exception e) {
				        out.println("이미지를 읽어오는 과정에서 오류가 발생했습니다.");
				    }
				}
				else if (request.getAttribute("fileType") == "text") {
					String filePath = session.getAttribute("FILE").toString();
					BufferedReader reader = null;
					
					try {
						reader = new BufferedReader(new FileReader(filePath));
							
						while (true) {
							String line = reader.readLine();
							if (line == null) break;
							out.println(line + "<br>");
						}
					} catch (Exception e) {
						out.println("<br>텍스트를 불러오는 과정에서 오류가 발생했습니다.<br>");
						out.println(e);
					} finally {
						try {
							reader.close();
						} catch (Exception e) {
							out.println("ERROR");
							out.println(e);
						}
					}
				}
				else { %>
			<script>alert('오류가 발생했습니다.'); location.href='/';</script>
			<% } %>	
		</div>
	</div>

</body>
</html>
