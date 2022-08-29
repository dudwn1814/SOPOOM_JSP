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
	String postcode = "";
	String address = "";
	String detailAddress = "";
	String extraAddress = "";
	String email = "";

	//DB에서 사용자 정보
	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniproject";
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
			postcode = rs.getString("postcode");
			address = rs.getString("address");
			detailAddress = rs.getString("detailAddress");
			extraAddress = rs.getString("extraAddress");
			email = rs.getString("email");
			
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
	<li><a> 이메일: <%=email %></a></li>
	<li><a> 비밀번호: <%=password %></a></li> <!--  회원정보 확인하기 전까지는 안뜨게 바꿀 예정입니다 -->
	<li><a> 휴대폰 번호: <%=telno %></a></li><!--  번호 010 - 0000 - 0000 뜨게 만들 예정입니다. -->
	<li><a> 이름: <%=username %></a></li>
	<li><a> 우편번호: <%=postcode %></a></li>
	<li><a> 주소: <%=address %> <%=detailAddress %> <%=extraAddress %></a></li>
</ul>



<%@include file="/footer.jsp"%>
</body>
</html>