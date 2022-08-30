<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
.msg{
	text-align:center;
	font-size:14px;
	margin-bottom : 40px
}

.msg_block{
	margin-top : 60px;
}

span{
	font-weight : bold;
}

.btn_register{
	width : 70px;
	height : 30px;
	padding : 5px;
	border-radius : 15px;
	border : 1px solid  #313131;
	background-color :  #313131;
	color : #FFFFFF;
	cursor : pointer;
	transition-duration: 0.4s;
}

.btn_register:hover{
 	opacity : 0.7;
}

</style>
<script>
	function windowClose(){
		var idChk = document.getElementById("id_chk").value;
		if(idChk == "false"){
			opener.document.getElementById("p_id").focus();
			opener.document.getElementById("id_chk").value = "false";
		}
		else if(idChk == "true"){
	   		opener.document.getElementById("id_chk").value = "true";
		}
		this.close();
	}
</script>
<head>
<meta charset="utf-8">
<title>아이디 중복 확인</title>
</head>
<body>
<div class="msg_block">
<%
request.setCharacterEncoding("utf-8");
String p_id = request.getParameter("p_id");
//DB에서 사용자 정보(아이디, password) 가져오기
String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
String user = "root";
String pwd = "0000";

Connection con = null;
Statement stmt1 = null;
ResultSet rs1 = null;
int id_count = 0;

try{
	
	Class.forName("org.mariadb.jdbc.Driver");
	con = DriverManager.getConnection(url, user, pwd);
	
	//존재하는 아이디인지 확인
	String query1 = "select count(*) as id_count from product where p_id='"+p_id+"'";
	
	stmt1 = con.createStatement();
	
	rs1 = stmt1.executeQuery(query1);
	
	while(rs1.next()) id_count = rs1.getInt("id_count");
	
	//아이디 존재
	if(id_count != 0){	
		stmt1.close();
		rs1.close();
		con.close();
%>
		<div class ="msg" >'<span style="color:red"><%=p_id %></span>' 는 이미 존재하는 상품코드입니다. </div>
		<input type="hidden" id="id_chk" value="false"> 
<%
	}
	else{
%>
	<div class ="msg" > '<span style="color:blue"><%=p_id %></span>' 는 사용 가능한 상품 코드입니다. </div>
	<input type="hidden" id="id_chk" value="true"> 
<%
	}
} catch(Exception e){
	e.printStackTrace();
}

stmt1.close();
rs1.close();
con.close();

%>

<div align="center">
<input type="button" class="btn_register" onclick="windowClose();" value="확인">
</div>
</div>
</body>
</html>
