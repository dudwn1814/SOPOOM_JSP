<!-- 주문 페이지 -->
<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.sql.Array"%>
<%@page import="dto.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dto.CartDTO"%>
<%@page import="dao.CartDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");

String userid = (String)session.getAttribute("userID"); //접속해있는 유저 아이디

CartDAO.getDAO().clearCart(userid);

String[] cartid = request.getParameterValues("p_id"); // cart id 받아오기
String[] q = request.getParameterValues("countInput"); // 물건 개수 값 받아오는 부분
String[] p_id_string = request.getParameterValues("p_id"); //제품 id 받아오기

/* System.out.println(cid[3]);
System.out.println(q[1]); */

String pids="";
String qs = "";
String cartids = "";

/* List<String> cartid = new ArrayList<String>();
while(cartid.remove(null)){};
System.out.println(cartid); */

//cartid null보정
if(cartid == null) {
	cartid = new String[0];
}
for(int i=0; i<cartid.length; i++){
	cartids+= cartid[i]+"&nbsp";
}

//q null값 보정 부분
if(q==null){
	q = new String[0];
}
for(int i=0; i<q.length; i++){
	qs+= q[i]+"&nbsp";
}


//p_id_string null값 보정 부분
if(p_id_string==null){
	p_id_string = new String[0];
}
for(int i=0; i<p_id_string.length; i++){
	pids+= p_id_string[i]+"&nbsp";
}


//System.out.println(cartid);
//System.out.println("pid 문자열 타입: " + Arrays.toString(p_id_string));
//System.out.println("제품 수량: " + Arrays.toString(q));
System.out.println("cart id: " + Arrays.toString(cartid));
//System.out.println("제품 아이디:" + Arrays.toString(p_id_string));

int[] quantity = new int[q.length]; //물건 수량 리스트 생성, 0초기화
int[] p_id = new int[p_id_string.length]; //물건 수량 리스트 생성, 0초기화

 

ProductDTO product = new ProductDTO();
CartDTO cart = new CartDTO();

for (int i=0; i<cartid.length; i++) { //물건 종류 개수	
	
	quantity[i] = Integer.parseInt(q[i]);
	p_id[i] = Integer.parseInt(p_id_string[i]);
	
	cart.setCartid(cartid[i]);
	cart.setp_id(p_id[i]);
	cart.setUserid(userid);
	cart.setQuantitiy(quantity[i]);
	
	CartDAO.getDAO().insertCart(cart);
}

out.println("<script type='text/javascript'>");
out.println("location.href='shoppingCart.jsp'");
out.println("</script>");

%>