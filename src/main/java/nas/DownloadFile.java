package nas;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DownloadFile")
public class DownloadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		String getFilePath = session.getAttribute("FILE").toString();
		
		if (getFilePath == null) {
			out.println("<script>alert('잘못된 요청입니다!'); location.href='/LoadFile';</script>");
		}
		else {
			int index = getFilePath.lastIndexOf('/');
			String fileName = getFilePath.substring(index + 1);
			
			request.setAttribute("filePath", session.getAttribute("FILE"));
			request.setAttribute("fileName", fileName);
			request.getRequestDispatcher("downloadfile.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		String fileName = request.getParameter("fileName").toString();
		String filePath = request.getParameter("filePath").toString();
		
		File downloadFile = new File(filePath);
		FileInputStream in = new FileInputStream(filePath);
		
		fileName = new String(fileName.getBytes("UTF-8"), "8859_1");
		
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
		ServletOutputStream os = response.getOutputStream();
		
		try {
			int fileLength;
			byte[] fileByte = new byte[(int)downloadFile.length()];
			while ((fileLength = in.read(fileByte)) > 0) {
				os.write(fileByte, 0, fileLength);
			}
		} catch (Exception e) {
			session.removeAttribute("FILE");
			os.flush();
			os.close();
			response.getWriter().println(e);
		} finally {
			os.flush();
			os.close();
			in.close();
		}
	}
}