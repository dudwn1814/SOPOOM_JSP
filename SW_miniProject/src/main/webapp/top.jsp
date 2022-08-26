<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String session_id = (String) session.getAttribute("userID");
String innerMenu, innerUser;

if (session_id == null){
	innerMenu = "<li class='menuItem' align='center'><a href=/index.jsp>[HOME]</a></li>";
	innerUser = "<li class='userItem' align='center'><a href=login.jsp>로그인</a></li>"
          + "<li class='userItem' align='center'><a href=join.jsp>회원가입</a></li>"
            + "<li class='userItem' align='center'><a href=login.jsp>장바구니</a></li>";

}
else if(session_id.equals("admin")){
	innerMenu = "<li class='menuItem' align='center'><a href=/index.jsp>[HOME]</a></li>"
	           + "<li class='menuItem' align='center'><a href='/Admin/Product/productReg.jsp'>상품등록</a></li>"
	           + "<li class='menuItem' align='center'><a href='/Admin/Inventory/inventory.jsp'>재고관리</a></li>"
	           + "<li class='menuItem' align='center'><a href='/Admin/Member/member.jsp'>회원관리</a></li>"
	           + "<li class='menuItem' align='center'><a href='/Admin/Shipping/shipping.jsp'>배송관리</a></li>";
	           
   	innerUser = "<li class='userItem' align='center'><a href=logout.jsp>로그아웃</a></li>"
	          + "<li class='userItem' align='center'><a href=''>마이페이지</a></li>"
	          + "<li class='userItem' align='center'><a href=''>장바구니</a></li>";

}
else {
	innerMenu = "<li class='menuItem' align='center'><a href=/index.jsp>[HOME]</a></li>";
   innerUser =  "<li class='userItem' align='center'><a href=logout.jsp>로그아웃</a></li>"
          + "<li class='userItem' align='center'><a href=''>마이페이지</a></li>"
          + "<li class='userItem' align='center'><a href=''>장바구니</a></li>";

}
%>
<style>
 header{
 	width : 100%;
    min-width : 700px;
    max-width : 1200px;
    display : flex;
    padding : 0px 20px;
    align-items : center;
    margin : auto;
 }
 li a { text-decoration: none;}
 li a:visited { text-decoration: none; }
 li a:focus { text-decoration: none; }

 
.center, .right, .left{
  	display : flex;
 }
 
 ul{
 	list-style : none;
 	display : inline-block;
 }
 
 ul li{
 	float : left;
 }
 
 .menu, .user{
 	vertical-align : middle;
 	align-items : center;
 	
 }
 
 .menu{
 	padding-right : 16px;
 }
 
 .user{
 	text-align : right;
 	margin-left : auto;
 }
 
 .left, .center, .right{
 	flex : 1;
 }
 
 .right{
 	text-align : right;
 	margin-right : auto;
 	min-width : fit-content;
 }
 
 .menuItem, .userItem{
 	margin-left : 10px;
 	cursor:pointer
 }
 
 .menuItem a{
 	font-size : 16px;
 	font-weight : 600;
 	color : #919191;
 }
 
 .menuItem a:hover{
 	color : #313131;
 }
 
 
 .userItem a{
 	font-weight : 600;
 	color : #919191;
 }
 
 .userItem a:hover{
 	color : #313131;
 }
 
</style>
<header>
<div class="left">
<a href="/index.jsp">
<img class="logo" src="/img/logo.png" alt="logo" width="100">
</a>
</div>
<div class="center"></div>
<div class="right">
<div class="menu">
	<ul class="menuList">
	<%=innerMenu %>
	</ul>
</div>
<div class="user">
	<ul class="userList">
	<%= innerUser %>
	</ul>
</div>
</div>
</header>