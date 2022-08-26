<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>발주 페이지</title>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="inventory.css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>


function modify(PID){
	if(parseInt(document.getElementById('p_amount_value').value) <= 0) { 
		alert("올바른 수량을 입력해주세요");  
		document.getElementById('p_amount_value').focus(); 
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

	String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	%>

	<%@include file="/top.jsp"%>
	<div align="center">
		<h1 class="editTitle">상품 발주</h1>
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
		<div class="row">
				<label class="title">상품이미지</label> 
				<input type="image" src="../img/1.png" alt="상품이미지" class="p_image" id="p_image" value="<%=rs.getString("p_id")%>">
		</div>
		<div class="row">
				<label class="title">상품코드</label> 
				<input type="text" class="p_id" id="p_id" value="<%=rs.getString("p_id")%>">
		</div>
		<div class="row">
				<label class="title">상품이름</label> 
				<input type="text" class="p_name" id="p_name" value="<%=rs.getString("p_name")%>">
		</div>
		<div class="row">
				<label class="title">상품가격</label> 
				<input type="text" class="p_price" id="p_price" value="<%=rs.getString("p_unitPrice")%> \">
		</div>
		<div class="row">
				<label class="title">상품수량</label> 
				<input type="number" class="p_amount_value" id="p_amount_value" name="p_amount_value" value="<%=rs.getInt("p_unitsInStock")%>">
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