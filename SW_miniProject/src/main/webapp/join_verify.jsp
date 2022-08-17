<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String password=request.getParameter("password");
	String name = request.getParameter("name");
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");
	String extraAddress = request.getParameter("extraAddress");
	String telno = request.getParameter("telno");
	String email = request.getParameter("email");
	
	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniproject";
	String user = "webmaster";
	String pwd = "0000";

	Connection con = null;
	Statement stmt = null;
	
	//LocalDateTime now = LocalDateTime.now();
	//String regdate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	con = DriverManager.getConnection(url, user, pwd);
	
	PreparedStatement pstmt = con.prepareStatement("INSERT INTO system_user VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
	pstmt.setString(1, id);
	pstmt.setString(2, password);

	try{
		pstmt.execute();
		stmt.close();
		con.close();
		%>
		<script>
		alert("회원가입이 완료되었습니다.");
		location.href = "index.jsp";
		</script>
		<%
	}catch(Exception e){
		e.printStackTrace();
		stmt.close();
		con.close();
	}
%>