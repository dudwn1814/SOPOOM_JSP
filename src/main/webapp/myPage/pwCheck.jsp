<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지-수정 및 정보 확인을 위한 패스워드 체크</title>
</head>
<body>

	<%
	//DB에서 사용자 정보(아이디랑 패스워드 가져오기)(DB접속할때마다 이렇게 해줘야함.)
			request.setCharacterEncoding("utf-8");

			String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
			String user = "root";
			String pwd = "1234";
			
			String userid = (String)session.getAttribute("userID");
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			//db PW확인
			//String origin_pw = (String)session.getAttribute("password"); */
			
			String origin_pw = "";
			
			try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pwd);
			
			String sql = "select password from user where userid= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){										
			origin_pw = rs.getString("password");
			}
			
			con.close();
			pstmt.close();
			rs.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		//확인 창에서 파라미터로 받은 값
		String input_pw = request.getParameter("password");

		//패스워드 확인
		if (input_pw.equals(origin_pw)) {
			response.sendRedirect("userInfo.jsp");
		}
		//패스워드 틀림
		else {
	%>
	<script>
		alert("비밀번호가 틀립니다.");
		document.location.href = 'userMain.jsp';
		</script>
	<%		
	}
%>

</body>
</html>