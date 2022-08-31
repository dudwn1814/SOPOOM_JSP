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
      alert("상품이 장바구니에 담겨있습니다. 장바구니에서 수량을 조절하세요.");
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

   System.out.println("id = " + id);


	//카트갯수 조회
	int cartNum = 0;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
		
		String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
		String uid = "root";
		String pwd = "1234";

      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(url, uid, pwd);
      
      Statement stmt = con.createStatement();
   
      String countsql = "SELECT COUNT(*) as cartNum FROM cart WHERE p_id = '" + id + "' AND userID = '" + userid + "'";
   
      rs = stmt.executeQuery(countsql);
      
      while(rs.next()) cartNum = rs.getInt("cartNum");
      
      System.out.println("[카트번호] : " + countsql);
      
      if(rs != null) rs.close();
      if(stmt != null) stmt.close();
      
   } catch(Exception e) {
      e.printStackTrace();
   }
   
   if (cartNum == 0) {
      String sql = "insert into cart(userID, p_id, QUANTITY) values('" +userid+ "','" + id + "',1)";
      
      try{
         
         Statement stmt = con.createStatement();
         stmt.executeQuery(sql);
         
         if(stmt != null) stmt.close();
      }catch(Exception e){
         e.printStackTrace();
      }
      
      response.sendRedirect("shoppingCart.jsp");
   } else { %>
   <script>
         alertDuplicateProduct();
         location.href="shoppingCart.jsp";
         </script>
   <%    }
   if(con != null) {
      con.close();
   }
   }
   %>
</body>
</html>