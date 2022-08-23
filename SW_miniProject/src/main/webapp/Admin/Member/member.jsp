<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>

<title>회원 목록</title>

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
<%
	int idx = 1;
%>

<div class="tableDiv">
	<h1>회원 목록</h1>
	<table class="InventoryInfoTable">
  		<tr>
  			<th>순서</th>
   			<th>회원아이디</th>
   			<th>회원명</th>
   			<th>전화번호</th>
  		</tr>

 		<tbody>
			<c:forEach items="${list}" var="list">
 				<tr onMouseover="this.style.background='#46D2D2';" onmouseout="this.style.background='white';">
 					<td><%=idx++ %></td>
  					<td style="text-align:center;"><a id="hypertext" href="/Admin/Member/memberInfo?userid=${list.userid}" onMouseover='this.style.textDecoration="underline"'  
  							onmouseout="this.style.textDecoration='none';">${list.userid}</a></td>
   					<td>${list.username}</td>
  					<td>${list.telno}</td> 
 				</tr>				
			</c:forEach>
		</tbody>

	</table>
</div>
<%@include file="/footer.jsp"%>
</body>
</html>