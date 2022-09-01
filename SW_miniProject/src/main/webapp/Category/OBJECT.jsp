<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="index_style.css">
<title>Frame</title>
</head>

<body>
	<%@include file="/top.jsp"%>
	<div class="body">
		<div class="content" align="center">
		
			<div class="w3-content slideContent">
			  <img class="mySlides" src="/img/object.jpg">
			</div>
			<hr>
			
			<div class="products">
			
			<%
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
			String uid = "root";
			String pwd = "1234";


			try {
			  Class.forName("org.mariadb.jdbc.Driver");
			  con = DriverManager.getConnection(uri, uid, pwd);

			  DecimalFormat df = new DecimalFormat("###,###");
			  String sql = "select p_id, p_fileName, p_name, p_unitPrice from product where p_category = 'OBJECT'";
			  pstmt = con.prepareStatement(sql);
			  rs = pstmt.executeQuery();

			  while (rs.next()) {
			%>
			<div class="section">
				<a href="product.jsp?id=<%=rs.getString("p_id")%>"> 
					<img src="/upload/<%=rs.getString("p_fileName")%>"><br> 
					<b><span id="productName"><%=rs.getString("p_name")%></span></b><br><br> 
					<b><span id="productPrice"><%=df.format(rs.getInt("p_unitPrice"))%>원</span></b>
				</a>
			</div>
			<%
			}
			if (rs != null)
			rs.close();
			if (pstmt != null)
			pstmt.close();
			if (con != null)
			con.close();
			} catch (SQLException e) {
				out.println("데이터베이스 연결이 실패되었습니다.<br>");
				out.println("SQLException: " + e.getMessage());
			}
			%>
			</div>
		</div>
	</div>

	<%@include file="/footer.jsp"%>
	
</body>
</html>