package nas;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import javax.sql.*;
import java.util.Arrays;
import javax.naming.*;
import java.io.File;

@WebServlet("/LoadFile")
public class LoadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Context ctx = null;
	DataSource ds = null;
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	Integer uid = null;
	String sql = "SELECT dir FROM user WHERE uid = ?";
       
    public LoadFile() {
        super();
    }
   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("TEST");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		try {
			ctx = new InitialContext();
		    ds = (DataSource) ctx.lookup("datasource1");
		    con = ds.getConnection();
		    String currentDirectory = null;
		    
		    if (session.getAttribute("UID") == null) {
		    		out.println("<script>alert('잘못된 접근입니다!'); location.href = '/';</script>");
		    } else {
		    		uid = Integer.parseInt(session.getAttribute("UID").toString());
		    }
		    
		    ps = con.prepareStatement(sql);
		    ps.setString(1, Integer.toString(uid));
		    rs = ps.executeQuery();
		    
		    if (rs.next()) {
		    		currentDirectory = rs.getString(1);
		    		
		    }
		    else {
		    		out.println("<script>alert('잘못된 접근입니다!'); location.href = '/';</script>");
		    }
		    
		    //파일 버튼 누를 시 기존 동작 (GET Method)
		    /*
		    if (request.getParameter("dir") != null) {
    			currentDirectory = request.getParameter("dir");
    		}
    		*/
		    
		    File[] dirs = new File(currentDirectory).listFiles();
		    
		    if (dirs != null) {
		    		String[] fileArray = new String[dirs.length];
		    		String[] fileNames = new String[dirs.length];
		    		
		    		for (int i = 0; i < dirs.length; i++) {
		    			fileArray[i] = dirs[i].getAbsolutePath();
		    		}
		    		
		    		Arrays.sort(fileArray, String.CASE_INSENSITIVE_ORDER);
		    		for (int i = 0; i < fileArray.length; i++) {
		    			int slashIndex = fileArray[i].lastIndexOf('/');
		    			fileNames[i] = fileArray[i].substring(slashIndex + 1);
		    		}
		    		request.setAttribute("sortedFiles", fileArray);
		    		request.setAttribute("sortedNames", fileNames);
		    }
		    
		    String userDirectory = currentDirectory.substring(currentDirectory.lastIndexOf('/') + 1);
			request.setAttribute("userDirectory", userDirectory);
		    request.getRequestDispatcher("file.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
	
		PrintWriter out = response.getWriter();
		String currentDirectory = null;
		
		try {
			currentDirectory = request.getParameter("dir").toString();
			
			if (currentDirectory.isEmpty()) {
				out.println("<script>alert('잘못된 접근입니다!'); location.href = '/';</script>");
			}
			
			File[] dirs = new File(currentDirectory).listFiles();
			
			if (dirs != null) {
				String[] fileArray = new String[dirs.length];
				String[] fileNames = new String[dirs.length];
				
				for (int i = 0; i < dirs.length; i++) {
					fileArray[i] = dirs[i].getAbsolutePath();
				}
				
				for (int i = 0; i < fileArray.length; i++) {
	    			int slashIndex = fileArray[i].lastIndexOf('/');
	    			fileNames[i] = fileArray[i].substring(slashIndex + 1);
	    		}

				Arrays.sort(fileArray, String.CASE_INSENSITIVE_ORDER);
				request.setAttribute("sortedFiles", fileArray);
				request.setAttribute("sortedNames", fileNames);
			}
			
			String userDirectory = currentDirectory.substring(currentDirectory.lastIndexOf('/') + 1);
			request.setAttribute("userDirectory", userDirectory);
			request.getRequestDispatcher("file.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}