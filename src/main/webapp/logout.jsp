<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	//out.println(session.getAttribute("UID"));
	session.removeAttribute("UID");
%>
<script>
	alert("로그아웃 되었습니다.");
	window.location.href = "/NAS_Project/";
</script>
