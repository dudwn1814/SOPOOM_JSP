<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>

<head>
<meta charset="UTF-8">

<title>상품 상세 정보</title>

<link rel="stylesheet" href="/css/product_style.css">



<script type="text/javascript">

   function purchaseNow2() {
         document.addForm.submit();
   }
   
   function addToCart() {
      if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
         document.addForm.submit();
      } else {
         document.addForm.reset();
      }
   }
   
   function addToDibs(uid) {
	    console.log("check");
	    document.getElementById("emptyHeart").src = "/img/afterDibs.png";
	    //작동되게 수정
	    if (confirm("찜목록으로 이동하시겠습니까?")) {
	    	document.dibsAddForm.submit();
	    } else {
	    document.dibsAddForm.submit(); 
	    }
	}
   
   //새로고침 안해도 바로 반영되게 수정!
   function deleteToDibs() {
	   console.log("uncheck");
	   document.getElementById("fullHeart").src = "/img/beforeDibs.png";
	   document.dibsDeleteForm.submit();
	}

</script>

</head>

<body>
	<%
	request.setCharacterEncoding("utf-8");
	DecimalFormat df = new DecimalFormat("###,###");
	String id = (String) request.getParameter("id");
	//게시물 내용 보기
	String query = "select * from product where p_id = '" + id + "'";

	String query_dibs = "select count(*) as count_dibs from dibs where p_id = '" + id + "'";

	// System.out.println("[상품 보기 ] : " + query);
	Connection con = null;
	Statement stmt = null;
	Statement stmt_dibs = null;
	ResultSet rs = null;
	ResultSet rs_dibs = null;
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";

	String p_name = "";
	int p_unitPrice = 0;
	String p_description = "";
	String p_category = "";
	String p_manufacturer = "";
	String p_fileName = "";
	// System.out.println(p_unitPrice);
	%>

	<jsp:include page="/top.jsp" />
	<%
	try {
	  // DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
	  // con = ds.getConnection();
	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(url, uid, pwd);
	  stmt = con.createStatement();
	  stmt_dibs = con.createStatement();
	  rs = stmt.executeQuery(query);
	  rs_dibs = stmt.executeQuery(query_dibs);
	  while (rs.next()) {
	%>

	<div class="content" align="center">
		<div class="product_view" align="center">
			<h2 style="display:inline-block"><%=rs.getString("p_name")%></h2>
			<div style="display:inline-block">
			<%
				if (rs_dibs.next()) {
				  if(rs_dibs.getInt("count_dibs") == 0) {
					%>
					<form style="display:inline-block; margin-left:20px;" name="dibsAddForm" id="dibsAddForm" class="btns" method="post"
						action="/ShopC/addDibs.jsp?id=<%=id%>">
						<img style="display:inline-block; margin-bottom:-15px;" id="emptyHeart" src="/img/beforeDibs.png" onclick="addToDibs('<%=id%>')"/>
					</form>
					<%
					} else {
					%>
					<form style="display:inline-block; margin-left:20px;" name="dibsDeleteForm" id="dibsDeleteForm" class="btns" method="post"
						action="/ShopC/deleteDibs.jsp?id=<%=id%>">
						<img style="display:inline-block; margin-bottom:-15px;" id="fullHeart" src="/img/afterDibs.png"  onclick="deleteToDibs()"/>
					</form>
					<%
					}
				} 
				%>
			</div>
			<hr>
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
						<td><%=rs.getString("p_description")%></td>
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
				<form name="addForm" id="addForm" class="btns" method="post"
					action="/ShopC/addCart.jsp?id=<%=id%>">
					<a href="/Purchase/purchase_now.jsp?id=<%=id%>" class="btn_order"
						onclick="purchaseNow2()">상품주문</a> <INPUT type="hidden"
						ID="productID" NAME="Submit" VALUE='<%=rs.getString("p_id")%>'>
					<a href="/ShopC/addCart.jsp?id=<%=id%>" class="btn_bucket"
						onclick="addToCart()">장바구니</a>
				</form>
			</div>
		</div>
	</div>
	<%
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