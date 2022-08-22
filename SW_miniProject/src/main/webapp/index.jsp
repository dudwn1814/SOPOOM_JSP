<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<title>미니프로젝트</title>
</head>
<body>
<%@include file="top.jsp"%>
<h1>미니프로젝트</h1><br><br>
<h3>관리자 페이지</h3>
<ul>
	<li><a href="/Admin/Inventory/inventory">재고관리 (상품이름 누르면 발주 페이지로 이동)</a></li>
	<li><a href="/Admin/Product/productReg">상품등록</a></li>
	<li><a href="/Admin/Member/member">회원관리</a></li>
	<li><a href="/Admin/Shipping/shipping">배송관리</a></li>
</ul>
<hr><br>
<%@include file="footer.jsp"%>
</body>
</html>