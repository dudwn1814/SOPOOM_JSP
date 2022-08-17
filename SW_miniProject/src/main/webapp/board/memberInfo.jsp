<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>

<title>회원 정보</title>

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

.navi_top {	width: 1350px; text-align: right; }
.navi_bottom { text-align: center; }

</style>

</head>

<body>
<div class="tableDiv">
	<h1>회원 정보</h1>
	<table class="InventoryInfoTable">
  		<tr>
   			<th>회원아이디</th>
   			<th>회원명</th>
   			<th>비밀번호</th>
   			<th>전화번호</th>
   			<th>나이</th>
   			<th>주소</th>
  		</tr>

 		<tbody>
			<c:forEach items="${list}" var="list">
 				<tr onMouseover="this.style.background='#46D2D2';" onmouseout="this.style.background='white';">
  					<td>${list.userid}</td>
  					<td>${list.username}</td> 
  					<td>${list.password}</td> 
  					<td>${list.telno}</td> 
  					<td>${list.age}</td>
  					<td>${list.address}</td> 
 				</tr>
			</c:forEach>
		</tbody>

	</table>
</div>
</body>
</html>