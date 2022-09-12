<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>
<title>찜목록</title>
<link rel="stylesheet" href="myDibs.css">
</head>

<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
String uid = "root";
String pwd = "1234";

String userID = request.getParameter("userID");

String query = "select p.p_fileName, p.p_name, p.p_unitPrice, p.p_id from product p, dibs d where d.p_id = p.p_id AND d.userID = '" + userID + "'";
%>

<script>
function orderCancle(shipID) { 
	console.log(shipID);
	if(confirm("정말로 취소하시겠습니까?") == true) {
		location.href='modify_myOrder.jsp?ship_id='+shipID+'&statusSelect=주문취소';
	}
}
</script>

<body>

	<%@include file="/top.jsp"%>
	<h1 class="title">찜목록</h1>
	<hr>
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
	<div class="whole">
		<li class="goods_pay_item payorder">
			<div class="goods_item">
			 	<!-- 상품 상세 페이지로 이동 -->
				<a href="/Category/product.jsp?id=<%=rs.getString("p_id")%>" class="goods_thumb"> <img src="/upload/<%=rs.getString("p_fileName")%>" width="60" height="60" alt="상품사진">
				</a>
				<div class="goods_info">
					<a class="goods"
						href="#">
						<p class="name"><%=rs.getString("p_name")%></p>
						<ul class="info">
							<li><span class="blind">상품금액</span> <%=rs.getInt("p_unitPrice")%>원</li>
							<li class="date"><span class="blind"></span></li>
						</ul>
					</a> <span class="state _statusName "></span>
					
				</div>
			</div>
			<div class="seller_item">
				<div class="inner">
					<span class="seller"></span>
					<span class="tel"></span>

				</div>
			</div>
		</li>
		<%
		}
		} catch (Exception e) {
		e.printStackTrace();
		}

		if (stmt != null)
		stmt.close();
		if (rs != null)
		rs.close();
		if (con != null)
		con.close();
		%>
		<br>
	</div>
<br><br>
	<%@include file="/footer.jsp"%>
</body>
</html>