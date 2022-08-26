<%@page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>

<title>회원 정보</title>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="member.css">

</head>

<body>

	<%@include file="/top.jsp"%>
	<%
	request.setCharacterEncoding("utf-8");
	String userID = request.getParameter("userID");

	//DB에서 사용자 정보(아이디랑 패스워드 가져 오기)
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	%>

	<div class="tableDiv">
		<h1 class="infoTitle">회원 정보</h1>
		<hr class="infoHr">
		<table class="memberInfoTable">
			<tr>
				<th>USER ID</th>
				<th>USER NAME</th>
				<th>PASSWORD</th>
				<th>TELNO</th>
				<th>E-MAIL</th>
				<th>POST CODE</th>
				<th>ADDRESS</th>
				<th>DETAIL ADDRESS</th>
				<th>EXTRA ADDRESS</th>
			</tr>

			<tbody>

				<%
				String query = "select * from user where userID= '" + userID + "'";

				Connection con = null;
				Statement stmt = null;
				ResultSet rs = null;

				try {

				  Class.forName("org.mariadb.jdbc.Driver");
				  con = DriverManager.getConnection(url, uid, pwd);

				  stmt = con.createStatement();
				  rs = stmt.executeQuery(query);

				  while (rs.next()) {
				%>

				<tr>
					<td class="tdIfnoId"><%=rs.getString("userID")%></td>
					<td class="tdIfnoName"><%=rs.getString("username")%></td>
					<td class="tdIfnoPw"><%=rs.getString("password")%></td>
					<td class="tdIfnoTelno"><%=rs.getString("telno")%></td>
					<td class="tdIfnoEmail"><%=rs.getString("email")%></td>
					<td class="tdIfnoPostCode"><%=rs.getString("postcode")%></td>
					<td class="tdIfnoAddress"><%=rs.getString("address")%></td>
					<td class="tdIfnoDetailAddress"><%=rs.getString("detailAddress")%></td>
					<td class="tdIfnoExtraAddress"><%=rs.getString("extraAddress")%></td>

				</tr>

				<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				}

				if (stmt != null)
				stmt.close();
				if (rs != null)
				rs.close();
				if (con != null)
				con.close();
				%>
			</tbody>
		</table>
	</div>
		<div class="bottom_menu">
			<a href="member.jsp">목록으로</a>&nbsp;&nbsp; 
			<a href="edit_memberInfo.jsp?userID=<%=userID%>">회원정보 수정</a>&nbsp;&nbsp;
			<a href="delete_memberInfo.jsp?userID=<%=userID%>">회원 강제 탈퇴</a>&nbsp;&nbsp;
		</div>

	<%@include file="/footer.jsp"%>
</body>
</html>