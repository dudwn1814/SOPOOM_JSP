<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">

<head>
<link rel="stylesheet" href="/css/index_style.css">
<title>SOPOOM</title>
</head>

<body>
	<%@include file="/top.jsp"%>
	// 메뉴
	<div class="body">
		<div class="content" align="center">
			<% 
      	// DB 연결
         Connection con = null;   
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         
         try {
            String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
            String uid = "root";
            String pwd = "1234";

            Class.forName("org.mariadb.jdbc.Driver");
            con = DriverManager.getConnection(uri, uid, pwd);
            
         } catch (SQLException ex) {
            out.println("데이터베이스 연결이 실패되었습니다.<br>");
            out.println("SQLException: " + ex.getMessage());
         }
         
         // 가격 ###,###원 형식으로
         DecimalFormat df = new DecimalFormat("###,###");
         
         // 쿼리 작성, 실행
         String sql = "select * from product";
         pstmt = con.prepareStatement(sql);
         rs = pstmt.executeQuery();
         while (rs.next()) {
      %>
			<!-- 상품 띄우기 -->
			<div class="section">
				<a href="product.jsp?id=<%=rs.getString("p_id")%>"> <img
					src="/upload/<%=rs.getString("p_fileName")%>"><br>
				<br> <b><span id="productName"><%=rs.getString("p_name")%></span></b><br>
				<br> <span id="productDescription"><%=rs.getString("p_description")%></span><br>
				<br> <b><span id="productPrice"><%=df.format(rs.getInt("p_unitPrice"))%>원</span></b>
				</a>
			</div>
			<%
         }
         // 쿼리 실행 종료, DB 연결 종료
         if (rs != null)
         rs.close();
         if (pstmt != null)
         pstmt.close();
         if (con != null)
         con.close();
      %>
		</div>
	</div>
	<%@include file="/footer.jsp"%>
</body>
</html>
