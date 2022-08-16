<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>

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

.InfoTable {
      border-collapse: collapse;
      border-top: 3px solid #168;
      width: 800px;  
      margin-left: auto; margin-right: auto;
    }  
    .InfoTable th {
      color: #168;
      background: #f0f6f9;
      text-align: center;
    }
    .InfoTable th, .InfoTable td {
      padding: 10px;
      border: 1px solid #ddd;
    }
    .InfoTable th:first-child, .InfoTable td:first-child {
      border-left: 0;
    }
    .InfoTable th:last-child, .InfoTable td:last-child {
      border-right: 0;
    }
    .InfoTable tr td:first-child{
      text-align: center;
    }
    .InfoTable caption{caption-side: top; }

.navi_top {	width: 1350px; text-align: right; }
.navi_bottom { text-align: center; }

</style>

</head>

<body>

<div class="tableDiv">

	<h1>상품 재고</h1>
	<table class="InfoTable">
  		<tr>
   			<th>상품 ID</th>
   			<th>상품명</th>
   			<th>가격</th>
   			<th>개수</th>
  		</tr>

 		<tbody>
			<c:forEach items="${list}" var="list">
 				<tr onMouseover="this.style.background='#46D2D2';" onmouseout="this.style.background='white';">
  					<td>${list.p_id}</td>
  					<td style="text-align:left;"><a id="hypertext" href="/board/mView?p_id=${list.p_id}" onMouseover='this.style.textDecoration="underline"'  
  							onmouseout="this.style.textDecoration='none';">${list.p_name}</a></td>
  					<td>${list.p_price}</td>
  					<td>${list.p_amount}</td> 
 				</tr>
			</c:forEach>
		</tbody>

	</table>
</div>
</body>
</html>