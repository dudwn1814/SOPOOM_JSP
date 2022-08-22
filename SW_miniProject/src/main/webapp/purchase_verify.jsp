<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	//String userid = (String)session.getAttribute("userid");
	String userid = "noori";
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");
	String extraAddress = request.getParameter("extraAddress");
	String telno = request.getParameter("telno");
	String totalPrice = request.getParameter("totalPrice");
	
	
	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniproject";
	String user = "webmaster";
	String pwd = "0000";
	
	Connection con = null;
	Statement stmt1 = null;
	Statement stmt2 = null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	
	int oCodeCount = 0;
	int sCodeCount = 0;
	String orderCode, shipCode;
	
	try{		

		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, user, pwd);
		
		do{
			//주문 번호 생성(랜덤) 및 중복 검사
			orderCode = RandomStringUtils.randomAlphanumeric(10); 
			String query1 = "select count(*) as codeCount from `order` where orderID='"+orderCode+"'";
			stmt1 = con.createStatement();
			rs1 = stmt1.executeQuery(query1);
			while(rs1.next()) oCodeCount = rs1.getInt("codeCount");
			rs1.close();
		} while(oCodeCount != 0);
		
		//주문 데이터 저장(주문번호=>orderID, uid, 총 가격, 일시)
		pstmt1 = con.prepareStatement("INSERT INTO `order`(orderID, userID, totalPrice) VALUES(?, ?, ?)");
		pstmt1.setString(1, orderCode);
		pstmt1.setString(2, userid);
		pstmt1.setInt(3, Integer.parseInt(totalPrice));
		pstmt1.execute();
		
		//주문 목록 데이터 저장(주문번호, 품목id, 수량)
		
		
		do{
			//배송 번호 생성(랜덤) 및 중복 검사
			shipCode = RandomStringUtils.randomNumeric(10); 
			String query2 = "select count(*) as codeCount from shipping where shipID='"+shipCode+"'";
			stmt2 = con.createStatement();
			rs2 = stmt2.executeQuery(query2);
			while(rs2.next()) oCodeCount = rs2.getInt("codeCount");
			rs2.close();
		} while(sCodeCount != 0);
		
		//배송 데이터 저장(주문번호==배송id?, 이름, 우편번호, 주소, 번호, status)
		pstmt2 = con.prepareStatement("INSERT INTO shipping VALUES(?, ?, ?, ?, ?, ?, ?, ?, '주문 완료')");
		pstmt2.setString(1, shipCode);
		pstmt2.setString(2, orderCode);
		pstmt2.setString(3, name);
		pstmt2.setString(4, postcode);
		pstmt2.setString(5, address);
		pstmt2.setString(6, detailAddress);
		pstmt2.setString(7, extraAddress);
		pstmt2.setString(8, telno);
		pstmt2.execute();
		
		session.setAttribute("orderCode", orderCode);
		response.sendRedirect("purchase_fin.jsp");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		con.close();
		stmt1.close();
		pstmt1.close();
		pstmt2.close();
	}
%>