<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>발주 페이지</title>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>


function modify(PID){
	if($("#p_amount_value").val() <= 0) { 
		alert("올바른 수량을 입력해주세요");  
		$("#p_amount_value").focus(); 
		return false;  
	}
	$("#ModifyForm").attr("action", "/Admin/Inventory/modify_proc.jsp?p_id="+PID).submit();

}

function deleteInventory(PID){
	if(confirm('삭제하시겠습니까?')){
		$("#ModifyForm").attr("action", "/Admin/Inventory/delete_proc.jsp?p_id="+PID).submit();
	}
}
</script>

<style>
body {
	font-family: "나눔고딕", "맑은고딕"
}

h1 {
	font-family: "HY견고딕"
}

.ModifyForm {
	width: 900px;
	height: auto;
	padding: 20px, 20px;
	background-color: #FFFFFF;
	text-align: center;
	border: 4px solid gray;
	border-radius: 30px;
}

.p_id, .p_name, .p_price, .p_amount, .p_image {
	width: 90%;
	border: none;
	border-bottom: 2px solid #adadad;
	margin: 20px;
	padding: 10px 10px;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
}

.btn_modify, .btn_delete {
	position: relative;
	left: 20%;
	transform: translateX(-50%);
	margin-top: 20px;
	margin-bottom: 10px;
	width: 40%;
	height: 40px;
	background: red;
	background-position: left;
	background-size: 200%;
	color: white;
	font-weight: bold;
	border: none;
	cursor: pointer;
	transition: 0.4s;
	display: inline;
}
</style>

</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	String p_id = (String)request.getParameter("p_id");

	String query =
	    "select p_id, p_name, p_unitPrice, p_unitsInStock from product where p_id = '" + p_id + "'";

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	String uri = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String uid = "root";
	String pwd = "0000";
	%>

	<%@include file="/top.jsp"%>
	<h1>발주 페이지</h1>
	<br>

	<%
	try {
	  //DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
	  //con = ds.getConnection();

	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(uri, uid, pwd);

	  stmt = con.createStatement();
	  rs = stmt.executeQuery(query);

	  if (rs.next()) {
	%>
	<form id="ModifyForm" class="ModifyForm" method="POST">
		<div class="p_image" id="p_image">
			상품이미지 :
			<%=rs.getString("p_id")%></div>
		<div class="p_id" id="p_id" name='p_id'>
			상품코드 :
			<%=rs.getString("p_id")%></div>
		<div class="p_name" id="p_name">
			상품이름 :
			<%=rs.getString("p_name")%></div>
		<div class="p_price" id="p_price">
			상품가격 :
			<%=rs.getString("p_unitPrice")%>\
		</div>
		<div class="p_amount" id="p_amount">
			상품수량 : <input type="number" id="p_amount_value" name="p_amount_value"
				value=<%=rs.getInt("p_unitsInStock")%>>
		</div>
		<button id="btn_modify" class="btn_modify"
			onclick="modify('<%=rs.getString("p_id")%>')">수정</button>
		<button id="btn_delete" class="btn_delete"
			onclick="deleteInventory('<%=rs.getString("p_id")%>')">삭제</button>
	</form>
	<%
	}

	if (stmt != null) {
	stmt.close();
	}
	if (con != null) {
	con.close();
	}
	if (rs != null) {
	rs.close();
	}

	} catch (Exception e) {
	e.printStackTrace();
	}
	%>

	<%@include file="/footer.jsp"%>
</body>
</html>