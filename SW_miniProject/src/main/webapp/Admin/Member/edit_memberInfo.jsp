<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<title>회원정보 변경</title>

<link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="userMain.css">

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
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
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

	<div id="display-canvas">
		<div class="mypage">

			<div class="container">

				<div class="head-title">
					<div class="heade-title-container">
						<h1 class="mainTitle">회원 정보</h1>
					</div>
				</div>

				<form id="WriteForm" class="WriteForm" method="POST">
					<div class="left-container">
						<div class="row">
							<label class="title">로그인 아이디</label> <input type="text"
								name="userID" id="userID" class="field" readonly="readonly"
								value="<%=userID%>">
						</div>
						<div class="row">
							<label class="title">회원 이메일</label> <input type="text"
								name="email" id="email" class="field" value="<%=email%>">
						</div>
						<div class="row">
							<label class="title">비밀 번호</label> <input type="text"
								name="password" id="password" class="field"
								value="<%=password%>">
						</div>
						<div class="row">
							<label class="title">휴대폰 번호</label> <input type="text"
								name="telno" id="telno" class="field" value="<%=telno%>">
						</div>
					</div>

					<div class="right-container">
						<div class="row">
							<label class="title">이름</label> <input type="text"
								name="username" id="username" class="field"
								value="<%=username%>">
						</div>
						<div class="row">
							<label class="title">우편 번호</label> <input type="text"
								name="postcode" id="postcode" class="field"
								value="<%=postcode%>">
						</div>
						<div class="row">
							<label class="title">주소</label> <input type="text" name="address"
								id="address" class="field " value="<%=address%>">
						</div>
						<div class="row">
							<label class="title">세부 주소</label> <input type="text"
								name="detailAddress" id="detailAddress" class="field"
								value="<%=detailAddress%>">
						</div>
						<div class="row">
							<label class="title">추가 주소</label> <input type="text"
								name="extraAddress" id="extraAddress" class="field"
								value="<%=extraAddress%>">
						</div>
					</div>

				</form>

			</div>

		</div>
		
			<div style="text-align: center; width: 960px; margin:auto;">
				<button id="btn_modify" class="button" onclick="registerForm()">수정</button>
				<button id="btn_delete" class="button"
					onclick="location.href='delete_memberInfo.jsp?userID=<%=userID%>'">탈퇴</button>
				<br>
				<button id="btn_list" class="button" id="btn_list"
					onclick="location.href='/Admin/Member/member.jsp?page=1'">목록</button>
			</div>		
	</div>
	<%@include file="/footer.jsp"%>
</body>
</html>