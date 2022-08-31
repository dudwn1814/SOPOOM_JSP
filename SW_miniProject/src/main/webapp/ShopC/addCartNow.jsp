<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.PreparedStatement"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.lang.Integer"%>

<%@page import="java.text.DecimalFormat"%>

<%@ page import="dao.CartDAO"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="dto.CartDTO"%>
<%@ page import="dto.ProductDTO"%>

<!DOCTYPE html>
<html>

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
      location.href='/Login/login.jsp';
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
      
      response.sendRedirect("/Purchase/purchase_now.jsp");
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
	function commaInsurt(I) {
	str = String(I);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');	
	}

   $("document").ready(function(){
		
	   //시작하자마자 제품 가격 띄워주는 부분
	   
	   <%for (int i=0;i<productList.size(); i++){%>
	   var vis_price_location = document.getElementById("vis_price<%=i %>");
	   var hidden_price = document.getElementById("price<%=i%>").value;
	  	$("#vis_price<%=i%>").val(commaInsurt(hidden_price));

	   
	   //시작하자마자 제품 가격 x 수량 띄워주는 부분 
	   var vis_total_location = document.getElementById("vis_total<%=i %>");
	   var hidden_total = document.getElementById("total<%=i%>").value;
	   $("#vis_total<%=i %>").val(commaInsurt(hidden_total));
	   
	   <%}%>
	   
	   //시작하자마자 전체 가격 띄워주는 부분
      var total= 0;
      <%
        for(int j=0;j<productList.size();j++){%>
         total += parseInt(document.getElementById("total<%=j%>").value);
        <%}%>
        
        $("#selectedTotal").val(total);
        $("#vis_selectedTotal").val(commaInsurt(total));

      //수량 증가-감소 버튼
      $(document).on('click','button[name="countBtn"]',function(e){
         e.stopPropagation();
         e.preventDefault(); //버블 방지
         let countBox = $(this).closest('.count-box'); //가장 가까운 (위에서 아래로) 체크박스
         let row = countBox.closest('tr');//가장 가까운 (위에서 아래로) tr(row)
         let countInput = countBox.find('input[name=countInput]');//가장 가까운 체크박스를 찾은 곳에서 name이 countInput인 값을 찾아라
         let count = parseInt(countInput.val());
         let price = row.find('input[name=price]').val();
         let totalInput = row.find('input[name=total]');
         
         let vis_totalLocation = row.find('input[name=vis_total]');


         //upBtn 일 경우
         if($(this).hasClass("upBtn")){
            count++

         //downBtn 일 경우
         } else{
            count--;
            if (count < 1) return;
         }
         
         //변경 수량 적용
         countInput.val(count);
         
         //변경 수량*가격 변수
         let totalinput_mul = count * price;
         console.log(totalinput_mul);
         
         //전체 가격 수정
         totalInput.val(totalinput_mul);
         
         //제품 수량 X 가격 수정
         vis_totalLocation.val(commaInsurt(totalinput_mul));
         
         var total = Number(0);
         
         <% for(int j=0; j<productList.size(); j++){ %>
            var checkItem = $("input[name=checkP<%=j%>]");
            if(checkItem.prop("checked")){
               total += Number(document.getElementsByName("total")[<%=j%>].value);
            }

         <%}%>
         
         
         $('#selectedTotal').val(total);
         $('#vis_selectedTotal').val(commaInsurt(total)+"");



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



         //개별 선택 삭제
          $("#removeSelectBtn").click(function(e) {
         	  e.stopPropagation();
              e.preventDefault();

			  let checkp_id = [] ;
			  <%for(int i=0; i<productList.size(); i++){%>
            	if ($('input[name=checkP<%=i%>]').is(':checked')) {
            		checkp_id[<%=i%>]= document.getElementsByName('checkP<%=i%>')[0].value;
            		}

			  	<%}%>

               if(window.confirm("선택 상품을 삭제하시겠습니까?")) {
                  location.href="cart_delete.jsp?p_id="+checkp_id;
               }

		});


         //전체 삭제
          $("#removeAllBtn").click(function() {
               if(window.confirm("장바구니를 비우시겠습니까?")) {
                  location.href="cart_clear.jsp";
               }
         });

      });

</script>
</html>