<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
String totalPrice = (String)session.getAttribute("totalPrice");
String purchaseCode ="0000";
%>
<style>
#infoTbl{
	border: 2px solid rosybrown;
	margin : auto;
	margin-top : 70px;
	margin-bottom : 20px;
	min-width : 500px;
	padding : 10px;
	vertical-align : center;
}

#infoMsg{
	font-weight : bold;
	font-size : 16pt;
}

.label{
	font-weight : bold;
	color : brown;
}

</style>

<head>
<meta charset="UTF-8">
<title>JSP미니 프로젝트</title>
</head>
<body>
	<%@include file="top.jsp"%>
	<table id='infoTbl'>
	<tr id="infoMsg"><td>주문이 완료되었습니다.</td></tr>
	<tr class="label"><td>주문 번호</td></tr>
	<tr><td><%=purchaseCode %></td></tr>
	<tr class="label"><td>입금 계좌</td></tr>
	<tr><td>새싹은행 000000-00-000000 (예금주 : 소품샵 )</td></tr>
	<tr class="label"><td>결제 금액</td></tr>
	<tr><td><%=totalPrice %> 원</td></tr>
	</table>
	<div align="center">
	<br>
	<input type="button" value="HOME" onClick="location.href='index.jsp'">
	<br>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>