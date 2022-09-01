<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	String realFolder = request.getSession().getServletContext().getRealPath("./upload");
	
	int maxSize = 5 * 1024 * 1024; //최대 업로드될 파일의 크기5Mb
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize,  "utf-8",
		new DefaultFileRenamePolicy());

	String p_id = multi.getParameter("p_id");
	String p_name = multi.getParameter("p_name");
	String p_price = multi.getParameter("p_price");
	String p_amount = multi.getParameter("p_amount");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String condition = multi.getParameter("condition");
	
	int filesize = 0;
	
	Enumeration files = multi.getFileNames();
	String name = (String)files.nextElement();
	
	String originalFileName = multi.getOriginalFileName(name); 
	String storedFileName = "";

	if (p_name == null) p_name = null;
	
	if (description == null) description =  null;
	
	if (manufacturer == null) manufacturer = null;
	if (category == null) category = null;
	if (condition == null) condition = null;
	
	if(originalFileName != null){
	  
	  System.out.println("check");
		//변경되기 전 파일 이름에서 확장자 분리
		String originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));	
		//난수값을 발생시켜 파일명 생성
		storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;	
		System.out.println("check1 ===" + storedFileName);
	
	}

	String changedFileName = multi.getFilesystemName(name);
	

	p_price = p_price.replace(",", "");
	
	System.out.println("check2 ===" + storedFileName);
	
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
		String uid = "root";
		String pwd = "1234";
		
		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(uri, uid, pwd);
	} catch (SQLException ex) {
		out.println("데이터베이스 연결이 실패되었습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	}

	String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, p_id);
	pstmt.setString(2, p_name);
	pstmt.setInt(3, Integer.parseInt(p_price));
	pstmt.setString(4, description);
	pstmt.setString(5, category);
	pstmt.setString(6, manufacturer);
	pstmt.setInt(7, Integer.parseInt(p_amount));
	pstmt.setString(8, condition);
	pstmt.setString(9, storedFileName);
	
	pstmt.executeUpdate();
	
	if (pstmt != null)
 		pstmt.close();
 	if (con != null)
		con.close();
 	
 	File file = new File(realFolder + "\\" + changedFileName);
	if(file.exists()) file.renameTo(new File(realFolder + "\\" + storedFileName));
	
 	response.sendRedirect("/Admin/Inventory/inventory.jsp?page=1");
%>
