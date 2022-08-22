<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원 강제 탈퇴</title>
</head>
<body>

<%
	String userid = request.getParameter("userid");

	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	
	Connection con = null;
	Statement stmt = null;
		
	String query = "delete from member where userid = '" + userid + "'";
	
	try{
		
		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, uid, pwd);
	
		stmt = con.createStatement();
		stmt.executeUpdate(query);
		
		stmt.close();
		con.close();
%>
		<script>
			alert("<%=userid %>의 탈퇴처리가 완료 되었습니다.");
			document.location.href='member';
		</script>
		
<% 
	}catch(Exception e){
		e.printStackTrace();
		stmt.close();
		con.close();

%>	

		<script>
			alert("에러가 발생하였습니다.");
			document.location.href='memberInfo.jsp?userid=' + <%=userid %>;
		</script>

<% 
	}

%>

</body>
</html>