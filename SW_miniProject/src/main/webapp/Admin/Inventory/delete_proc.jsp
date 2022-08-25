<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>재고 삭제 후</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");

	String p_id = (String)request.getParameter("p_id");
	
    Connection con = null;
    Statement stmt = null;

    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
   	String uid = "root";
    String upw = "1234";
    String query = "delete from inventory_management where p_id = " + p_id;


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
      response.sendRedirect("/Admin/Inventory/inventory.jsp");
	}catch(Exception e){
		e.printStackTrace();
	}
     
%>

</body>
</html>