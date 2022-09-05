<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>

<html>

<head>
<meta charset="UTF-8">

<title>상품 상세 정보</title>

<link rel="stylesheet" href="/css/product_style.css">

<script type="text/javascript">
   function addToCart() {
      if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
         document.addForm.submit();
      } else {
         document.addForm.reset();
      }
   }
   
   function purchaseNow{
	   document.addForm.submit();
   }
</script>

</head>

<body>


	<%
   request.setCharacterEncoding("utf-8"); // 한글로
   DecimalFormat df = new DecimalFormat("###,###"); // 가격 ###,###원 형식으로
   String id = (String) request.getParameter("id"); // index.jsp에서 product id값 가져오기
	
	// product id로 DB에서 정보 가져오는 쿼리문
   String query = "select * from product where p_id = '" + id + "'"; 
   
   // 변수 초기화
   String p_name = "";
   String p_description = "";
   String p_category = "";
   String p_manufacturer = "";
   String p_fileName = "";
   int p_unitPrice = 0;
   
   String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
   String uid = "root";
   String pwd = "1234";
   
   Connection con = null;
   Statement stmt = null;
   ResultSet rs = null;
   %>

	<jsp:include page="/top.jsp" />
	<% 
   		// DB 연결
      try {
      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(url, uid, pwd);
      stmt = con.createStatement();
      rs = stmt.executeQuery(query);
      
      while(rs.next()) {
    	  
   %>
	<!-- 상품 보여주기 -->
	<div class="content" align="center">
		<div class="product_view" align="center">
			<h2><%=rs.getString("p_name")%></h2>
			<table>
				<colgroup>
					<col style="width: 180px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>상품 코드</th>
						<td><%=rs.getString("p_id")%></td>
					</tr>
					<tr>
						<th>제조사/공급사</th>
						<td><%=rs.getString("p_manufacturer")%></td>
					</tr>
					<tr>
						<th>설명</th>					 	
						<td id="description"><%=rs.getString("p_description").replaceAll("(\r\n|\r|\n|\n\r)","<br>")%></td>
					</tr>
					<tr>
						<th>배송비</th>					 	
						<td>2,000원<br>제주, 도서 산간 지역 3,000원</td>
					</tr>
					<tr>
						<th>판매가</th>
						<td class="price"><b><%=df.format(rs.getInt("p_unitPrice"))%></b>원</td>
					</tr>
				</tbody>
			</table>
			<div class="img">
				<img src="/upload/<%=rs.getString("p_fileName")%>" alt="" />
			</div>
			<div>
			<!-- 상품주문 / 장바구니 페이지로 product id 옮기기 -->
				<form name="addForm" id="addForm" class="btns" method="post"
					action="/ShopC/addCart.jsp?id=<%=id%>">
					<a href="/Purchase/purchase_now.jsp?id=<%=id%>" class="btn_order"
						onclick="purchaseNow()">상품주문</a> <INPUT type="hidden"
						ID="productID" NAME="Submit" VALUE='<%=rs.getString("p_id")%>'>
					<a href="/ShopC/addCart.jsp?id=<%=id%>" class="btn_bucket"
						onclick="addToCart()">장바구니</a>
				</form>
			</div>
		</div>
	</div>
	<%
	// 쿼리문, DB 연결 종료
      }
      if (stmt != null) {
      stmt.close();
      }
      if (con != null) {
      con.close();
      }
      if (rs != null) {
      rs.close();
      }
      } catch (Exception e) {
      e.printStackTrace();
      }
      %>
	<jsp:include page="/footer.jsp" />
</body>
</html>