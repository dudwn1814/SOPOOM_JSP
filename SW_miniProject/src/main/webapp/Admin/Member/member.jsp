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

    .bottom_menu { margin-top: 20px; }

	.bottom_menu > a:link, .bottom_menu > a:visited {
				background-color: #FFA500;
				color: maroon;
				padding: 15px 25px;
				text-align: center;	
				display: inline-block;
				text-decoration : none; 
	}
	.bottom_menu > a:hover, .bottom_menu > a:active { 
		background-color: #1E90FF;
		text-decoration : none; 
}

</style>

</head>

<body>
	<%@include file="/top.jsp"%>
<%
	int idx = 1;
%>

<div class="tableDiv">
	<h1>회원 목록</h1>
	<table class="InfoTable">
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
	
	<div class="bottom_menu">
	<a href="/index.jsp">홈으로</a>&nbsp;&nbsp;
	</div>
</div>
<%@include file="/footer.jsp"%>
</body>
</html>