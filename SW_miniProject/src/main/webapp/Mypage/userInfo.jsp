<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<body>
<%@include file="/top.jsp"%>
<h1>회원 정보</h1>
<%
	String userid = (String)session.getAttribute("userID");

	request.setCharacterEncoding("utf-8");
	if(userid == null) {response.sendRedirect("index.jsp");}
	
	String username = "";
	String password ="";
	String telno = "";
	String age = "";
	String address = "";
	String sex = "";

	//DB에서 사용자 정보
	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String uid = "root";
	String pwd = "0000";
	String query = "select * from user where userid ='" + userid + "'";
	
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {

		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, uid, pwd);
		stmt = con.createStatement();
		rs = stmt.executeQuery(query); // 쿼리문 실행 코드

		while(rs.next()) {
			username = rs.getString("username");
			password = rs.getString("password");
			telno = rs.getString("telno");
			age = rs.getString("age");
			address = rs.getString("address");
			sex = rs.getString("sex");
			
			System.out.print(username+""+password);
			
			stmt.close();
			con.close();
			rs.close();

		}

	} catch (Exception e) {
		e.printStackTrace();
	}

%>
<ul>
	<li><a> 아이디: <%=userid %> </a></li>
	<li><a> 비밀번호: <%=password %> </a></li>
	<li><input type="text" id="pwChange" value=""> <input type="button" id="pwChangeBt" value="비밀번호 변경"></li>
	<li><a> 이름: <%=username %></a></li>
	<li><a> 나이: <%=age %></a></li>
	<li><a> 성별: <%=sex %></a></li>
	<li><a> 주소: <%=address %></a></li>
</ul>

<a href= "userMain.jsp"> 메인페이지로 이동 </a>

<script type="text/javascript">

$(document).ready(function() {
	$("#pwChangeBt").click(function(){

		var pwChange = $('#pwChange').val();
		
		if( pwChange == ""){
			alert("변경할 비밀번호를 입력 해 주세요."); }
		//여기에 조건으로 걸러내기
		//이후 db 수정하는 부분까지 만들기
	}); 
});
</script>

<%@include file="/footer.jsp"%>
</body>
</html>