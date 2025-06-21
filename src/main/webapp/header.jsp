<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css">
	<title>TNAS</title>
	<style type="text/css">
		header {
			background-color: lightgrey;
			font-weight: bold;
            align-items: center;
            display: flex;
            justify-content: flex-end;
			height: 50px;
		}
        .user-info {
            display: flex;
            align-items: center;
        }

	</style>
</head>
<header>
	<div class="user-info">
	    <p class="m-0 me-3"><%= session.getAttribute("userName") %></p>
	    <form method="GET" action="/LoadFile" style="float: right" class="me-3">
	    	<input type="submit" value="홈" class="btn btn-outline-primary btn-sm"/>
	    </form>
	    <form method="POST" action="/LogoutProcess" style="float: right" class="me-3">
	        <input type="submit" value="로그아웃" class="btn btn-outline-primary btn-sm"/>
	    </form>
	</div>
	<br>
</header>
</html>