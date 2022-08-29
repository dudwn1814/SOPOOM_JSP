<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
String totalPrice = (String)session.getAttribute("strTotal");
String orderCode = (String)session.getAttribute("orderCode");

%>
<style>
.wrap{
	margin : auto;
	width : 700px;
	min-width : 700px
}

h3{
	text-align :left;
	margin : 30px 5px;
}

.resultBox{
	border: 1px solid #BFBFBF;
	margin : auto;
	margin-top : 40px;
	margin-bottom : 70px;
	min-width : 600px;
	padding : 50px;

}


#infoMsg{
	font-weight : bold;
	font-size : 16pt;
	text-align : center;
	margin-top : 30px;
	margin-bottom : 50px;
}


.row{
	margin : 24px;
}

.label{
	font-weight : bold;
	color : #313131;
	margin-right : 20px;
	}

.button{
	padding: 5px;
	margin : auto;
	cursor : pointer;
	border-radius : 50px;
	width : 100%;
	max-width : 240px;
	min-width : 160px;
	height : 54px ! important;
	min-height : 54px;
	font-size : 14px !important;
	font-weight : 700;
}

#btn_home{
	color: #FFFFFF !important;
    background-color: #313131 !important;
    border-color: #313131 !important;
    border-width : 1px;
    transition-duration: 0.4s;
}

#btn_home:hover{
 	opacity : 0.7;
}

</style>

<head>
<meta charset="UTF-8">
<title>JSP미니 프로젝트</title>
</head>
<body>
	<%@include file="/top.jsp"%>
	<div class="wrap">
	<h3>주문 완료</h3>
	<div class="resultBox">
	<div id="infoMsg">주문이 성공적으로 완료되었습니다.</div>
	<div class="row"><span class="label">주문 번호</span> <%=orderCode %></div>
	<div class="row"><span class="label">입금 계좌</span> 새싹은행 000000-00-000000 (예금주 : 소품샵)</div>
	<div class="row"><span class="label">결제 금액</span> <%=totalPrice %> 원</div>
	</div>
	<div align="center">
	<br>
	<input type="button" class="button" id="btn_home" value="HOME" onClick="location.href='/index.jsp'">
	<br>
	</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>