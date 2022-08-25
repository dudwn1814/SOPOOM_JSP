<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String session_id = (String) session.getAttribute("userID");
String innerTbl;

if (session_id == null){
	innerTbl ="<td align='center'><b><a href=/index.jsp>홈</a></b></td>"
	    	 + "<td align='center'><b><a href=login.jsp>로그인</a></b></td>"
			 + "<td align='center'><b><a href=join.jsp>회원가입</a></b></td>"
<<<<<<< HEAD:SW_miniProject/src/main/webapp/top.jsp
			 + "<td align='center'><b><a href=products.jsp>전체상품</a></b></td>"
=======
			 + "<td align='center'><b><a href=''>전체상품</a></b></td>"
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/top.jsp
	         + "<td align='center'><b><a href=login.jsp>장바구니</a></b></td>";

}
else if(session_id.equals("admin")){
<<<<<<< HEAD:SW_miniProject/src/main/webapp/top.jsp

	innerTbl ="<td align='center'><b><a href=/index.jsp>홈</a></b></td>"
	    	 + "<td align='center'><b><a href=logout.jsp>로그아웃</a></b></td>"
			 + "<td align='center'><b><a href=products.jsp>전체상품</a></b></td>"
=======
	innerTbl ="<td align='center'><b><a href=/index.jsp>홈</a></b></td>"
	    	 + "<td align='center'><b><a href=logout.jsp>로그아웃</a></b></td>"
			 + "<td align='center'><b><a href=''>전체상품</a></b></td>"
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/top.jsp
	 		 + "<td align='center'><b><a href='/Admin/Product/productReg'>상품등록</a></b></td>"
			 + "<td align='center'><b><a href='/Admin/Inventory/inventory'>재고관리</a></b></td>"
	 		 + "<td align='center'><b><a href='/Admin/Member/member'>회원관리</a></b></td>"
			 + "<td align='center'><b><a href='/Admin/Shipping/shipping'>배송관리</a></b></td>";
}
else {
	
	innerTbl ="<td align='center'><b><a href=/index.jsp>홈</a></b></td>"
	    	 + "<td align='center'><b><a href=logout.jsp>로그아웃</a></b></td>"
<<<<<<< HEAD:SW_miniProject/src/main/webapp/top.jsp
			 + "<td align='center'><b><a href=products.jsp>전체상품</a></b></td>"
			 + "<td align='center'><b><a href=''>마이페이지</a></b></td>"
			 + "<td align='center'><b><a href=''>장바구니</a></b></td>";
=======
			 + "<td align='center'><b><a href=''>전체상품</a></b></td>"
			 + "<td align='center'><b><a href='/myPage/userMain.jsp'>마이페이지</a></b></td>"
			 + "<td align='center'><b><a href='/shopC/shoppingCart.jsp'>장바구니</a></b></td>";
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/top.jsp

}
%>
<style>
  header{
 	min-width : 700px;
  }
  a { text-decoration: none; color: black; }
  a:visited { text-decoration: none; }
  a:hover { text-decoration: none;}
  a:focus { text-decoration: none; }
  a:hover, a:active { text-decoration: none; }
  td{ text-align: center; padding:5px;}
</style>
<header>
<table width="75%" align="center" bgcolor="white">
	<tr>
		<%=innerTbl %>
	</tr>
</table>
</header>