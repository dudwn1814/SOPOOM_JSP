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

	if (p_price.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(p_price);

	long stock;

	if (p_amount.isEmpty())
 		stock = 0;
 	else
 		stock = Long.valueOf(p_amount);

	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String fileName = multi.getFilesystemName(fname);

	String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, p_id);
	pstmt.setString(2, p_name);
	pstmt.setInt(3, Integer.parseInt(p_price));
	pstmt.setInt(4, Integer.parseInt(p_amount));
	pstmt.setString(5, p_filename);
	pstmt.setString(6, description);
	pstmt.setString(7, manufacturer);
	pstmt.setString(8, category);
	pstmt.setString(9, condition);
	
	pstmt.executeUpdate();
	
	if (pstmt != null)
 		pstmt.close();
 	if (conn != null)
		conn.close();
	
 	response.sendRedirect("index.jsp");
%>
