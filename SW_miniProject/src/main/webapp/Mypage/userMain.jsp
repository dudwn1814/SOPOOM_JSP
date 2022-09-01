<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>


<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>유저 정보 - 메인 페이지</title>

<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.5/dist/web/static/pretendard.css" />
<link rel="stylesheet" href="userMain.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
	<script>
		function pwConfig() {
			var btn = document.getElementById('password').value;

			if (btn == "") {
				alert("패스워드를 입력하세요.");
				return false;
			} else {
				document.userbasic.action = "pwCheck.jsp";
				document.userbasic.action.submit;
			}

		}

		function press() {
			if (event.keyCode == 13) {
				pwConfig();
			} //13은 엔터
		}
	</script>


	<%
String userid = (String)session.getAttribute("userID");
String username = "";
String password = "";
String postcode = "";
String address = "";
String detailAddress = "";
String extraAddress = "";
String telno = "";
String email = "";

	if (userid == null) {
	%>
	alert("로그인이 필요한 서비스입니다."); location.href = "./login.jsp";
	<%
	}
	%>

	<%@include file="/top.jsp"%>
	<% 
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	
	//String lastLogindate = (String)session.getAttribute("lastlogin"); //세션 값 형변환
	
	String query = "select username from user where userid='"+userid+"'";

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {

		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, uid, pwd);
		stmt = con.createStatement();
		rs = stmt.executeQuery(query); // 쿼리문 실행 코드

		while (rs.next()) { //행이 있는지 없는지 bool값 반환
			username = rs.getString("username");
		}
		stmt.close();
		con.close();
		rs.close();

	} catch (Exception e) {
		e.printStackTrace();
	}
	
	%>
	

	<!-- 회원 정보 네비게이션 바 -->
	<div id="display-canvas">
		<div class="mypage">

			<div class="container">

				<div class="head-title">
					<div class="heade-title-container">
						<span class="mainTitle">회원 정보</span>
					</div>
				</div>

				<div class="left-container">
					<div class="row">
						<label class="title">로그인 아이디</label>
						<input type="text" class="field" readonly="readonly" value="<%=userid%>">
					</div>
					<div class="row">
						<label class="title">회원 이메일</label>
						<input type="text" class="field" readonly="readonly" value="<%=email%>">
					</div>
					<div class="row">
						<label class="title">비밀번호</label>
						<input type="text" class="field" readonly="readonly" value="********">
					</div>
					<div class="row">
						<label class="title">휴대폰 번호</label>
						<input type="text" class="field" readonly="readonly" value="<%=telno%>">
					</div>

					<div class="row">
						<button class="field shipping-conf-btn" onclick="location.href='myOrder.jsp?userID=<%=userid%>'">배송 정보</button>
					</div>

				</div>


				<form name=userbasic id=userbasic>
					<div class="right-container">
						<div class="row">
							<label class="title">이름</label>
							<input type="text" class="field" readonly="readonly" value="<%=username%>">
						</div>
						<div class="row">
							<label class="title">우편 번호</label>
							<input type="text" class="field" readonly="readonly" value="<%=postcode%>">
						</div>
						<div class="row">
							<label class="title">주소</label>
							<input type="text" class="field " readonly="readonly" value="<%=address%>">
							<input type="text" class="field" readonly="readonly" value="<%=detailAddress%>">
							<input type="text" class="field" readonly="readonly" value="<%=extraAddress%>">
						</div>
						<div class="row" id="pw-check">
							<input type="password" name="password" id="password" class="field" placeholder="비밀번호를 입력하세요." value="" onkeydown="press()">
						</div>
						<div class="row">
							<input type="submit" id="pwconfigBtn" class="field user-info-modify-btn" onclick="pwConfig()" value="비밀번호 확인">
						</div>
					</div>
			</form>	
			</div>
		</div>
	</div>


	<form name = userbasic id= userbasic >
		로그인 아이디 :<%=userid %> <br>
		회원 이름: <%=username %><br>
		회원 정보 확인/수정: <input type="password" id="password" name="password" class="password"  placeholder="비밀번호를 입력하세요.">
		<button id="button" id="password" onclick="pwConfig()">비밀번호 확인</button>
	</form>
	<form action=""></form>
	<%@include file="/footer.jsp"%>
</body>
</html>