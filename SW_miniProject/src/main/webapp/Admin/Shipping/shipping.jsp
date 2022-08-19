<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>

<title>배송관리 페이지</title>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }

.tableDiv {
	text-align: center;
}

.InventoryInfoTable {
      border-collapse: collapse;
      border-top: 3px solid #168;
      width: 800px;  
      margin-left: auto; margin-right: auto;
    }  
    .InventoryInfoTable th {
      color: #168;
      background: #f0f6f9;
      text-align: center;
    }
    .InventoryInfoTable th, .InventoryInfoTable td {
      padding: 10px;
      border: 1px solid #ddd;
    }
    .InventoryInfoTable th:first-child, .InventoryInfoTable td:first-child {
      border-left: 0;
    }
    .InventoryInfoTable th:last-child, .InventoryInfoTable td:last-child {
      border-right: 0;
    }
    .InventoryInfoTable tr td:first-child{
      text-align: center;
    }
    .InventoryInfoTable caption{caption-side: top; }


</style>

</head>

<body>
<div class="tableDiv">
	<h1>배송관리</h1>
	<table class="InventoryInfoTable">
  		<tr>
  			<th>주문상품 아이디</th>
   			<th>주문자 ID</th>
   			<th>주문자 이름</th>
   			<th>주문자 전화번호</th>
   			<th>주문자 주소</th>
   			<th>배송상태</th>
  		</tr>

 		<tbody>
			<c:forEach items="${list}" var="list">
 				<tr>
  					<td>${list.p_id}</td>
					<td>${list.u_id}</td>
  					<td>${list.username}</td>
  					<td>${list.telno}</td> 
  					<td>${list.address}</td> 
  					<td>${list.status}</td> 
 				</tr>
			</c:forEach>
		</tbody>

	</table>
</div>
</body>
</html>