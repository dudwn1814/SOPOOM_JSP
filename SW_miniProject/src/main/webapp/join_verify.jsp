<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String id=request.getParameter("id");
String password=request.getParameter("password");
String passwordchk = request.getParameter("passwordchk");
String name = request.getParameter("name");
String postcode = request.getParameter("postcode");
String address = request.getParameter("address");
String detailAddress = request.getParameter("detailAddress");
String extraAddress = request.getParameter("extraAddress");

if (id == null) id = "";
if (password == null) password = "";
if (name == null) name = "";
if (postcode == null) postcode = "";
if (address == null) address = "";
if (detailAddress == null) detailAddress = "";
if (extraAddress == null) extraAddress = "";


if(! password.equals(passwordchk))	{
	%>
	<script>
		alert("비밀번호를 확인해주세요.");
		window.history.back();
	</script>
	<%
}

else{
	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;

	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:mariadb://127.0.0.1:3306/webdev";
	String user = "DBProgramming";
	String passwd = "oracle";
	
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	
	PreparedStatement pstmt = myConn.prepareStatement("INSERT INTO system_user VALUES(?, ?)");
	pstmt.setString(1, id);
	pstmt.setString(2, password);

	
	try{
		pstmt.execute();
		%>
		<script>
		alert("회원가입이 완료되었습니다.");
		location.href = "main.jsp";
		</script>
		<%
	} catch(SQLException ex){
		String sMsg;
		System.out.println(ex.getMessage()+" "+ ex.getErrorCode());
		if(ex.getErrorCode() == 20002) sMsg = "암호는 4자리 이상이어야 합니다.";
		else if (ex.getErrorCode() == 20003) sMsg = "암호에 공란은 입력되지 않습니다";
		else if (ex.getErrorCode() == 00001) sMsg = id+"는 이미 사용 중인 아이디입니다.";
		else if (ex.getErrorCode() == 1400) sMsg = "정보를 정확히 입력해주세요";
		else sMsg = "잠시후 다시 시도하십시오";
		%>
		<script>
		alert("<%=sMsg%>");
		location.href = "join.jsp";
		</script>
		<%
		return;
	}
	finally{
	}
	pstmt.close();
	myConn.close();
	}
	%>