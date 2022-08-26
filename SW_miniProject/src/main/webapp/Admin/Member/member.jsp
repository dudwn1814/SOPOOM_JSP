<%@page import="java.net.URLDecoder"%>
<%@page import="com.mini.page.memberPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<head>
<script src="http://code.jquery.com/jquery-1.11.3.js"></script>

<title>회원 목록</title>

<style>
body {
	font-family: "나눔고딕", "맑은고딕"
}

h1 {
	font-family: "HY견고딕"
}

a:link {
	color: black;
}

a:visited {
	color: black;
}

a:hover {
	color: red;
}

a:active {
	color: red;
}

#hypertext {
	text-decoration-line: none;
	cursor: hand;
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

	request.setCharacterEncoding("utf-8");%>	
</style>

<script>

function search(){
	
	var searchType = $("#searchType").val();
	var keyword =  $("#keyword").val();
	location.href = 'member.jsp?page=<%=pageNum%>&searchType=' + searchType + '&keyword=' + keyword;
}

</script>
</head>

<body>

<%@include file="/top.jsp"%>
<%
//DB에서 사용자 정보(아이디랑 패스워드 가져 오기)
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";

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
<%
	int postNum = 5; //한 페이지에 보여질 게시물 갯수 
	int displayPost = (pageNum -1)*postNum; //테이블에서 읽어 올 행의 위치

	String query = "select * from user";

	if(searchType.equals("username")) 
		query += " where username like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	else if(searchType.equals("telno"))
		query += " where telno like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	else if(searchType.equals("username_telno"))
		query += " where username like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%') or telno like concat('%','" + keyword + "','%')"; 
	else if(searchType.equals("userID"))
		query += " where userID like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
	query += " order by userID desc limit "+ displayPost + "," + postNum;
	
	
	System.out.println("[게시판 목록 보기 쿼리] : " + query);
	
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	try {
		
	//DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
	//con = ds.getConnection();
	
	  Class.forName("org.mariadb.jdbc.Driver");
	  con = DriverManager.getConnection(url, uid, pwd);

	  stmt = con.createStatement();
	  rs = stmt.executeQuery(query);

	  while (rs.next()) {
%>
	<tr onMouseover="this.style.background='#46D2D2';" onmouseout="this.style.background='white';">
		<td><%=idx++%></td>
		<td style="text-align: center;">
		<a id="hypertext" href="/Admin/Member/memberInfo.jsp?userID=<%=rs.getString("userID")%>&page=<%=pageNum%>&searchType=<%=searchType%>&keyword=<%=keyword%>"
			onMouseover='this.style.textDecoration="underline"'
			onmouseout="this.style.textDecoration='none';"><%=rs.getString("userID")%></a></td>
		<td><%=rs.getString("username")%></td>
		<td><%=rs.getString("telno")%></td>
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

			String query_totalCount = "select count(*) as totalCount from user";
			
			if(searchType.equals("username")) 
		query_totalCount += " where username like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
			else if(searchType.equals("telno"))
		query_totalCount += " where telno like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
			else if(searchType.equals("username_telno"))
		query_totalCount += " where username like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%') or telno like concat('%','" + keyword + "','%')"; 
			else if(searchType.equals("userID"))
		query_totalCount += " where userID like concat('%','" + URLDecoder.decode(keyword,"UTF-8") + "','%')";
			
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, uid, pwd);
			  
			stmt = con.createStatement();
			rs = stmt.executeQuery(query_totalCount);
			
			while(rs.next()) totalCount = rs.getInt("totalCount");
		}catch(Exception e){
			e.printStackTrace();
		}
		
		memberPage pageList = new memberPage();
		
		String pageListView = pageList.getPageList(pageNum, postNum, listCount, totalCount, searchType, keyword);

		if(stmt != null) stmt.close();
		if(rs != null) rs.close();
		if(con != null) con.close();
	%>
	<%=pageListView %>
		</div>
		<br>
	<div>
  		<select id="searchType" name="searchType">
      		<option value="username">회원이름</option>
      		<option value="telno">전화번호</option>
      		<option value="username_telno">이름+번호</option>
      		<option value="userID">회원아이디</option>
  		</select>
    	<input type="text" id="keyword" name="keyword" />
  		<button type="button" onclick="search()">검색</button>
 	</div>
<br><br>

		<div class="bottom_menu">		
			<a href="/Admin/Member/member.jsp?page=1">목록으로</a>&nbsp;&nbsp;
			<a href="/index.jsp">홈으로</a>&nbsp;&nbsp;
		</div>
	</div>
	
<%@include file="/footer.jsp"%>

</body>
</html>