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
		        <img src="data:image/jpeg;base64,<%= base64 %>" alt="이미지 불러오기 실패">
	<%
		    } catch (Exception e) {
		        out.println("이미지를 읽는 데 실패했습니다.");
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
				out.println("텍스트를 불러오는데 실패하였습니다.");
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
	<%  } %>
</body>
</html>