<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page errorPage="error.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비번 체크 / 유저 정보 변경</title>
</head>

<body>
	<%
request.setCharacterEncoding("utf-8");
//로그인 창에서 parameter로 받은 값
String userID=request.getParameter("userID");
String userPW=request.getParameter("userPW");

//DB에서 사용자 정보(아이디, password) 가져오기
String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
String user = "root";
String pwd = "0000";

Connection con = null;
Statement stmt1 = null;
Statement stmt2 = null; 
ResultSet rs1 = null;
ResultSet rs2 = null;
int id_count = 0;
int pwd_count = 0;

%>
</body>
</html>