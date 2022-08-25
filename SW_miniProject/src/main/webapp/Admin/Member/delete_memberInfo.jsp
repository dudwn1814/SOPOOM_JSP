<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원 강제 탈퇴</title>
</head>
<body>

	<%
	String userID = request.getParameter("userID");

	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String uid = "root";
	String pwd = "0000";

	Connection con = null;
	Statement stmt = null;

	String query = "delete from user where userID = '" + userID + "'";

	try {

		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, uid, pwd);

		stmt = con.createStatement();
		stmt.executeUpdate(query);

		if (stmt != null)
			stmt.close();

		if (con != null)
			con.close();
	%>
	<script>
			alert("<%=userID%>의 탈퇴처리가 완료 되었습니다.");
			document.location.href = 'member.jsp';
	</script>

	<%
	} catch (Exception e) {
		e.printStackTrace();
	%>

	<script>
		alert("에러가 발생하였습니다.");
		document.location.href = 'memberInfo.jsp?userID=' +<%=userID%>;
	</script>

	<%
	}
	%>

</body>
</html>