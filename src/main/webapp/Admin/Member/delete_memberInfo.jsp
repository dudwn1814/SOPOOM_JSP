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
<<<<<<< HEAD:SW_miniProject/src/main/webapp/Admin/Member/delete_memberInfo.jsp
	String userid = request.getParameter("userid");

	String url = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
	String uid = "root";
	String pwd = "0000";
=======
	String userid = request.getParameter("userID");

	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/Admin/Member/delete_memberInfo.jsp
	
	Connection con = null;
	Statement stmt = null;
		
	String query = "delete from user where userID = '" + userid + "'";
	
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