<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page errorPage="error.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀변호 변경</title>
</head>
<body>
	<% 
	request.setCharacterEncoding("utf-8");
	
	String password = request.getParameter("password");
	String userid = (String)session.getAttribute("userID");
	
	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String user = "root";
	String pwd = "1234";
	
	Connection con = null;
	PreparedStatement pstmt = null;

	Class.forName("org.mariadb.jdbc.Driver");
	con = DriverManager.getConnection(url, user, pwd);
	
	String sql = "UPDATE user SET password = ? WHERE userid = ?" ;
	
	pstmt = con.prepareStatement(sql);
	
	pstmt.setString(1, password);
	pstmt.setString(2, userid);
	
		
	try{
		pstmt.execute();
		pstmt.close();
		con.close();
		%>
		<script>
		alert("비밀번호가 변경되었습니다.");
		location.href = "userMain.jsp";
		</script>
		<%
		
	}catch(Exception e){
		e.printStackTrace();
		pstmt.close();
		con.close();
		System.out.println("userid 테이블 insert 오류 => " + e.getMessage());
		%>
		<script>
		alert("잠시후 다시 시도하세요.");
		location.href = "userMain.jsp";
		</script>
		<%	
	}
	
%>
</body>
</html>