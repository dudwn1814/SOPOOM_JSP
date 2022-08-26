<%@page import="com.mini.page.shippingPage"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>

<script>
	function statusModify(ship_id) {
		$("#statusForm").attr("action","/Admin/Shipping/modify_shipping.jsp?ship_id=" + ship_id).submit();
	}
</script>

<title>배송관리 페이지</title>

<style>
body {
	font-family: "나눔고딕", "맑은고딕"
}

h1 {
	font-family: "HY견고딕"
}

.tableDiv {
	text-align: center;
}

.InfoTable {
	border-collapse: collapse;
	border-top: 3px solid #168;
	width: 800px;
	margin-left: auto;
	margin-right: auto;
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

.InfoTable tr td:first-child {
	text-align: center;
}

.InfoTable caption {
	caption-side: top;
}

.bottom_menu {
	margin-top: 20px;
}

.bottom_menu>a:link, .bottom_menu>a:visited {
	background-color: #FFA500;
	color: maroon;
	padding: 15px 25px;
	text-align: center;
	display: inline-block;
	text-decoration: none;
}

.bottom_menu>a:hover, .bottom_menu>a:active {
	background-color: #1E90FF;
	text-decoration: none;
}

<%
	int pageNum = Integer.parseInt(request.getParameter("page"));
	String searchType = request.getParameter("searchType")==null?"":request.getParameter("searchType");
	String keyword = request.getParameter("keyword")==null?"":request.getParameter("keyword");
	
	request.setCharacterEncoding("utf-8");
%>
</style>
<script>

function search(){
	
	var searchType = $("#searchType").val();
	var keyword =  $("#keyword").val();
	location.href = 'shipping.jsp?page=<%=pageNum%>&searchType=' + searchType + '&keyword=' + keyword;
}

</script>
</head>

<body>
	
<%@include file="/top.jsp"%>
<%
	String query =
	"select s.shipID, o.orderID, u.userID, u.username, u.telno, s.address, s.status "
	+ "from shipping s, `order` o, user u "
	+ "where s.orderID = o.orderID AND u.userID = o.userID";
	
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";
%>
<br>
<h1>배송관리</h1>
	<div>
  		<select id="searchType" name="searchType">
  			<option value="orderID">주문번호</option>
  			<option value="userID">주문자ID</option>
      		<option value="status">배송상태</option>
     	</select>
     	
    	<input type="text" id="keyword" name="keyword" />
  		<button type="button" onclick="search()">검색</button>
 	</div>
<br><br>
>>>>>>> 5ab01712e5398b3436d3ef0a29f084bc1c3f1ff2

	<div class="tableDiv">

		<table class="InfoTable" id="InfoTable">
			<tr>
				<th>배송 아이디</th>
				<th>주문번호</th>
				<th>주문자 ID</th>
				<th>주문자 이름</th>
				<th>주문자 전화번호</th>
				<th>배송지</th>
				<th>배송상태</th>
			</tr>

<tbody>
<%
	int postNum = 5; //한 페이지에 보여질 게시물 갯수 
	int displayPost = (pageNum -1)*postNum; //테이블에서 읽어 올 행의 위치
		
	if(searchType.equals("orderID")) 
		query += " and o.orderID like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	else if(searchType.equals("userID"))
		query += " and u.userID like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	else if(searchType.equals("status"))
		query += " and s.status like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";

		query += " order by o.orderID desc limit "+ displayPost + "," + postNum;
	
	
	System.out.println("[게시판 목록 보기 쿼리] : " + query);


try {
	  //DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
	  //con = ds.getConnection();
	
	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(uri, uid, pwd);
	
	  stmt = con.createStatement();
	  rs = stmt.executeQuery(query);
	
	  while (rs.next()) {
%>
<tr id="tr">
	<td><%=rs.getString("shipID")%></td>
	<td><%=rs.getString("orderID")%></td>
	<td><%=rs.getString("userID")%></td>
	<td><%=rs.getString("username")%></td>
	<td><%=rs.getString("telno")%></td>
	<td><%=rs.getString("address")%></td>
	<td>
		<form name="statusForm" id="statusForm" method="post">
			<select id="statusSelect" name="statusSelect"
				class="statusSelect">
				<option value="none" disabled selected><%=rs.getString("status")%></option>
				<option value="배송전">배송전</option>
				<option value="배송중">배송중</option>
				<option value="배송완료">배송완료</option>
				<option value="배송취소">배송취소</option>
			</select>
		</form>
	</td>
	<td><input type="button" name="statusBtn" id="statusBtn"
		value="변경" onclick="statusModify('<%=rs.getString("shipID")%>')" /><td>
	
</tr>

<%
}
	} catch (Exception e) {
		e.printStackTrace();
		}
		
		if (stmt != null) stmt.close();
		if (rs != null) rs.close();
		if (con != null) con.close();
%>
</tbody>
</table>
<br>
<div>

<%
	int listCount = 5; //한 화면에 보여질 페이지 갯수
	int totalCount = 0; //전체 게시물 갯수
	
	try{

		String query_totalCount1 = "select count(*) as totalCount from shipping s";
		String query_totalCount2 = "select count(*) as totalCount from `order` o";
		String query_totalCount3 = "select count(*) as totalCount from user u";
		
		if(searchType.equals("orderID")) 
			query_totalCount2 += " where o.orderID like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
		if(searchType.equals("userID"))
			query_totalCount3 += " where u.userID like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
		if(searchType.equals("status"))
			query_totalCount1 += " where s.status like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
		
		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(uri, uid, pwd);
		  
		stmt = con.createStatement();
		rs = stmt.executeQuery(query_totalCount1);
		rs = stmt.executeQuery(query_totalCount2);
		rs = stmt.executeQuery(query_totalCount3);
		
		while(rs.next()) totalCount = rs.getInt("totalCount");
	}catch(Exception e){
		e.printStackTrace();
	}
	
	shippingPage pageList = new shippingPage();
	
	String pageListView = pageList.getPageList(pageNum, postNum, listCount, totalCount, searchType, keyword);

	if(stmt != null) stmt.close();
	if(rs != null) rs.close();
	if(con != null) con.close();
%>
<%=pageListView %>
		</div>
		<br>


		<div class="bottom_menu">		
			<a href="/Admin/Shipping/shipping.jsp?page=1">목록으로</a>&nbsp;&nbsp;
			<a href="/index.jsp">홈으로</a>&nbsp;&nbsp;
		</div>
	</div>

<%@include file="/footer.jsp"%>

</body>
</html>