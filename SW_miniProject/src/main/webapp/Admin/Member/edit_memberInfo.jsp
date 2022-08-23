<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원정보 변경</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>

<%
	request.setCharacterEncoding("utf-8");
	//String userID = (String)session.getAttribute("userID");
	//if(userid == null) response.sendRedirect("index.jsp");
	
	String userid = request.getParameter("userid");
	System.out.println(userid);
%>

function registerForm(){
	
	$("#WriteForm").attr("action", "proc_memberInfo.jsp?userid=<%=userid%>").submit();
	
}

</script>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }

.ModifyForm {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align: center;
  border:4px solid gray;
  border-radius: 30px;
}

.textbox {
  width: 90%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 20px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.btn_write, .btn_cancel {
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: red;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}
</style>

</head>   
<body>

<%
 	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	String query = "select * from user where userID= '" + userid + "'"; 
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
    
        
	try{
		
		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, uid, pwd);

		//DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
		//con = ds.getConnection();
				
		stmt = con.createStatement();
		rs = stmt.executeQuery(query);
		
	while(rs.next()){ 
			
			username = rs.getString("username");
			password = rs.getString("password");
			telno = rs.getString("telno");
			postcode = rs.getString("postcode");
			address = rs.getString("address");
			detailAddress = rs.getString("detailAddress");
			extraAddress = rs.getString("extraAddress");
			email = rs.getString("email");
		}
		
	}catch(Exception e)	 {
		e.printStackTrace();
	}

	stmt.close();
	con.close();

%>

<div align="center">
	<h1>회원정보 변경</h1>
	<br>
	
	<form id="WriteForm" class="WriteForm" method="POST">
		<div class="textbox">아이디 : <input type="text" id="userid" value="<%=userid %>" disabled></div>
		<div class="textbox">이름 : <input type="text" name="username" value="<%=username %>"></div>
		<div class="textbox">비밀번호 : <input type="text" name="password" value="<%=password%>"></div>
		<div class="textbox">전화번호 : <input type="text" id="telno" name="telno" value="<%=telno %>"></div>
		<div class="textbox">우편번호 : <input type="text" id="postcode" name="postcode" value="<%=postcode %>">
		주소 : <input type="text" id="address" name="address" value="<%=address %>"></div>
		<div class="textbox">세부주소 : <input type="text" id="detailAddress" name="detailAddress" value="<%=detailAddress %>">
		추가주소 : <input type="text" id="extraAddress" name="extraAddress" value="<%=extraAddress %>"></div>
		<div class="textbox">이메일 : <input type="text" name="email" value="<%=email%>"></div>
		<br><br>
		
		<input type="button" class="btn_write" value="수정" onclick="registerForm()" />
		<input type="button" class="btn_cancel" value="취소" onclick="history.back()" />
	</form>
</div>
</body>
</html>