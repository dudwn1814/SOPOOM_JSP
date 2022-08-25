<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
	//자바빈즈-관련 list 코드
%>
<%
	//임의 삽입 
	String deliveryList = "mty";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/배송</title>
</head>
<body>
<!-- 있으면 목록 출력, 없으면 비어있음 표시 -->
<%
	//if(deliveryList.isEmty()) {
	if(deliveryList == "emty"){
%>
	<div class = "emty">
	<a>배송목록이 비어 있습니다.</a>
	</div>
<%
	}else{ %>	
<form> <!-- 자바빈즈, db에서 쇼핑 카트 목록 가져오는 tag 삽입 -->
	<div class="cartlist">
		<table border ="1">
			<tr>
				<th>주문날짜</th>
				<th>주문번호</th>
				<th>상품명 / 수량</th> 
				<th>개당 가격</th>
				<th>전체 가격</th>
			</tr>
			<%
			int i = 0;
			for (;i<10;i++){ /* 임의로 정한 10 */
			%>
			<tr>
				<td>
					<input type="text" name="orderDate">
				</td>
				<td>
					<input type="text" name="orderID">	
				</td>
				<td>
					<input type="text" id="itemName"> /
					<input type="text" id="name<%=i %>">
				</td>
				<td>
					<input type="text" >
				</td>
				<td>
					<input type="text" >
				</td>	
			</tr>
			<%} %>
		</table>
	</div>
</form>
<%} %>
</body>
</html>