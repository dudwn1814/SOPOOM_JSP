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
	Statement stmt_pID = null;
	Statement stmt_p_unitsInStock = null;
	Statement stmt_p_count = null;
	Statement stmt_amount = null;
	
	ResultSet rs_pID = null;
	ResultSet rs_p_unitsInStock = null;
	ResultSet rs_p_count = null;

	String uri = "jdbc:mariadb://127.0.0.1:3306/sw_miniProject";
	String uid = "root";
	String upw = "0000";
	
	String pID = null;
	String orderID = null;
	int p_unitsInStock = 0;
	int p_count = 0;

	String query = "update shipping set status = '" + status + "' where shipID = '" + ship_id + "'";

	try {
	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(uri, uid, upw);
	  
	  //1. ship_id를 통해 orderedItem table에서 pID(상품번호) 가져오기
	  String query_pID = "SELECT o.pID, o.orderID FROM shipping s, ordereditem o WHERE s.orderID = o.orderID and s.shipID = '" + ship_id + "'";
	  
	  stmt_pID = con.createStatement();
	  rs_pID = stmt_pID.executeQuery(query_pID);

	  while (rs_pID.next()) {
	    pID = rs_pID.getString("pID");
	    orderID = rs_pID.getString("orderID");
	  }
	  
	  //2. product table에서 재고값 가져오기
	  String query_p_unitsInStock = "SELECT p_unitsInStock FROM product WHERE p_id = '" + pID + "'";

	  stmt_p_unitsInStock = con.createStatement();
	  rs_p_unitsInStock = stmt_p_unitsInStock.executeQuery(query_p_unitsInStock);

	  while (rs_p_unitsInStock.next()) {
	    p_unitsInStock = rs_p_unitsInStock.getInt("p_unitsInStock");
	  }
	  
	  //3. 결제한 수량 가져오기
	   String query_p_count = "SELECT count FROM ordereditem WHERE orderID = '" + orderID + "'";
	  
	   stmt_p_count = con.createStatement();
	   rs_p_count = stmt_p_count.executeQuery(query_p_count);

		  while (rs_p_count.next()) {
		    p_count = rs_p_count.getInt("count");
		  }
	  
		
	  //4. 상태가 결제완료이면 product table 재고 변경
		if(status.equals("주문취소")){
		  int changedStock =  p_unitsInStock + p_count;
		  String query_amount = "update product set p_unitsInStock = '" + changedStock + "' where p_id = '" + pID + "'";
		  
		  stmt_amount = con.createStatement();
		  stmt_amount.executeQuery(query_amount);
		}
	  
	  
	  stmt = con.createStatement();
	  stmt.executeQuery(query);

	  if (stmt != null) {
	    stmt.close();
	  }
	  if (stmt_pID != null) {
	    stmt_pID.close();
	  }
	  if (stmt_p_unitsInStock != null) {
	    stmt_p_unitsInStock.close();
	  }
	  if (stmt_p_count != null) {
	    stmt_p_count.close();
	  }
	  if (stmt_amount != null) {
	    stmt_amount.close();
	  }
	  if (con != null) {
	    con.close();
	  }
	  if (rs_pID != null) {
	    rs_pID.close();
	  }
	  if (rs_p_unitsInStock != null) {
	    rs_p_unitsInStock.close();
	  }
	  if (rs_p_count != null) {
	    rs_p_count.close();
	  }
	  response.sendRedirect("/myOrder.jsp?userID=agadsg");
	} catch (Exception e) {
	  e.printStackTrace();
	}
	%>

</body>
</html>