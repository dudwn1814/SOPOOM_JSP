<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
		$("#btn_login").click(function(){
	
			if($("#userID").val() =='') {
				alert("아이디를 입력하세요");
				return false;
			}
			if($("#userPW").val() =='') {
				alert("패스워드를 입력하세요");
				return false;
			}
			$("#loginForm").attr("action","login_verify.jsp").submit();
		});
		
});

</script>

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
	<% //로그인 된 상태에서 로그인 창으로 넘어가기 방지
	if (session_id != null)	response.sendRedirect("index.jsp");
	%>
	<h1 align="center">로그인</h1>
		<form method="post" id="loginForm" align="center">
		<div style="margin: 5px">
			<input type="text" class="field" id="userID" name="userID" placeholder="아이디">
			<br>
			<input type="password" class="field" id="userPW" name="userPW" placeholder="비밀번호">
		</div>
		<div style="margin: 5px">
			<INPUT TYPE="SUBMIT" class="button" id="btn_login" NAME="Submit" VALUE="로그인">
			<br>
			<INPUT TYPE="button" class="button" VALUE="회원가입" onclick="location.href='join.jsp'">
		</div>
		</form>
	<%@include file="footer.jsp"%>
</body>
</html>