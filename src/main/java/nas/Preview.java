package nas;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Preview")
public class Preview extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		if (session.getAttribute("FILE") != null) session.removeAttribute("FILE");
		
		out.println("<script>alert('잘못된 접근입니다!'); location.href='/';");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		File readFile = new File(session.getAttribute("FILE").toString());
		String fileType = readFile.toString().substring(readFile.toString().lastIndexOf('.') + 1).toLowerCase();
		
		List<String> imageType = List.of("png", "jpg", "jpeg", "gif");
		List<String> textType = List.of("txt", "csv", "json", "log");
		
		if (imageType.contains(fileType)) { // 파일이 이미지나 텍스트인 경우 (imageType내 선언되어 있는 확장자) 
			request.setAttribute("fileType",  "img");
			request.getRequestDispatcher("previewfile.jsp").forward(request, response);
		}
		else if (textType.contains(fileType)) {
			request.setAttribute("fileType",  "text");
			request.getRequestDispatcher("previewfile.jsp").forward(request, response);
		}
		else {
			session.removeAttribute("FILE");
			out.println("<script>alert('지원하지 않는 확장자 형식입니다.'); location.href='/';");
		}
	}
}
