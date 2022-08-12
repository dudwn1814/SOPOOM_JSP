<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session_id == null){
	log = "<a href=login.jsp>로그인</a>";
	join = "<a href=join.jsp>회원가입</a>";
}
else {
	log = "<a href=logout.jsp>로그아웃</a>"; 
	join = "<a href=update.jsp>사용자 정보 수정</a>";
}
%>
<style>
	#footer{
	text-align : center;
	}
</style>
<footer>
<div id="footer">
	<p>
		Copyright &copy; 소품샵프로젝트 All rights reserved.
	</p>
</div>
</footer>