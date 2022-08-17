<%@page import="java.sql.*"%>
<%@page errorPage="error.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인 체크</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
//로그인 창에서 parameter로 받은 값
String userID=request.getParameter("userID");
String userPW=request.getParameter("userPW");

//DB에서 사용자 정보(아이디, password) 가져오기
String url ="jdbc:mariadb://127.0.0.1:3306/webdev";
String user = "webmaster";
String pwd = "0000";

Connection con = null;
Statement stmt1 = null;
Statement stmt2 = null; 
ResultSet rs1 = null;
ResultSet rs2 = null;
int id_count = 0;
int pwd_count = 0;

try{
	
	Class.forName("org.mariadb.jdbc.Driver");
	con = DriverManager.getConnection(url, user, pwd);
	
	//존재하는 아이디인지 확인
	String query1 = "select count(*) as id_count from tbl_member where userid='"+userID+"'";
	//패스워드가 틀렸는지 확인
	String query2 = "select count(*) as id_count from tbl_member where userid='"+userID+"' and password='"+userPW+"'";
	
	stmt1 = con.createStatement();
	stmt2 = con.createStatement();
	
	rs1 = stmt1.executeQuery(query1);
	rs2 = stmt2.executeQuery(query1);
	
	while(rs1.next()) id_count = rs1.getInt("id_count");
	while(rs2.next()) pwd_count = rs2.getInt("id_count");
	
	//아이디 존재 && 패스워드 맞음
	if(pwd_count != 0){
		//session.setAttribute("세션 변수", );
		session.setAttribute("userID", userID);
		
		stmt1.close();
		stmt2.close();
		rs1.close();
		rs2.close();
		con.close();
		
		response.sendRedirect("index.jsp");
		
	}else if(id_count == 0){
		
		stmt1.close();
		stmt2.close();
		rs1.close();
		rs2.close();
		con.close();

%>
<script>
	alert("사용자가 존재하지 않습니다.");
	document.location.href = "login.jsp";
</script>
<% 				
	}else if(id_count!=0 && pwd_count ==0){ 	// 아이디는 있으나 패스워드가 틀린 사용자
	
		stmt1.close();
		stmt2.close();
		rs1.close();
		rs2.close();
		con.close();
		
%>
<script>
	alert("패스워드를 잘못 입력했습니다.");
	document.location.href = "login.jsp";
</script>
<%			
	}
	
} catch(Exception e){
	e.printStackTrace();
}

stmt1.close();
stmt2.close();
rs1.close();
rs2.close();
con.close();


response.sendRedirect("login.jsp");

%>
</body>
</html>
