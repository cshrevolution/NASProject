<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>파일 미리보기 및 다운로드</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Changed: HTML과 Body에 대한 설정 */
        html, body {
            height: 100%; /* 뷰포트의 전체 높이를 차지하도록 설정 */
            margin: 0;   /* 기본 마진 제거 */
            padding: 0;  /* 기본 패딩 제거 */
            overflow: hidden; /* Changed: 전체 페이지에 스크롤바가 생기지 않도록 숨김 */
            display: flex; /* Changed: body를 flex 컨테이너로 만들어 내부 요소 중앙 정렬 및 높이 관리 용이 */
            flex-direction: column; /* Changed: 자식 요소들이 세로로 쌓이도록 */
        }
        body {
            background-color: #f8f9fa;
        }

        .download-container {
            max-width: 90%; 
            width: 900px; /* 큰 화면에서의 최대 너비 */
            /* Changed: margin-top/bottom을 auto로 설정하여 세로 중앙 정렬을 돕고,
                        내용이 길어질 경우 스크롤이 컨테이너 내에서 발생하도록 함 */
            margin: 2vh auto 2vh auto; /* 상단 여백 추가 (뷰포트 높이의 5%) */ /* Changed: 상하좌우 auto로 세로/가로 중앙 정렬 */
            padding: 30px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            
            /* Changed: 컨테이너의 높이를 뷰포트에 맞추고, 내용이 넘치면 컨테이너 내에서 스크롤 */
            flex-grow: 1; /* Changed: body의 flex 아이템으로 남은 공간을 차지 */
            display: flex; /* Changed: 내부 요소를 위한 flexbox */
            flex-direction: column; /* Changed: 내부 요소들을 세로로 정렬 */
            justify-content: center; /* Changed: 세로 중앙 정렬 (내용이 뷰포트보다 작을 때) */
            overflow-y: auto; /* Changed: 컨테이너 내용이 넘칠 때 이 컨테이너 내에서만 세로 스크롤 허용 */
            -webkit-overflow-scrolling: touch; /* iOS Safari 부드러운 스크롤 */
        }

        @media (max-width: 768px) {
            .download-container {
                margin: 20px auto; /* Changed: 작은 화면에서 상하 마진 줄임 */
                padding: 15px;
            }
        }

        .btn-custom {
            background-color: #4A90E2;
            color: white;
        }
        .btn-custom:hover {
            background-color: #357ABD;
        }
        .preview-area {
            border: 1px solid #dee2e6;
            padding: 0; 
            min-height: 65vh; /* 뷰포트 높이의 최소 65% */
            max-height: 90vh; /* 뷰포트 높이의 최대 90% */
            background-color: #e9ecef;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; 
            flex-direction: column;
            width: 100%; 
            position: relative; 
            flex-grow: 1; /* Changed: download-container의 남은 공간을 채우도록 */
        }
        .preview-area img, 
        .preview-area video {
            max-width: 100%; 
            height: 100%;    
            display: block;
            object-fit: contain; 
        }
        .preview-area iframe { 
            width: 100%; 
            height: 100%;    
            border: none; 
            position: absolute; 
            top: 0;             
            left: 0;            
            right: 0;           
            bottom: 0;          
            overflow: auto;     /* iframe 내부 콘텐츠가 넘칠 경우 자체 스크롤바 생성 */
        }
        .no-preview-message {
            color: #6c757d;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="download-container text-center">
            <h2 class="mb-4">파일 미리보기 및 다운로드</h2>
            
            <%
                String contextPath = request.getContextPath();
                
                // 1. 세션에서 파일 경로 정보를 가져옵니다.
                // 세션에 "FILE"이라는 이름으로 파일 전체 경로가 저장되어 있다고 가정합니다.
                String fullFilePath = (String)session.getAttribute("FILE");
                
                // 테스트를 위한 임시 값 (실제 사용 시에는 주석 처리 또는 제거)
                if (fullFilePath == null || fullFilePath.isEmpty()) {
                    // Linux 테스트 환경 : /home/user1/documents/myTmax.pdf
                    fullFilePath = "C:\\file\\hello.txt"; // 내가 로컬에서 처리하던거
                    // fullFilePath = "/home/user1/documents/myTmax.pdf"; 
                }

                String filePath = "";    // 파일이 위치한 디렉토리 경로
                String fileName = "";    // 순수 파일 이름 (확장자 포함)
                String fileExtension = ""; // 파일 확장자

                // OS 독립적인 경로 구분자 처리를 위해 마지막 구분자를 찾습니다.
                // Windows는 '\', Linux/Unix는 '/'
                int lastBackslash = fullFilePath.lastIndexOf('\\');
                int lastSlash = fullFilePath.lastIndexOf('/');

                int lastSeparatorIndex = -1;

                if (lastBackslash != -1 && lastSlash != -1) {
                    // 두 구분자가 모두 있을 경우, 더 뒤에 있는 것을 선택 (혼합된 경로 처리)
                    lastSeparatorIndex = Math.max(lastBackslash, lastSlash);
                } else if (lastBackslash != -1) {
                    lastSeparatorIndex = lastBackslash;
                } else if (lastSlash != -1) {
                    lastSeparatorIndex = lastSlash;
                }

                if (lastSeparatorIndex != -1) {
                    filePath = fullFilePath.substring(0, lastSeparatorIndex);
                    fileName = fullFilePath.substring(lastSeparatorIndex + 1);
                } else {
                    // 구분자가 없을 경우, 전체가 파일 이름으로 간주합니다.
                    fileName = fullFilePath;
                    filePath = ""; // 또는 현재 디렉토리 등을 표현
                }

                // 파일 확장자 추출
                int dotIndex = fileName.lastIndexOf('.');
                if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
                    fileExtension = fileName.substring(dotIndex + 1).toLowerCase();
                }

                // URL 인코딩 (download.do와 preview.do에 전달할 때 필요)
                String encodedFileName = java.net.URLEncoder.encode(fileName, "UTF-8");
                String publicFileUrl = request.getScheme() + "://" + request.getServerName() + 
                                       (request.getServerPort() == 80 || request.getServerPort() == 443 ? "" : ":" + request.getServerPort()) + 
                                       contextPath + "/preview.do?fileName=" + encodedFileName;
            %>

            <div class="mb-4">
                <div class="preview-area">
                    <%
                        // 이 부분은 fileName 변수를 사용하여 기존 로직 그대로 유지됩니다.
                        if (fileExtension.equals("jpg") || fileExtension.equals("jpeg") ||
                            fileExtension.equals("png") || fileExtension.equals("gif") ||
                            fileExtension.equals("bmp") || fileExtension.equals("webp")) {
                    %>
                            <img src="<%=contextPath%>/preview.do?fileName=<%=fileName%>" alt="파일 미리보기" class="img-fluid">
                    <%
                        } else if (fileExtension.equals("pdf")) {
                    %>
                            <iframe src="<%=contextPath%>/preview.do?fileName=<%=fileName%>" width="100%" height="100%" style="border:none;" title="PDF 미리보기"></iframe>
                    <%
                        } else if (fileExtension.equals("txt") || fileExtension.equals("log") || fileExtension.equals("json") || fileExtension.equals("xml")) {
                    %>
                            <iframe src="<%=contextPath%>/preview.do?fileName=<%=fileName%>" width="100%" height="100%" style="border:none;" title="텍스트 파일 미리보기"></iframe>
                    <%
                        } else if (fileExtension.equals("mp4") || fileExtension.equals("webm") || fileExtension.equals("ogg")) {
                    %>
                            <video controls width="100%" height="100%">
                                <source src="<%=contextPath%>/preview.do?fileName=<%=fileName%>" type="video/<%=fileExtension%>">
                                Your browser does not support the video tag.
                            </video>
                    <%
                        } else if (fileExtension.equals("mp3") || fileExtension.equals("wav") || fileExtension.equals("ogg")) {
                    %>
                            <audio controls style="width: 100%;">
                                <source src="<%=contextPath%>/preview.do?fileName=<%=fileName%>" type="audio/<%=fileExtension%>">
                                Your browser does not support the audio element.
                            </audio>
                    <%
                        } else if (fileExtension.equals("doc") || fileExtension.equals("docx") ||
                                   fileExtension.equals("ppt") || fileExtension.equals("pptx") ||
                                   fileExtension.equals("xls") || fileExtension.equals("xlsx")) {
                    %>
                            <p class="mb-2">외부 뷰어를 통해 미리보기를 로드합니다...</p>
                            <iframe src="https://docs.google.com/gview?url=<%= publicFileUrl %>&embedded=true" 
                                    width="100%" height="100%" style="border: none;" 
                                    title="Office 문서 미리보기 (Google Docs Viewer)">
                                <p>이 브라우저는 iframe을 지원하지 않습니다. <a href="<%= publicFileUrl %>" target="_blank">문서를 직접 열어보세요</a>.</p>
                            </iframe>
                            <p class="mt-2 text-muted small">Google Docs Viewer를 사용합니다. 파일이 인터넷에 액세스 가능해야 합니다.</p>
                    <%
                        } else {
                    %>
                            <p class="no-preview-message">이 파일 형식은 브라우저에서 직접 미리보기를 지원하지 않습니다. 다운로드하여 확인해주세요.</p>
                            <p class="no-preview-message">(파일 이름: <%=fileName%>)</p>
                    <%
                        }
                    %>
                </div>
            </div>

            <p class="mb-3">
                <a href="<%=contextPath%>/download.do?fileName=<%=fileName%>" class="btn btn-custom btn-lg w-100 mt-2">
                    파일 다운로드
                </a>
            </p>
            <p class="mt-3">
                <button type="button" class="btn btn-secondary btn-lg w-100" onclick="history.back()">
                    뒤로가기
                </button>
            </p>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>