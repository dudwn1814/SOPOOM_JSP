<%@page import="com.mini.page.shippingPage"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

<title>배송관리</title>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="shipping.css">
</head>

<body>
	
<%@include file="/top.jsp"%>
<%
	int pageNum = Integer.parseInt(request.getParameter("page"));
	String searchType = request.getParameter("searchType")==null?"":request.getParameter("searchType");
	String keyword = request.getParameter("keyword")==null?"":request.getParameter("keyword");
	
	request.setCharacterEncoding("utf-8");
%>

<script>

function search(){
	
	var searchType = $("#searchType").val();
	var keyword =  $("#keyword").val();
	location.href = 'shipping.jsp?page=<%=pageNum%>&searchType=' + searchType + '&keyword=' + keyword;
}

</script>

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
<h1 class="shipTitle">배송관리</h1>
<hr>
 
<div class="tableDiv">

	<table class="InfoTable" id="InfoTable">
		<tr>
			<th>배송번호</th>
			<th>주문번호</th>
			<th>주문자 ID</th>
			<th>주문자 이름</th>
			<th>주문자 전화번호</th>
			<th>배송지</th>
			<th>배송상태</th>
			<th>상태변경</th>
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
				<option value="결제완료">결제완료</option>
				<option value="배송전">배송전</option>
				<option value="배송중">배송중</option>
				<option value="배송완료">배송완료</option>
				<option value="주문취소">주문취소</option>
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

		String query_totalCount = "SELECT COUNT(*) as totalCount FROM shipping s, `order` o, user u WHERE s.orderID=o.orderID AND u.userID=o.userID";
		
		
		if(searchType.equals("orderID")) 
			query_totalCount += " and o.orderID like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
		if(searchType.equals("userID"))
			query_totalCount += " and u.userID like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
		if(searchType.equals("status"))
			query_totalCount += " and s.status like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
		
		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(uri, uid, pwd);
		  
		stmt = con.createStatement();
		rs = stmt.executeQuery(query_totalCount);
		
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
	</div>
</div>
<br>
<div class="search">
 		<select id="searchType" name="searchType">
 			<option value="orderID">주문번호</option>
 			<option value="userID">주문자ID</option>
     		<option value="status">배송상태</option>
    	</select>
    	
   		<input type="text" id="keyword" name="keyword" />
 		<button type="button" class="searchBtn" onclick="search()">검색</button>
<br><div class="pageList">
<%=pageListView %>
</div>

</div>


<br><br>		
		 
<%@include file="/footer.jsp"%>

</body>
</html>