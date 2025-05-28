<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.*" %>
<%
  Context ctx = null;
  DataSource ds = null;
  Connection con = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  String sql = "SELECT dir FROM user WHERE uid = ?";
  Integer uid = null;

  try {
    ctx = new InitialContext();
    ds = (DataSource) ctx.lookup("datasource1");
    con = ds.getConnection();
    String currentDirectory = null;

    if (session.getAttribute("UID") == null) {
	//out.println("null");%>
	<script>
	    alert("잘못된 접근입니다!");
	    window.location.href = "/test/";
	</script>

    <%}
    else {
        uid = Integer.parseInt(session.getAttribute("UID").toString());
    }%>
	<form method="post" action="logout.jsp">
               <input type="submit" value="로그아웃">
        </form>
<%

    ps = con.prepareStatement(sql);
    ps.setString(1,Integer.toString(uid));
    rs = ps.executeQuery();

    while (rs.next()) {
      currentDirectory = rs.getString(1);
    }

    if (request.getParameter("dir") != null) {
      currentDirectory = request.getParameter("dir");
    }

    out.println("<h1>" + currentDirectory + "</h1>");
    File[] dirs = new File(currentDirectory).listFiles();

    if (dirs != null) {
        String[] fileArray = new String[dirs.length];

        for (int i = 0; i < dirs.length; i++) {
            fileArray[i] = dirs[i].getAbsolutePath();
        }

        Arrays.sort(fileArray, String.CASE_INSENSITIVE_ORDER);
        request.setAttribute("sortedFiles", fileArray);
    }

   } catch ( Exception e ) {
     e.printStackTrace();

   } finally {
     if ( ps != null ) try { ps.close(); } catch(Exception e) {}
     if ( con != null ) try { con.close(); } catch(Exception e) {}
   }

%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach items="${sortedFiles}" var="file">
    <p><a href="file.jsp?dir=${file}">${file}</a></p>
</c:forEach>

