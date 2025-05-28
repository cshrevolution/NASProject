package nas;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.naming.*;
import javax.sql.*;
import java.sql.*;

@WebServlet("/LoginProcess")
public class LoginProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginProcess() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		request.setCharacterEncoding("UTF-8");
	    String userId = request.getParameter("userId"); // 적은정보 가져옴
	    String password = request.getParameter("userPasswd");

	    Context ctx = null;
	    DataSource ds = null;
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        ctx = new InitialContext();
	        ds = (DataSource) ctx.lookup("datasource1");
	        con = ds.getConnection(); // db커넥하는 과정
	       	String sql = "SELECT uid, id, passwd FROM user WHERE id = ? AND passwd = ?";
	       	ps = con.prepareStatement(sql); // con sql 실행한걸 ps에 담음
		
			String isMember = request.getParameter("isMember");
			
			if ("member".equals(isMember)) {	// 회원인 경우 
	
				if (userId == null || password == null || userId.equals("test")) {
					
				}
				else {
		        		ps.setString(1, userId); // insert 
		        		ps.setString(2, password);
				}
			    
			}
	
			else if ("nonmember".equals(isMember)) { // 비회원인 경우
				ps.setString(1, "test");
				ps.setString(2, "test");
			}
	
			else {					// error
				// alert
			}

	       	rs = ps.executeQuery(); // 값을 가져와서 select

	       	if (rs.next()) { //1번째 uid 
	        	session.setAttribute("UID", rs.getString(1)); //세션값 설정
	            response.sendRedirect("file.jsp"); // 
	       	} else {
	         	//alert
	      	}


	    } catch (Exception e) {
	        out.println("로그인 오류: " + e.getMessage());
	        
	    } finally {
	        if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }
	        if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }
	        if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }
	    }
	}
}
