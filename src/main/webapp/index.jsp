<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css">
	<title>TNAS</title>
<style>
    body {
        background-image: url('resources/tnas.png'); /* 여기에 이미지 URL 삽입 */
        background-size: cover; /* 혹은 contain */
        background-position: center center;
        background-repeat: no-repeat;
        background-attachment: fixed;
        height: 100vh;
        margin: 0;
        padding: 0;
    }
</style>
</head>
<body class="d-flex justify-content-center align-items-center">

    <div class="col-md-4">
        <div class="jumbotron p-4 border rounded shadow bg-white bg-opacity-75">
            <form method="post" action="/LoginProcess">
                <h3 class="text-center mb-4" style="font-weight: bold;">TNAS</h3>
                <div class="form-group mb-3">
                    <input type="text" class="form-control" placeholder="아이디" name="userId" maxlength="20">
                </div>
                <div class="form-group mb-3">
                    <input type="password" class="form-control" placeholder="비밀번호" name="userPasswd" maxlength="20">
                </div>
                <input type="hidden" name="isMember" value="member">
                <input type="submit" class="btn btn-primary form-control" value="로그인">
            </form>

            <form method="post" action="/LoginProcess" class="mt-3">
                <input type="hidden" name="isMember" value="nonmember">
                <input type="submit" class="btn btn-secondary form-control" value="비회원 로그인">
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <footer class="text-center text-muted position-fixed bottom-0 w-100 py-2" style="background-color: transparent; font-size: 0.9rem;">
        TmaxFamliy
    </footer>

</body>
