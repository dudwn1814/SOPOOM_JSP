<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>


<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>유저 정보 - 메인 페이지</title>
</head>
<body>

<script>
	
	function pwConfig() {
		
		if(document.userbasic.password.value ==''){
			alert("패스워드를 입력하세요."); 
		 	return false; 
		}
		
		 document.userbasic.action = 'pwCheck.jsp';
		 document.userbasic.submit(); 
	}
	
	function press() {
		//event.keyCode == 13 : enter 값
		if(event.keyCode == 13){ pwConfig();}
	}
	
/* 	function logout() {
		document.userbasic.action = 'Logout.jsp';
		document.userbasic.submit();
	} */
	
	</script>
	<%@include file="/top.jsp"%>
	<% 
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	
	//String lastLogindate = (String)session.getAttribute("lastlogin"); //세션 값 형변환
	String userid = (String)session.getAttribute("userID");
	String username = "select username from user where userid='"+userid+"'";

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {

		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, uid, pwd);
		stmt = con.createStatement();
		rs = stmt.executeQuery(username); // 쿼리문 실행 코드

		while (rs.next()) { //행이 있는지 없는지 bool값 반환
			username = rs.getString("username");
			stmt.close();
			con.close();
			rs.close();

		}

	} catch (Exception e) {
		e.printStackTrace();
	}
	
	%>
	

	<!-- 회원 정보 네비게이션 바 -->
	<div class="my-page-nav" id="mypage-menu">
		<span class="my-page-nav-icon"></span>
		<h2 class="heading-2">Your account</h2>
		<!-- <div class="list">
			<ul>
				<li class="is-active" href="#"><a> 회원 정보 </a></li>
				마이페이지 기본값
				<li><a href="Delivery.jsp"> 주문 / 배송</a></li>
				<li><a href="../shoppingCart/shoppingCart.jsp"> 장바구니</a></li>
				
			</ul>

		</div> -->

	</div>


	<form name = userbasic id= userbasic >
		로그인 아이디 :<%=userid %> <br>
		회원 이름: <%=username %><br>
		<!-- <input type="button" onclick="logout()" value="로그아웃"><br>  -->
		회원 정보 확인/수정: <input type="password" id="password" name="password" class="password"  placeholder="비밀번호를 입력하세요.">
		<button id="button" id="password" onclick="pwConfig()">비밀번호 확인</button>
		<%
		
		%>
	</form>
	<form action=""></form>
	<%@include file="/footer.jsp"%>
</body>
</html>