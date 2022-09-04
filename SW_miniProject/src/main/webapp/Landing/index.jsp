<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">

<head>
<link rel="stylesheet" href="/css/index_style.css">
<title>소품샵프로젝트</title>
</head>

<body>
	<%@include file="/top.jsp"%>
	<div class="body">
		<div class="content" align="center">
		
			<div class="w3-content slideContent">
			  <img class="mySlides" src="/upload/4a5dc924376440bfa6a3dc8736b54360.jpg" style="width:100%">
			  <img class="mySlides" src="/upload/6b3897dcd942434ba912770a09880022.jpg" style="width:100%">
			  <img class="mySlides"src="/upload/94b38e539477423cb8f3080f814956d3.jpg" style="width:100%">
			</div>
			
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
			  String sql = "select p_id, p_fileName, p_name, p_unitPrice from product";
			  pstmt = con.prepareStatement(sql);
			  rs = pstmt.executeQuery();

			  while (rs.next()) {
			%>
			<div class="section">
				<a href="/Category/product.jsp?id=<%=rs.getString("p_id")%>"> 
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
	
	<script>
		var myIndex = 0;
		carousel();
		
		function carousel() {
		  var i;
		  var x = document.getElementsByClassName("mySlides");
		  for (i = 0; i < x.length; i++) {
		    x[i].setAttribute("style", "display:none");
		  }
		  myIndex++;
		  if (myIndex > x.length) {myIndex = 1}    
		  x[myIndex-1].setAttribute("style", "display:block"); 
		  setTimeout(carousel, 2000); // Change image every 2 seconds
		}
</script>
	
</body>

</html>