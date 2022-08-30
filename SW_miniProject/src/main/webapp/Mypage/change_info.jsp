<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page errorPage="error.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>=유저 정보 변경</title>
</head>

<body>
	<%
request.setCharacterEncoding("utf-8");
	
String userid = (String)session.getAttribute("userID");

String postcode = request.getParameter("postcode");
String address = request.getParameter("address");
String extraAddress = request.getParameter("extraAddress");
String detailAddress = request.getParameter("detailAddress");

System.out.println(postcode);

String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
String user = "root";
String pwd = "1234";

Connection con = null;
PreparedStatement pstmt = null;

Class.forName("org.mariadb.jdbc.Driver");
con = DriverManager.getConnection(url, user, pwd);

String sql = "UPDATE user SET postcode = ?, address = ?, extraAddress =?, detailAddress =? WHERE userid = ?" ;

pstmt = con.prepareStatement(sql);

pstmt.setString(1, postcode);
pstmt.setString(2, address);
pstmt.setString(3, extraAddress);
pstmt.setString(4, detailAddress);
pstmt.setString(5, userid);

try{
	pstmt.execute();
	pstmt.close();
	con.close();
	%>
	<script>
		alert("유저 정보가 변경되었습니다.");
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
		location.href = "userInfo.jsp";
	</script>
	<%	
}

%>
</body>
</html>