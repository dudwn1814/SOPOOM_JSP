<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<title>재고 목록</title>

<style>
body {
	font-family: "나눔고딕", "맑은고딕"
}

h1 {
	font-family: "HY견고딕"
}

a:link {
	color: black;
}

a:visited {
	color: black;
}

a:hover {
	color: red;
}

a:active {
	color: red;
}

#hypertext {
	text-decoration-line: none;
	cursor: hand;
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

.bottom_menu {
	margin-top: 20px;
}

.bottom_menu>a:link, .bottom_menu>a:visited {
	background-color: #FFA500;
	color: maroon;
	padding: 15px 25px;
	text-align: center;
	display: inline-block;
	text-decoration: none;
}

.bottom_menu>a:hover, .bottom_menu>a:active {
	background-color: #1E90FF;
	text-decoration: none;
}
</style>

</head>

<body>

	<%
	request.setCharacterEncoding("utf-8");

	String query =
	    "select p_id, p_name, p_unitPrice, p_unitsInStock from product";

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
	%>

	<%@include file="/top.jsp"%>
	<div class="tableDiv">
		<h1>상품 재고</h1>
		<table class="InventoryInfoTable">
			<tr>
				<th>상품코드</th>
				<th>상품명</th>
				<th>가격</th>
				<th>수량</th>
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
					<tr onMouseover="this.style.background='#46D2D2';"
						onmouseout="this.style.background='white';">
						<td><%=rs.getString("p_id")%></td>
						<td style="text-align: center;"><a id="hypertext"
							href="/Admin/Inventory/inventoryInfo.jsp?p_id=<%=rs.getString("p_id")%>"
							onMouseover="this.style.textDecoration='
							underline'"
							onmouseout="this.style.textDecoration='none'"><%=rs.getString("p_name")%></a></td>
						<td style="text-align: right;">\ <%=rs.getInt("p_unitPrice")%></td>
						<td><%=rs.getInt("p_unitsInStock")%></td>
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

		<div class="bottom_menu">
			<a href="/index.jsp">홈으로</a>&nbsp;&nbsp;
		</div>
	</div>

	<%@include file="/footer.jsp"%>
</body>
</html>