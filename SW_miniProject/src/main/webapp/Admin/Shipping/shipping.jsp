<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>

<script>
	function statusModify(ship_id) {
		$("#statusForm").attr("action","/Admin/Shipping/modify_shipping.jsp?ship_id=" + ship_id).submit();
	}
</script>

<title>배송관리 페이지</title>

<style>
body {
	font-family: "나눔고딕", "맑은고딕"
}

h1 {
	font-family: "HY견고딕"
}

.tableDiv {
	text-align: center;
}

.InventoryInfoTable {
	border-collapse: collapse;
	border-top: 3px solid #168;
	width: 800px;
	margin-left: auto;
	margin-right: auto;
}

.InventoryInfoTable th {
	color: #168;
	background: #f0f6f9;
	text-align: center;
}

.InventoryInfoTable th, .InventoryInfoTable td {
	padding: 10px;
	border: 1px solid #ddd;
}

.InventoryInfoTable th:first-child, .InventoryInfoTable td:first-child {
	border-left: 0;
}

.InventoryInfoTable th:last-child, .InventoryInfoTable td:last-child {
	border-right: 0;
}

.InventoryInfoTable tr td:first-child {
	text-align: center;
}

.InventoryInfoTable caption {
	caption-side: top;
}
</style>

</head>

<body>
	<%
	request.setCharacterEncoding("utf-8");

	String query =
	    "select s.shipID, o.orderID, u.userID, u.username, u.telno, s.address, s.status from shipping s, `order` o, user u "
	    + "where s.orderID = o.orderID AND u.userID = o.userID";

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	%>

	<%@include file="/top.jsp"%>
	<div class="tableDiv">
		<h1>배송관리</h1>
		<table class="InventoryInfoTable" id="InventoryInfoTable">
			<tr>
				<th>배송 아이디</th>
				<th>주문번호</th>
				<th>주문자 ID</th>
				<th>주문자 이름</th>
				<th>주문자 전화번호</th>
				<th>배송지</th>
				<th>배송상태</th>
			</tr>

			<tbody>
				<%
				try {
				  //DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
				  //con = ds.getConnection();

				  Class.forName("org.mariadb.jdbc.Driver");
				  con = DriverManager.getConnection(uri, uid, pwd);

				  stmt = con.createStatement();
				  rs = stmt.executeQuery(query);

				  while (rs.next()) {
				%>
				<tr id="tr">
					<td><%=rs.getString("shipID")%></td>
					<td><%=rs.getString("orderID")%></td>
					<td><%=rs.getString("userID")%></td>
					<td><%=rs.getString("username")%></td>
					<td><%=rs.getString("telno")%></td>
					<td><%=rs.getString("address")%></td>
					<td>
						<form name="statusForm" id="statusForm" method="post">
							<select id="statusSelect" name="statusSelect"
								class="statusSelect">
								<option value="none" disabled selected><%=rs.getString("status")%></option>
								<option value="배송전">배송전</option>
								<option value="배송중">배송중</option>
								<option value="배송완료">배송완료</option>
								<option value="배송취소">배송취소</option>
							</select>
						</form>
					</td>
					<td><input type="button" name="statusBtn" id="statusBtn"
						value="변경" onclick="statusModify('<%=rs.getString("shipID")%>')" /><td>
 				
				</tr>
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
		</tbody>

	</table>
</div>
<%@include file="/footer.jsp"%></
					body>
</html>