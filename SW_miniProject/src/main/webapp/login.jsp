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
#loginForm{
	margin : auto;
	min-width : 700px;
}

#innerForm{
	margin : auto;
	width : 400px;
}
h3{
	text-align :left;
	margin : 30px 5px;
}

.field{
	font-size : 14px;
	line-height:23px;
	width : 100%;
	border : 1px solid #BFBFBF;
	padding : 10px 15px;
	box-sizing : border-box;
}

input:focus{
    outline: none;
}

.row{
	margin : 0px 5px;
	font-size : 14px;
	line-height : 17px;
	margin-bottom : 20px;
}

.title{
	display : block;
	margin-bottom : 12px;
	line-height : 17px;
	letter-spacing : -0.1em;
}

.btn_row{
	text-align : center;
	margin-bottom : 15px;
}

.button{
	padding: 5px;
	margin : auto;
	cursor : pointer;
	border-radius : 50px;
	width : 100%;
	max-width : 240px;
	min-width : 160px;
	height : 54px ! important;
	min-height : 54px;
	font-size : 14px !important;
	font-weight : 700;
}

.btn_box{
	margin-top : 40px;
}

#btn_login{
	color: #FFFFFF !important;
    background-color: #313131 !important;
    border-color: #313131 !important;
    border-width : 1px;
    transition-duration: 0.4s;
}

#btn_join{
	color: #313131 !important;
    background-color: #FFFFFF !important;
    border-color: #313131 !important;
    border-width : 1px;
    transition-duration: 0.4s;
}

#btn_login:hover{
 	opacity : 0.7;
}

#btn_join:hover{
 	color: #FFFFFF !important;
 	background-color: #313131 !important;
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
		<form method="post" id="loginForm">
		<div id="innerForm">
		<h3>로그인</h3>
		<div class="row">
			<label class= "title">아이디</label>
			<input type="text" class="field" id="userID" name="userID" autofocus>
		</div>
		<div class="row">
			<label class= "title">비밀번호</label>
			<input type="password" class="field" id="userPW" name="userPW">
		</div>
		<div class="btn_box">
		<div class="btn_row">
			<INPUT TYPE="SUBMIT" class="button" id="btn_login" NAME="Submit" VALUE="로그인하기">
		</div>
		<div class="btn_row">
			<INPUT TYPE="button" class="button" id="btn_join" VALUE="회원 가입하기" onclick="location.href='join.jsp'">
		</div>
		</div>
		</div>
		</form>
	<%@include file="footer.jsp"%>
</body>
</html>