<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="dao.CartDAO"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="dto.CartDTO"%>
<%@ page import="dto.ProductDTO"%>
<%-- <jsp:useBean id="productDAO" class="dto.ProductDTO" />
<jsp:useBean id="cartDAO" class="dto.CartDTO" />
 --%>
 

<%
String userid = (String)session.getAttribute("userID");

List<CartDTO> cartList = CartDAO.getDAO().selectAllCartList(userid);
List<ProductDTO> productList = new ArrayList<ProductDTO>();
List<Integer> qtyList = new ArrayList<Integer>();

for (CartDTO cart : cartList) {
   int p_id = cart.getp_id();
   ProductDTO product = ProductDAO.getDAO().selectProduct(p_id);
   productList.add(product);
   qtyList.add(cart.getQuantitiy());

}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<body>
   <%@include file="/top.jsp"%>
   <h1>Shopping cart</h1>
   <br>
   <h2>상품 목록</h2>
   <br>
   <!-- 있으면 목록 출력, 없으면 비어있음 표시 -->
   <%
   //if(cartList.isEmty()) {
   if (cartList.isEmpty()) {
   %>
   <div class="emty">
      <a>장바구니가 비어 있습니다.</a>
   </div>
   <%
   } else {
   %>
   <form id = "cartForm" class="cartTable" method="post" action="cart_submit.jsp">
      <div class="cartlist">
         <table border="1">
            <tr>
               <th><input type="checkbox" id="allCheck" name="allcheck" checked></th>
               <th>상품명</th>
               <th>수량</th>
               <th>개당 가격</th>
               <th>전체 가격</th>
            </tr>
            <%
            /* 장바구니에 담긴 제품 수에 따라 장바구니 칸 수 증가 */
            int i = 0;
            for (; i < productList.size(); i++) {
            %>
			<%=productList.get(i).getp_id()%>
            <tr>
               <td><input type="checkbox" name="checkP<%=i%>" value="<%=cartList.get(i).getCartid()%>" class="check" checked> 
               <input type="hidden" name="p_id" value="<%=productList.get(i).getp_id()%>">
               </td>
               <td><input type="button" id="name<%=i%>" class="name" value="<%=productList.get(i).getp_name()%>"></td>
               <td id="quantity<%=i%>" class="quantity">
               <span class="count-box">
                     <button type="button" name="countBtn" class="upBtn">🔼</button> 
                     <input type="text" class="countInput" id="quantity" <%=i%> name="countInput" 
                        value="<%=qtyList.get(i)%>" readonly="readonly" style="width: 20px; border: none;">
                     <button type="button" name="countBtn" class="downBtn">🔽</button>
               </span>
               </td>
               <td><input id="price<%=i%>" class="price" name="price" value="<%=productList.get(i).getp_price()%>" readonly="readonly"></td>
               <td><input id="total<%=i%>" class="total" value="<%=(productList.get(i).getp_price() * qtyList.get(i))%>" name="total" readonly="readonly"></td>
            </tr>
            <%
            }
            %>
            <tr>
               <td colspan="4">결제예정금액</td>
               <td><input id="selectedTotal" readonly="readonly" value="0"></td>
            </tr>
         </table>

         <br>
         <div class="removeBtn">
            <button type="button" id="removeSelectBtn" class="textAndBtn">선택상품 삭제</button>
            <button type="button" id="removeAllBtn">장바구니 비우기</button>
         </div>

         <br>
         <div class="basket_btn">
            <input type="submit" id="submitAllBin" class="submitAllBtn" value="주문하기">
         </div>
      </div>
   </form>
   <%
   }
   %>
   
   <a href="http://localhost:8080/re_myPage_shoppingCart/myPage/userMain.jsp"> 메인페이지로 이동 </a>
   <%@include file="/footer.jsp"%>

   <script>

   $("document").ready(function(){
     //selectedTotal
      var total= 0;
        <%
        for(int j=0;j<productList.size();j++){%>
         total += parseInt(document.getElementById("total<%=j%>").value);
        <%}%>
        $("#selectedTotal").val(total);

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
      
         
         //upBtn 일 경우
         if($(this).hasClass("upBtn")){
            count++
            console.log(count);

         //downBtn 일 경우
         } else{
            count--;
            if (count < 1) return;            
         }
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
   
      
      
         //개별 선택 삭제
          $("#removeSelectBtn").click(function(e) {
         	  e.stopPropagation();
              e.preventDefault();
              
			  let checkCartid = [] ;
			  <%for(int i=0; i<productList.size(); i++){%>
            	if ($('input[name=checkP<%=i%>]').is(':checked')) {
            		checkCartid[<%=i%>]= document.getElementsByName('checkP<%=i%>')[0].value;
            		}
            	
			  	<%}%>
          
               if(window.confirm("선택 상품을 삭제하시겠습니까?")) {
                  location.href="cart_delete.jsp?cartid="+checkCartid;
               }
               
		});      
       
       
         //전체 삭제
          $("#removeAllBtn").click(function() {
               if(window.confirm("장바구니를 비우시겠습니까?")) {
                  location.href="cart_clear.jsp";
               }
         }); 
         
         //주문하기
          /* $("#submitAllBin").click(function(e) {
        	  e.stopPropagation();
              e.preventDefault(); //버블 방지

               if(window.confirm("주문하시겠습니까?")) {
                  location.href="cart_submit.jsp";
               }
         });  */
         
         
      });

</script>
</body>
</html>