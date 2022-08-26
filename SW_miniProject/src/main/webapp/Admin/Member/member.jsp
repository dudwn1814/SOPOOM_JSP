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
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="member.css">
</head>

<body>

	<%@include file="/top.jsp"%>
	<%
	int pageNum = Integer.parseInt(request.getParameter("page"));
	String searchType =
	    request.getParameter("searchType") == null ? "" : request.getParameter("searchType");
	String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");


	request.setCharacterEncoding("utf-8");

	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String uid = "root";
	String pwd = "1234";

	int idx = 1;
	%>

	<br>
	<h1>회원 목록</h1>
	<hr>
	<div>
		<select id="searchType" name="searchType">
			<option value="userID">회원아이디</option>
			<option value="username">회원명</option>
			<option value="telno">전화번호</option>
			<option value="username_telno">이름+번호</option>
		</select> <input type="text" id="keyword" name="keyword" />
		<button type="button" onclick="search()">검색</button>
	</div>
	<br>
	<br>

	<div class="tableDiv">

		<table class="InfoTable">
			<tr>
				<th>INDEX</th>
				<th>USER ID</th>
				<th>USER NAME</th>
				<th>E-MAIL</th>
			</tr>

			<tbody>

				<%
				int postNum = 5; //한 페이지에 보여질 게시물 갯수 
				int displayPost = (pageNum - 1) * postNum; //테이블에서 읽어 올 행의 위치
				String query = "select * from user";
				if (searchType.equals("username"))
				  query += " where username like concat('%','" + URLDecoder.decode(keyword, "UTF-8") + "','%')";
				else if (searchType.equals("telno"))
				  query += " where telno like concat('%','" + URLDecoder.decode(keyword, "UTF-8") + "','%')";
				else if (searchType.equals("username_telno"))
				  query += " where username like concat('%','" + URLDecoder.decode(keyword, "UTF-8")
				  + "','%') or telno like concat('%','" + keyword + "','%')";
				else if (searchType.equals("userID"))
				  query += " where userID like concat('%','" + URLDecoder.decode(keyword, "UTF-8") + "','%')";
				query += " order by userID desc limit " + displayPost + "," + postNum;


				System.out.println("[게시판 목록 보기 쿼리] : " + query);

				Connection con = null;
				Statement stmt = null;
				ResultSet rs = null;

				try {

				  Class.forName("org.mariadb.jdbc.Driver");
				  con = DriverManager.getConnection(url, uid, pwd);

				  stmt = con.createStatement();
				  rs = stmt.executeQuery(query);

				  while (rs.next()) {
				%>
				<tr>
					<td class="tdIndex"><%=idx++%></td>
					<td class="tdId"><a id="hypertext"
						href="/Admin/Member/memberInfo.jsp?userID=<%=rs.getString("userID")%>"
						onMouseover='this.style.textDecoration="underline"'
						onmouseout="this.style.textDecoration='none';"><%=rs.getString("userID")%></a></td>
					<td class="tdName"><%=rs.getString("username")%></td>
					<td class="tdEmail"><%=rs.getString("email")%></td>
				</tr>

				<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				}

				if (stmt != null)
				stmt.close();
				if (rs != null)
				rs.close();
				if (con != null)
				con.close();
				%>
			</tbody>

		</table>
		<br>
		<div>
			<%
			int listCount = 5; //한 화면에 보여질 페이지 갯수
			int totalCount = 0; //전체 게시물 갯수

			try {
			  String query_totalCount = "select count(*) as totalCount from user";

			  if (searchType.equals("username"))
			    query_totalCount +=
			    " where username like concat('%','" + URLDecoder.decode(keyword, "UTF-8") + "','%')";
			  else if (searchType.equals("telno"))
			    query_totalCount +=
			    " where telno like concat('%','" + URLDecoder.decode(keyword, "UTF-8") + "','%')";
			  else if (searchType.equals("username_telno"))
			    query_totalCount += " where username like concat('%','" + URLDecoder.decode(keyword, "UTF-8")
			    + "','%') or telno like concat('%','" + keyword + "','%')";
			  else if (searchType.equals("userID"))
			    query_totalCount +=
			    " where userID like concat('%','" + URLDecoder.decode(keyword, "UTF-8") + "','%')";

			  Class.forName("org.mariadb.jdbc.Driver");
			  con = DriverManager.getConnection(url, uid, pwd);

			  stmt = con.createStatement();
			  rs = stmt.executeQuery(query_totalCount);

			  while (rs.next())
			    totalCount = rs.getInt("totalCount");
			} catch (Exception e) {
			  e.printStackTrace();
			}

			memberPage pageList = new memberPage();

			String pageListView =
			    pageList.getPageList(pageNum, postNum, listCount, totalCount, searchType, keyword);
			if (stmt != null)
			  stmt.close();
			if (rs != null)
			  rs.close();
			if (con != null)
			  con.close();
			%>
			<%=pageListView%>
		</div>
		<br>
	</div>

	<%@include file="/footer.jsp"%>
</body>
</html>