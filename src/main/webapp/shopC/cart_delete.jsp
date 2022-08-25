<%-- 장바구니 선택삭제 --%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.Console"%>
<%@page import="dto.CartDTO"%>
<%@page import="dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");	
	
	String cartid = request.getParameter("cartid");
	
	String[] cart = cartid.split(",");
	
	for(int i = 0;i<cart.length;i++){
		CartDAO.getDAO().deleteCart(cart[i]);
	}
	
	out.println("<script type='text/javascript'>");	
	out.println("location.href= 'shoppingCart.jsp;'");
	out.println("</script>");	
	
%>