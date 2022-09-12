<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품을 장바구니에 담고 있습니다.</title>
<script>
   function alertNoUserId() {
      alert("로그인 후 이용하실 수 있습니다.");
   }
   function alertDuplicateProduct() {
      alert("이미 찜한 상품입니다.");
   }
</script>
</head>

<body>
   <%
   request.setCharacterEncoding("UTF-8");
   String userid = (String) session.getAttribute("userID");

   System.out.println("userid = " + userid);
   
   if (userid == null) {
   %>
   <script>
      alertNoUserId();
      location.href='/Login/login.jsp';
   </script>

   <% } 
   else {
   		String id = (String) request.getParameter("id"); // 상품 아이디
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			
			String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
			String uid = "root";
			String pwd = "1234";
	
	      Class.forName("org.mariadb.jdbc.Driver");
	      con = DriverManager.getConnection(url, uid, pwd);
	   
	      String sql = "delete from dibs where userID = '" + userid + "' and p_id = '" + id + "'";
	      
	      Statement stmt = con.createStatement();
	      stmt.executeQuery(sql);
	         
	      if(stmt != null) stmt.close();
	      
	      }catch(Exception e){
	         e.printStackTrace();
	      }
      
      response.sendRedirect("dibsList.jsp?userID="+userid);
   }
   %>
</body>
</html>