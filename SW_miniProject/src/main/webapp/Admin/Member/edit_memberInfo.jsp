<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원정보 변경</title>

<link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="member.css">

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>

<%request.setCharacterEncoding("utf-8");
String userID = request.getParameter("userID");
System.out.println(userID);%>

function registerForm(){
	$("#WriteForm").attr("action", "proc_memberInfo.jsp?userID=<%=userID%>").submit();
	}
</script>



</head>
<body>

	<%
	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String uid = "root";
	String pwd = "0000";
	String query = "select * from user where userID= '" + userID + "'";
	System.out.println("[수정 보기 쿼리] : " + query);

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	String username = "";
	String password = "";
	String telno = "";
	String postcode = "";
	String address = "";
	String detailAddress = "";
	String extraAddress = "";
	String email = "";


	try {
	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(url, uid, pwd);

	  //DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
	  //con = ds.getConnection();

	  stmt = con.createStatement();
	  rs = stmt.executeQuery(query);

	  while (rs.next()) {

	    username = rs.getString("username");
	    password = rs.getString("password");
	    telno = rs.getString("telno");
	    postcode = rs.getString("postcode");
	    address = rs.getString("address");
	    detailAddress = rs.getString("detailAddress");
	    extraAddress = rs.getString("extraAddress");
	    email = rs.getString("email");
	  }
	} catch (Exception e) {
	  e.printStackTrace();
	}

	stmt.close();
	con.close();
	%>

	<div align="center">
		<h1 class="editTitle">회원정보 변경</h1>
		<br>
		<form id="WriteForm" class="WriteForm" method="POST">
			<div class="row">
				<label class="title">아이디</label> <input type="text" class="field"
					id="userID" value="<%=userID%>" disabled>
			</div>
			<div class="row">
				<label class="title">비밀번호</label> <input type="text" class="field"
					name="password" value="<%=password%>">

			</div>
			<div class="row">
				<label class="title">이름</label> <input type="text" class="field"
					name="username" value="<%=username%>">
			</div>
			<div class="row">
				<label class="title">우편번호</label> 
				<input type="text" class="field" id="postcode" name="postcode" value="<%=postcode%>"> 
			</div>
			<div class="row">	
				<label class="title">주소</label>
				<input type="text" class="field" id="address" name="address" value="<%=address%>"><br> 
			</div>
			<div class="row">	
				<label class="title">세부주소</label>
				<input type="text" class="field" id="detailAddress" name="detailAddress" value="<%=detailAddress%>"> 
			</div>
			<div class="row">	
				<label class="title">추가주소</label>
				<input type="text" class="field" id="extraAddress" name="extraAddress" value="<%=extraAddress%>">
			</div>
			<div class="row">
				<label class="title">전화번호</label> <input type="text" class="field"
					id="telno" name="telno" value="<%=telno%>">

			</div>
			<div class="row">
				<label class="title">이메일</label> <input type="text" class="field"
					name="email" value="<%=email%>">

			</div>
			<br> <br> <input type="button" class="btn_write" value="수정"
				onclick="registerForm()" /> <input type="button" class="btn_cancel"
				value="취소" onclick="history.back()" />
		</form>
	</div>
		<%@include file="/footer.jsp"%>
</body>
</html>