<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String session_id = (String) session.getAttribute("userID");
String innerMenu, innerUser, innerCategory;

if (session_id == null){
	innerMenu = "<li class='menuItem' align='center'><a href=/Landing/index.jsp>[HOME]</a></li>"
	+"<li class='menuItem dropdown-btn' id='dropdown-btn' style = 'text-align: center' margin-left='0'><a style ='margin-left: 20px' href='#' >[Category]</a>"
    +"<div class='dropdown-container' id='dropdown-container'>"
        +"<ul class='dropdown-class' style='margin-left: 0px;'>"
            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/FRAME.jsp'>[FRAME]</a></li>"
            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/OBJECT.jsp'>[OBJECT]</a></li>"
            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/HOMEWARE.jsp'>[HOMEWARE]</a></li>"
            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/TEXTILE.jsp'>[TEXTILE]</a></li>"
        +"</ul>"
    +"</div>"
    +"</li>";

	innerUser = "<li class='userItem' align='center'><a href=/Login/login.jsp><span class='material-symbols-outlined'>login</span></a></li>"
          + "<li class='userItem' align='center'><a href=/Login/join.jsp><span class='material-symbols-outlined'>person_add_alt</span></a></li>"
            + "<li class='userItem' align='center'><a href=/Login/login.jsp><span class='material-symbols-outlined'>shopping_cart</span></a></li>";

}
else if(session_id.equals("admin")){
	innerMenu = "<li class='menuItem' align='center'><a href=/Landing/index.jsp>[HOME]</a></li>"
			+"<li class='menuItem dropdown-btn' id='dropdown-btn' style = 'text-align: center' margin-left='0'><a style ='margin-left: 20px' href='#' >[Category]</a>"
		    +"<div class='dropdown-container' id='dropdown-container'>"
		        +"<ul class='dropdown-class' style='margin-left: 0px;'>"
		            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/FRAME.jsp'>[FRAME]</a></li>"
		            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/OBJECT.jsp'>[OBJECT]</a></li>"
		            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/HOMEWARE.jsp'>[HOMEWARE]</a></li>"
		            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/TEXTILE.jsp'>[TEXTILE]</a></li>"
		        +"</ul>"
		    +"</div>"
		    +"</li>"
	           + "<li class='menuItem' align='center'><a href=/Admin/Product/productReg.jsp>상품등록</a></li>"
	           + "<li class='menuItem' align='center'><a href=/Admin/Inventory/inventory.jsp?page=1>재고관리</a></li>"
	           + "<li class='menuItem' align='center'><a href=/Admin/Member/member.jsp?page=1>회원관리</a></li>"
	           + "<li class='menuItem' align='center'><a href=/Admin/Shipping/shipping.jsp?page=1>배송관리</a></li>";

   	innerUser = "<li class='userItem' align='center'><a href=/Login/logout.jsp><span class='material-symbols-outlined'>logout</span></a></li>"
	          + "<li class='userItem' align='center'><a href=/Mypage/userMain.jsp><span class='material-symbols-outlined'>person</span></a></li>"
	          + "<li class='userItem' align='center'><a href=/ShopC/shoppingCart.jsp><span class='material-symbols-outlined'>shopping_cart</span></a></li>";

}
else {
	innerMenu = "<li class='menuItem' align='center'><a href=/Landing/index.jsp>[HOME]</a></li>"
			+"<li class='menuItem dropdown-btn' id='dropdown-btn' style = 'text-align: center' margin-left='0'><a style ='margin-left: 20px' href='#' >[Category]</a>"
		    +"<div class='dropdown-container' id='dropdown-container'>"
		        +"<ul class='dropdown-class' style='margin-left: 0px;'>"
		            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/FRAME.jsp'>[FRAME]</a></li>"
		            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/OBJECT.jsp'>[OBJECT]</a></li>"
		            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/HOMEWARE.jsp'>[HOMEWARE]</a></li>"
		            +"<li class='menuItem dropdown'><a class='dropdown-text' href='/Category/TEXTILE.jsp'>[TEXTILE]</a></li>"
		        +"</ul>"
		    +"</div>"
		    +"</li>";
   innerUser =  "<li class='userItem' align='center'><a href=/Login/logout.jsp><span class='material-symbols-outlined'>logout</span></a></li>"
          + "<li class='userItem' align='center'><a href=/Mypage/userMain.jsp><span class='material-symbols-outlined'>person</span></a></li>"
          + "<li class='userItem' align='center'><a href=/ShopC/shoppingCart.jsp><span class='material-symbols-outlined'>shopping_cart</span></a></li>";
}
%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<style>
@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.5/dist/web/static/pretendard.css");

