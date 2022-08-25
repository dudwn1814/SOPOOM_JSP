<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>배송 상태 수정 후</title>
</head>
<body>

	<%
	request.setCharacterEncoding("utf-8");

	String ship_id = request.getParameter("ship_id");
	String status = request.getParameter("statusSelect");

	Connection con = null;
	Statement stmt = null;

	String uri = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String uid = "root";
	String upw = "1234";

	String query = "update shipping set status = '" + status + "' where shipID = '" + ship_id + "'";

	try {
	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(uri, uid, upw);

	  //DataSource ds = (DataSource)this.getServletContext().getAttribute("dataSource");
	  //con = ds.getConnection();

	  stmt = con.createStatement();
	  stmt.executeQuery(query);

	  if (stmt != null) {
	    stmt.close();
	  }
	  if (con != null) {
	    con.close();
	  }
	  response.sendRedirect("/Admin/Shipping/shipping.jsp");
	} catch (Exception e) {
	  e.printStackTrace();
	}
	%>

</body>
</html>