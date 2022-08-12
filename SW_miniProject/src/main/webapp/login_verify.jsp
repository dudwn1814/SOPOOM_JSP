<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
String userID=request.getParameter("userID");
String userPassword=request.getParameter("userPassword");

Connection myConn = null;
ResultSet myResultSet = null;
Statement stmt = null;
String mySQL = null;

/*
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:mariadb://127.0.0.1:3306/webdev";
String user = "DBProgramming";
String passwd = "oracle";
*/

Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);

stmt = myConn.createStatement();

mySQL="select u_id from system_user where u_id='" + userID + "'and pwd='" + userPassword + "'";

myResultSet = stmt.executeQuery(mySQL);

if(myResultSet.next()) {
	session.setAttribute("user", userID);
	response.sendRedirect("main.jsp");
}
else {
	%>
	<script>
		alert("올바른 아이디와 비밀번호를 입력하세요.");
		location.href = "login.jsp";
	</script>
	<%
}

stmt.close();
myConn.close();
%>