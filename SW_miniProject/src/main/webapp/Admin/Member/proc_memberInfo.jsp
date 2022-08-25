<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
</head>
<body>

	<%
	request.setCharacterEncoding("utf-8");

	String userID = request.getParameter("userID");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String telno = request.getParameter("telno");
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");
	String extraAddress = request.getParameter("extraAddress");
	String email = request.getParameter("email");

	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String user = "root";
	String pwd = "0000";

	Connection con = null;
	Statement stmt = null;

	try {

	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(url, user, pwd);

	  //DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
	  //con = ds.getConnection();

	  String query = "update user set username = '" + username + "'," + "password = '" + password
	  + "' ," + "telno = '" + telno + "'," + "postcode = '" + postcode + "'," + "address = '"
	  + address + "'," + "detailAddress = '" + detailAddress + "'," + "extraAddress = '"
	  + extraAddress + "'," + "email = '" + email + "' where userID = '" + userID + "'";

	  System.out.println("[회원정보 수정 쿼리 ] : " + query);
	  System.out.println(userID);

	  stmt = con.createStatement();
	  stmt.executeUpdate(query);

	  stmt.close();
	  con.close();

	  response.sendRedirect("member.jsp");

	} catch (Exception e) {
	  e.printStackTrace();
	  stmt.close();
	  con.close();
	}
	%>

</body>
</html>