*{
	font-family: Pretendard;
}

 header{
  	position: fixed;
  	top: 0;
  	left: 0;
  	right: 0;
 	width : 100%;
    min-width : 700px;
    max-width : 1240px;
    display : flex;
    padding : 10px 20px;
    align-items : center;
    margin : auto;
    background-color: white;
    z-index: 100;
 }
 
 .menu-backgroud-color{
 	background-color: #FFFFFF !important;
	z-index: 1000;
 }
 
 .hiddin-box{
  	top: 0;
  	left: 0;
  	right: 0;
 	width : 100%;
    min-width : 700px;
    max-width : 1200px;
    display : flex;
    padding : 50px 20px;
 }
 
 li a { text-decoration: none;}
 li a:visited { text-decoration: none; }
 li a:focus { text-decoration: none; }


.center, .right, .left{
  	display : flex;
 }

 ul{
 	list-style : none;
 	margin-left : 25px;
 }

 ul li{
 	float : left;
 }

 .menu, .user{
 	vertical-align : middle;
 	align-items : center;

 }

 .user{
 	text-align : right;
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
 	margin-left : 20px;
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
 	margin : 0px 6px;
 }

 .userItem a:hover{
 	color : #313131;
 }

.material-symbols-outlined {
  font-variation-settings:
  'FILL' 1,
  'wght' 400,
  'GRAD' 0,
  'opsz' 48
}

.dropdown:not(ul) {
        float : unset;
		margin: 10px;
        list-style : none;
        margin-block-start: 0em;
        margin-block-end: 0em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
        padding-inline-start: 0px;
     }

    .dropdown:not(header) {
        padding: 0%;
		text-align: left;
		padding-bottom: 8px;
     }

    .dropdown-container:not(ul) {

        z-index: 1000;
        text-align: center !important;
		border: 1px solid rgb(242,242,242) !important ;
		width: auto;
    	height: auto;
    	z-index: 1000;
    	margin-left: 0px;
    	/* display: none; */
    	visibility:hidden;
    	-webkit-transition: opacity 0.4s,visibility 0.4s;
    	-moz-transition: opacity 0.4s,visibility 0.4s;
    	-ms-transition: opacity 0.4s,visibility 0.4s;
    	-o-transition: opacity 0.4s,visibility 0.4s;
    	transition: opacity 0.4s,visibility 0.4s;
		position: fixed;
		margin-top: 10px;

    }

     .dropdown-text:not(a){
        margin-left : 0px;
		text-align: right;
     }

	 .dropdown-text:not(.menuItem){
        margin-left : 0px;
     }


	 .dropdown-btn:not(.menuItem){
        margin-left : 0px;
     }

	.dropdown-class{
	position: relative;
    width: auto;
    height: auto;
    background-color: rgb(255,255,255);
    z-index: 1000;
    padding: 0.9em;
	}

	.dropdown-btn:hover .dropdown-container {
	/* display: block; */
	visibility:visible;
	
	}
	
	

</style>

<header>
	<div class = "menu-backgroud-color"></div>
	<div class="left">
		<a href="/Landing/index.jsp"> <img class="logo"
			src="/img/logo.png" alt="logo" width="100">
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
<div class="hiddin-box"></div>