<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String session_id = (String) session.getAttribute("userID");
String innerTbl;

if (session_id == null){

   innerTbl ="<td align='center'><b><a href=/index.jsp>홈</a></b></td>"
           + "<td align='center'><b><a href=/login.jsp>로그인</a></b></td>"
          + "<td align='center'><b><a href=/join.jsp>회원가입</a></b></td>"
            + "<td align='center'><b><a href=/login.jsp>장바구니</a></b></td>";

}
else if(session_id.equals("admin")){
   innerTbl ="<td align='center'><b><a href=/index.jsp>홈</a></b></td>"
           + "<td align='center'><b><a href=/logout.jsp>로그아웃</a></b></td>"
           + "<td align='center'><b><a href=/Admin/Product/productReg.jsp>상품등록</a></b></td>"
          + "<td align='center'><b><a href=/Admin/Inventory/inventory.jsp>재고관리</a></b></td>"
           + "<td align='center'><b><a href=/Admin/Member/member.jsp>회원관리</a></b></td>"
          + "<td align='center'><b><a href=/Admin/Shipping/shipping.jsp>배송관리</a></b></td>";
}
else {
   
   innerTbl ="<td align='center'><b><a href=/index.jsp>홈</a></b></td>"
           + "<td align='center'><b><a href=/logout.jsp>로그아웃</a></b></td>"
          + "<td align='center'><b><a href=/Mypage/userMain.jsp>마이페이지</a></b></td>"
          + "<td align='center'><b><a href=http://localhost:8080/ShopC/shoppingCart.jsp>장바구니</a></b></td>";

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