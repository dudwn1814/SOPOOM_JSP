<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@page import="java.sql.*"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>

<%@ page import="dao.CartDAO"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="dto.CartDTO"%>
<%@ page import="dto.ProductDTO"%>

   
<%
String userid = (String)session.getAttribute("userID");

List<CartDTO> cartList = CartDAO.getDAO().selectAllCartList(userid);
List<ProductDTO> productList = new ArrayList<ProductDTO>();
List<Integer> qtyList = new ArrayList<Integer>();

for (CartDTO cart : cartList) {
   String p_id = cart.getp_id();
   ProductDTO product = ProductDAO.getDAO().selectProduct(p_id);
   productList.add(product);
   qtyList.add(cart.getQuantitiy());

}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 페이지로 이동중입니다.</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
   function alertNoUserId() {
      alert("로그인 후 이용하실 수 있습니다.");
   }
   function alertDuplicateProduct() {
      alert("상품이 장바구니에 담겨있습니다. 장바구니에서 수량을 조절하세요.");
   }
</script>
</head>

<body>
   <%
   request.setCharacterEncoding("UTF-8");
   System.out.println("userid = " + userid);
   
   if (userid == null) {
   %>
   <script>
      alertNoUserId();
      location.href='/login.jsp';
   </script>

   <% } 
   else {
   String id = (String) request.getParameter("id"); // 상품 아이디

   System.out.println("id = " + id);

   //카트갯수 조회
   int cartNum = 0;
   
   Connection con = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   try{
      
      String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
      String uid = "root";
      String pwd = "1234";

      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(url, uid, pwd);
      
      Statement stmt = con.createStatement();
   
      String countsql = "SELECT COUNT(*) as cartNum FROM cart WHERE p_id = '" + id + "'";
   
      rs = stmt.executeQuery(countsql);
      
      while(rs.next()) cartNum = rs.getInt("cartNum");
      
      System.out.println("[카트번호] : " + countsql);
      
      if(rs != null) rs.close();
      if(stmt != null) stmt.close();
      
   } catch(Exception e) {
      e.printStackTrace();
   }
   
   if (cartNum == 0) {
      String sql = "insert into cart(userID, p_id, QUANTITY) values('" +userid+ "','" + id + "',1)";
      
      try{
         
         Statement stmt = con.createStatement();
         stmt.executeQuery(sql);
         
         if(stmt != null) stmt.close();
      }catch(Exception e){
         e.printStackTrace();
      }
      
      response.sendRedirect("/purchase.jsp");
   } else { %>
   <script>
         alertDuplicateProduct();
         location.href = "shoppingCart.jsp";
         </script>
   <%    }
   if(con != null) {
      con.close();
   }
   }
   %>
</body>

<script>

   $("document").ready(function(){
     //selectedTotal
      var total= 0;
      <%
        for(int j=0;j<productList.size();j++){%>
         total += parseInt(document.getElementById("total<%=j%>").value);
        <%}%>
        $("#selectedTotal").val(total);

         countInput.val(count);
         totalInput.val(count * price);
         var total = Number(0);
         <% for(int j=0; j<productList.size(); j++){ %>
            var checkItem = $("input[name=checkP<%=j%>]");
            if(checkItem.prop("checked")){
               total += Number(document.getElementsByName("total")[<%=j%>].value);
            }

         <%}%>
         $('#selectedTotal').val(total); //#아이디 선택자


      });

         //전체 체크
         $(document).on('change', '#allCheck', function(e) {

            if($(this).prop("checked")) {
               <%for(int i=0; i<productList.size(); i++){%>
                  var checkItem = $("input[name=checkP<%=i%>]");
                  checkItem.prop("checked",true);
                  totalPrice += parseInt(document.getElementById("total<%=i%>").value);
               <%}%>
            } else {
               <%for(int i=0; i<productList.size(); i++){%>
               var checkItem = $("input[name=checkP<%=i%>]");
               checkItem.prop("checked",false);
               totalPrice = 0;
            <%}%>
            }
            console.log("totalPrice : " + totalPrice);
            $('#selectedTotal').val(totalPrice); //바뀐 금액으로 결제 예정 금액 변경
         });


      //개별 체크
      //체크박스가 선택되어 있는 부분의 전체 가격의 합계
      <%for(int i=0; i<productList.size(); i++){%>
         $(document).on('change','input[name=checkP<%=i%>]',function(e){
            let totalPrice = parseInt(document.getElementById("selectedTotal").value);
            console.log("original totalPrice : " + totalPrice + "\n");

            if($(this).prop("checked")) {
               totalPrice += parseInt(document.getElementById("total<%=i%>").value);
               console.log("if : " + document.getElementById("total<%=i%>").value);
            } else {
               totalPrice -= parseInt(document.getElementById("total<%=i%>").value);
               console.log("else : " + document.getElementById("total<%=i%>").value);
            }
            //document.getElementById("sum").value = totalPrice;

            //totalPrice.empty();
            //totalPrice.html(p_totalPrice);
            console.log("changed totalPrice : " + totalPrice + "\n");
            $('#selectedTotal').val(totalPrice); //바뀐 금액으로 결제 예정 금액 변경
         });
      <%}%>
</script>
</html>