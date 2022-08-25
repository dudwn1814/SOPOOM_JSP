<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="../../DB/dbconn.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	String filename = "";
	String realFolder = "C:\\upload"; //웹 어플리케이션상의 절대 경로
	String encType = "utf-8"; //인코딩 타입
	int maxSize = 5 * 1024 * 1024; //최대 업로드될 파일의 크기5Mb

	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType,
			new DefaultFileRenamePolicy());

	String p_id = multi.getParameter("p_id");
	String p_name = multi.getParameter("p_name");
	String p_price = multi.getParameter("p_price");
	String p_amount = multi.getParameter("p_amount");
	String p_filename = multi.getParameter("p_filename");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String condition = multi.getParameter("condition");

	Integer price;


	if (p_name == null) p_name = null;
	if (p_price == null) p_price = "0";
	if (p_amount == null) p_amount = "0";

	if (p_filename == null) p_filename =  null;
	if (description == null) description =  null;
	
	if (manufacturer == null) manufacturer = null;
	if (category == null) category = null;
	if (condition == null) condition = null;


	
	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String fileName = multi.getFilesystemName(fname);

	String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, p_id);
	pstmt.setString(2, p_name);
	pstmt.setInt(3, Integer.parseInt(p_price));
	pstmt.setString(4, description);
	pstmt.setString(5, category);
	pstmt.setString(6, manufacturer);
	pstmt.setInt(7, Integer.parseInt(p_amount));
	pstmt.setString(8, condition);
	pstmt.setString(9, p_filename);
	
	pstmt.executeUpdate();
	
	if (pstmt != null)
 		pstmt.close();
 	if (conn != null)
		conn.close();
	
 	response.sendRedirect("/Admin/Inventory/inventory.jsp");
%>
