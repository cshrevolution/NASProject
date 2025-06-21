package nas;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/UploadFile")
public class UploadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		out.println("<script>alert('잘못된 접근입니다!'); location.href='/LoadFile';");
	}


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
	
		PrintWriter out = response.getWriter();
		
		String action = request.getParameter("action").toString();
		
		if (action.equals("uploadForm")) {
			String currentDirectory = request.getParameter("currentDirectory");
			String userDirectory = currentDirectory.replace("/apps/user_dir/", "");
			
			request.setAttribute("currentDirectory", currentDirectory);
			request.setAttribute("userDirectory", userDirectory);
			request.getRequestDispatcher("uploadfile.jsp").forward(request, response);
		}
		else if (action.equals("doUpload")) {
			Part filePart = request.getPart("uploadFile");
			String fileName = filePart.getSubmittedFileName();
			
			String uploadPath = request.getParameter("currentDirectory");
			File file = new File(uploadPath, fileName);
			
			InputStream inStream = filePart.getInputStream();
			FileOutputStream outStream = new FileOutputStream(file);
			
			try {
				byte[] buffer = new byte[1024];
				int len;
				while ((len = inStream.read(buffer)) > 0) {
					outStream.write(buffer, 0, len);
				}
				
				out.println("<script>alert('업로드가 완료되었습니다!'); location.href='/LoadFile';</script>");
			} catch (Exception e) {
				out.println(e);
			} finally {
				inStream.close();
				outStream.close();
			}
		}
		else {
			out.println("<script>alert('잘못된 접근입니다!'); location.href='/LoadFile';");
		}
    }
}
