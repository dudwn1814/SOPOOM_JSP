<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>

<title>회원 정보</title>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }

.tableDiv {
	text-align: center;
}

<<<<<<< HEAD:SW_miniProject/src/main/webapp/Admin/Member/memberInfo.jsp
.InfoTable {
=======
.InventoryInfoTable {
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/Admin/Member/memberInfo.jsp
      border-collapse: collapse;
      border-top: 3px solid #168;
      width: 800px;  
      margin-left: auto; margin-right: auto;
    }  
<<<<<<< HEAD:SW_miniProject/src/main/webapp/Admin/Member/memberInfo.jsp
    .InfoTable th {
=======
    .InventoryInfoTable th {
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/Admin/Member/memberInfo.jsp
      color: #168;
      background: #f0f6f9;
      text-align: center;
    }
<<<<<<< HEAD:SW_miniProject/src/main/webapp/Admin/Member/memberInfo.jsp
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
=======
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
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/Admin/Member/memberInfo.jsp
    
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
<<<<<<< HEAD:SW_miniProject/src/main/webapp/Admin/Member/memberInfo.jsp
<%String userID = request.getParameter("userid"); %>

<div class="tableDiv">
	<h1>회원 정보</h1>
	<table class="InfoTable">
=======
<%String userID = request.getParameter("userID"); %>

<div class="tableDiv">
	<h1>회원 정보</h1>
	<table class="InventoryInfoTable">
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/Admin/Member/memberInfo.jsp
  		<tr>
   			<th>회원아이디</th>
   			<th>회원명</th>
   			<th>비밀번호</th>
   			<th>전화번호</th>
<<<<<<< HEAD:SW_miniProject/src/main/webapp/Admin/Member/memberInfo.jsp
   			<th>이메일</th>
   			<th>우편번호</th>
   			<th>주소</th>
   			<th>세부주소</th>
   			<th>추가주소</th>
   			
=======
   			<th>주소</th>
   			<th>세부주소</th>
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/Admin/Member/memberInfo.jsp
  		</tr>

 		<tbody>
			<c:forEach items="${list}" var="list">			
			<tr>
  					<td>${list.userid}</td>
  					<td>${list.username}</td> 
  					<td>${list.password}</td> 
  					<td>${list.telno}</td> 
<<<<<<< HEAD:SW_miniProject/src/main/webapp/Admin/Member/memberInfo.jsp
  					<td>${list.email}</td> 
  					<td>${list.postcode}</td> 
  					<td>${list.address}</td>
  					<td>${list.detailAddress}</td> 
  					<td>${list.extraAddress}</td> 
  					
=======
  					<td>${list.address}</td>
  					<td>${list.detailAddress}</td> 
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/Admin/Member/memberInfo.jsp
 				</tr>
			</c:forEach>
		</tbody>

	</table>


<div class="bottom_menu">
<<<<<<< HEAD:SW_miniProject/src/main/webapp/Admin/Member/memberInfo.jsp
	<a href="member">목록으로</a>&nbsp;&nbsp;
	<a href="edit_memberInfo.jsp?userid=<%=userID%>">회원정보 수정</a>&nbsp;&nbsp;
=======
	<a href="edit_memberInfo.jsp">회원정보 수정</a>&nbsp;&nbsp;
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/Admin/Member/memberInfo.jsp
	<a href="delete_memberInfo.jsp?userid=<%=userID%>">회원 강제 탈퇴</a>&nbsp;&nbsp;
</div>
</div>
	<%@include file="/footer.jsp"%>
</body>
</html>