package nas;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.RequestDispatcher;
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

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uploadPath = request.getParameter("uploadPath");
        String action = request.getParameter("action");

        if ("form".equals(action)) {
            // 업로드 창 띄우기 (파일 선택용 JSP)
            request.setAttribute("uploadPath", uploadPath);
            RequestDispatcher dispatcher = request.getRequestDispatcher("uploadfile.jsp");
            dispatcher.forward(request, response);
        } else if ("upload".equals(action)) {
            // 파일 업로드 처리
            Part filePart = request.getPart("uploadFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File uploadedFile = new File(uploadDir, fileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, uploadedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            response.sendRedirect("/LoadFile?dir=" + URLEncoder.encode(uploadPath, "UTF-8"));
        }
    }
}
