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

    // 정상적으로 로그인을 할 경우 POST Method로 form의 값을 받아오나 잘못된 요청을 할 경우 alert창을 띄우고 로그인 화면으로 이동. 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('잘못된 요청입니다!'); location.href = '/';</script>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
	    String userId = request.getParameter("userId");
	    String password = request.getParameter("userPasswd");

	    Context ctx = null;
	    DataSource ds = null;
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        ctx = new InitialContext();
	        ds = (DataSource) ctx.lookup("datasource1"); // JEUS의 Datasource 중 datasource1이라는 이름을 찾음 
	        con = ds.getConnection(); // datasource1의 커넥션 객체 하나를 가져옴
	       	String sql = "SELECT uid, id, passwd FROM user WHERE id = ? AND passwd = ?";
	       	ps = con.prepareStatement(sql); // con 객체로 sql문을 실행하기 위해 sql 변수를 가져옴
		
			String isMember = request.getParameter("isMember");
			
			if ("member".equals(isMember)) {	// 회원인 경우 
	
				if (userId == null || password == null || userId.equals("test")) { // 입력 칸에 아무것도 넣지 않거나 비회원 계정으로 로그인할 경우 alert 창을 띄우고 로그인 화면으로 이동
					out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); location.href = '/';</script>");
				} else {
					ps.setString(1, userId); // sql문의 첫번째 물음표에 userId 값을 넣음
		        	ps.setString(2, password); // sql문의 두번째 물음표에 password 값을 넣음
				}
			    
			} else if ("nonmember".equals(isMember)) { // 비회원인 경우 test test 계정으로 로그인
				ps.setString(1, "test");  
				ps.setString(2, "test");
				userId = "test";	// 비회원일때 session userName 속성 저장하기 위한 하드코딩;;
			} else { // 오류 발생시 alert창을 띄우고 로그인 창으로 이동
				out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); location.href = '/';</script>");
			}

	       	rs = ps.executeQuery(); // ps 내의 완성된 sql 쿼리문을 실행해서 rs 객체에 넣음

	       	if (rs.next()) { // rs 객체에 쿼리문을 실행한 결과가 있을 경우 
	        	session.setAttribute("UID", rs.getString(1));	// rs 객체의 첫번째 값(UID)를 세션 속성에 설정 (JEUS Monitoring - Web - List Session에서 확인 가능)
	        	session.setAttribute("userName", userId);
	        	out.println("<script>alert('로그인에 성공했습니다.'); location.href = '/LoadFile';</script>");
	       	} else { // rs 객체에 쿼리문을 실행한 결과가 없을 경우 alert창을 띄우고 로그인 화면으로 이동
	       		out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); location.href = '/';</script>");
	      	}
	    } catch (Exception e) {
	        out.println("로그인 오류: " + e.getMessage());
	        
	    } finally {
	        if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
	        }
	        if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
	        }
	        if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
	        }
	    }
	}
}
