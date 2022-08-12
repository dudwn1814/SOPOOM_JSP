<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
.button{
	padding: 5px;
	width : 180px;
	margin : 5px
}

.field{
	padding: 5px;
	width : 180px;
	margin : 5px
}
</style>
<head>
<meta charset="UTF-8">
<title>JSP미니 프로젝트</title>
</head>
<body>
	<%@include file="top.jsp"%>
	<h1 align="center">로그인</h1>
		<form method="post" action="login_verify.jsp" align="center">
		<div style="margin: 5px">
			<input type="text" class="field" name="userID" placeholder="아이디">
			<br>
			<input type="password" class="field" name="userPassword" placeholder="비밀번호">
		</div>
		<div style="margin: 5px">
			<INPUT TYPE="SUBMIT" class="button" NAME="Submit" VALUE="로그인">
			<br>
			<INPUT TYPE="button" class="button" VALUE="회원가입" onclick="location.href='join.jsp'">
		</div>
		</form>
	<%@include file="footer.jsp"%>
</body>
</html>