<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<title>게시물 목록</title>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }
a:link { color: black; }
a:visited { color: black; }
a:hover { color: red; }
a:active { color: red; }
#hypertext { text-decoration-line: none; cursor: hand; }

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
	<%@include file="/top.jsp"%>
<div class="tableDiv">
	<h1>상품 재고</h1>
	<table class="InventoryInfoTable">
  		<tr>
   			<th>상품 ID</th>
   			<th>상품명</th>
   			<th>가격</th>
   			<th>수량</th>
  		</tr>

 		<tbody>
			<c:forEach items="${list}" var="list">
 				<tr onMouseover="this.style.background='#46D2D2';" onmouseout="this.style.background='white';">
  					<td>${list.p_id}</td>
  					<td style="text-align:center;"><a id="hypertext" href="/Admin/Inventory/inventoryOrder?p_id=${list.p_id}" onMouseover='this.style.textDecoration="underline"'  
  							onmouseout="this.style.textDecoration='none';">${list.p_name}</a></td>
  					<td style="text-align:right;">${list.p_price} \</td>
  					<td>${list.p_amount}</td> 
 				</tr>
			</c:forEach>
		</tbody>

	</table>
</div>
<%@include file="/footer.jsp"%>
</body>
</html>