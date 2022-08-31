<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>
<title>주문내역</title>
<link rel="stylesheet" href="myOrder.css">

</head>

<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
String uid = "root";
String pwd = "1234";

String userID = request.getParameter("userID");

String query = "select p.p_fileName, s.shipID, p.p_name, o.totalPrice, TO_CHAR(o.orderDate, 'YYYY.MM.DD') as orderDate, s.`status`, o.userID from product p, `order` o, ordereditem i, shipping s "
				+"where s.orderID = o.orderID AND o.orderID = i.orderID AND i.pID = p.p_id AND o.userID = '" + userID + "'";
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
	<h1 class="title">주문내역</h1>
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
				<a href="#"
					class="goods_thumb"> <img
					src="/upload/<%=rs.getString("p_fileName")%>"
					width="60" height="60" alt="상품사진">
				</a>
				<!--N=a:csh.detail-->
				<div class="goods_info">
					<!-- NV_MID: -->
					<a class="goods"
						href="#">
						<p class="name"><%=rs.getString("p_name")%></p>
						<ul class="info">
							<li><span class="blind">상품금액</span> <%=rs.getInt("totalPrice")%>원</li>
							<li class="date"><span class="blind">상품구매날짜</span>
								<%=rs.getString("orderDate")%></li>
						</ul>
					</a> <span class="state _statusName "><%=rs.getString("status")%></span>
					<p class="guide notify">
						<b>결제 및 상세 내역 확인 및 취소요청은 <a href="/index.jsp">SOPOOM</a>에서 확인하실 수 있습니다.
						</b><br>(거래완료는 포인트 적립 완료로 확인 가능 / 세금납부는 취소요청 불가함)
					</p>
				</div>
			</div>
			<div class="seller_item">
				<div class="inner">
					<span class="seller">SOPOOM</span>
					<span class="tel">021234567</span>
					<%
					if(rs.getString("status").equals("주문 완료")) {%>
						<button onclick="orderCancle('<%=rs.getString("shipID")%>')" style="cursor:pointer" class="state_button qna">주문취소</button>
					<%} 
					else if (rs.getString("status").equals("주문취소")){%>
						
					<% }
					else {%>
						<button class="state_button qna" onclick="alert('결제가 진행된 이후에는 취소할 수 없습니다.')">주문취소</button>
					<% }%>
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