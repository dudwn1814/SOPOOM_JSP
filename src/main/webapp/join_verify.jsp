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
	
<<<<<<< HEAD:SW_miniProject/src/main/webapp/join_verify.jsp
	String url = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
	String user = "root";
	String pwd = "0000";
=======
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String user = "root";
	String pwd = "1234";
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/join_verify.jsp

	Connection con = null;
	Statement stmt = null;
	
	//LocalDateTime now = LocalDateTime.now();
	//String regdate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	
	Class.forName("org.mariadb.jdbc.Driver");
	con = DriverManager.getConnection(url, user, pwd);
	
<<<<<<< HEAD:SW_miniProject/src/main/webapp/join_verify.jsp
	//role 없는 경우
	PreparedStatement pstmt = con.prepareStatement("INSERT INTO user VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
	//role 지정 시
	//PreparedStatement pstmt = con.prepareStatement("INSERT INTO user VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, 'user')");
=======
	PreparedStatement pstmt = con.prepareStatement("INSERT INTO user VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/join_verify.jsp
	pstmt.setString(1, id);
	pstmt.setString(2, password);
	pstmt.setString(3, name);
	pstmt.setString(4, postcode);
	pstmt.setString(5, address);
	pstmt.setString(6, detailAddress);
	pstmt.setString(7, extraAddress);
	pstmt.setString(8, telno);
	pstmt.setString(9, email);

	try{
		pstmt.execute();
		pstmt.close();
		con.close();
	%>
		<script>
		alert("회원가입이 완료되었습니다.");
		<% session.invalidate();%>
		location.href = "index.jsp";
		</script>
		<%		
	}catch(Exception e){
		e.printStackTrace();
		pstmt.close();
		con.close();
		%>
		<script>
		alert("잠시후 다시 시도하세요.");
		location.href = "join.jsp";
		</script>
		<%		
	}
%>