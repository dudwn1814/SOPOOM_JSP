<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.lang.Integer"%>

<%@page import="java.text.DecimalFormat"%>

<%@ page import="dao.CartDAO"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="dto.CartDTO"%>
<%@ page import="dto.ProductDTO"%>
<%-- <jsp:useBean id="productDAO" class="dto.ProductDTO" />
<jsp:useBean id="cartDAO" class="dto.CartDTO" />
 --%>




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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="shoppingCart.css">
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.5/dist/web/static/pretendard.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" integrity="sha512-NhSC1YmyruXifcj/KFRWoC561YpHpc5Jtzgvbuzx5VozKpWvQ+4nXhPdFgmx8xqexRcpAglTj9sIBWINXa8x5w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>장바구니</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</head>
<body>
<%@include file="/top.jsp"%>
<%DecimalFormat df = new DecimalFormat("###,###");

	 if (userid == null) { %>
	<script>
		alert("로그인이 필요한 서비스입니다.");
		location.href = "/login.jsp";
	</script>
	<%}%>
	
	<div class="mypage">
		<div class="mypage">
            <div class="head-title">
                <div class="heade-title-container">
                    <span class="mainTitle">장바구니</span>
                </div>
            </div>
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
	<form id="cartForm" class="cartTable" method="post" action="/purchase.jsp">
		<table class="cart-table-container">
                <tr>
                    <th input type="checkbox" id="allCheck" name="allcheck" checked class="checkabox-container" style="text-align: left" > </th>
                    <th style="text-align: left">상품 정보</th>
                    <th style="text-align: left"></th>
                    <th>수량</th>
                    <th>개별 가격</th>
                    <th>전체 가격</th>
                </tr>
		<%
            /* 장바구니에 담긴 제품 수에 따라 장바구니 칸 수 증가 */
            int i = 0;
            for (; i < productList.size(); i++) {
            %>
                <tbody>
                <tr>
                    <td class="tdId checkabox-container">
                        <input type="checkbox" name="checkP<%=i%>" value="<%=cartList.get(i).getp_id()%>" class="check" checked>
                   		<input type="hidden" name="p_id" value="<%=productList.get(i).getp_id()%>">
                    </td>

                    <td class="tdId img">
                        <image src="/upload/<%= productList.get(i).getP_fileName() %>" width="100px" />	
                        <input type="hidden" name="fileName" id="fileName" value="<%= productList.get(i).getP_fileName() %>" width="100px" />	
                    </td>

                    <td class="tdId Pname">
                        <input type="text" id="name<%=i%>" class="name" name="pname" value="<%=productList.get(i).getp_name()%>" readonly="readonly">
                    </td>

                    <td class="tdId quantity" id="quantity<%=i%>" class="quantity">
                        <div class="count-box">
                            <div class="btn"> <button type="button" name="countBtn" class="upBtn">
                            <img src="./img/+btn.png" width="30px"></button> </div>
                            <div class="btn"><input class="countInput" type="text" class="countInput" id="quantity" <%=i%> name="countInput" value="<%=qtyList.get(i)%>" readonly="readonly"></div>
                            <div class="btn"><button type="button" name="countBtn" class="downBtn">
                            <img src="./img/-btn.png" width="30px"> </button></div>
                        </div>
                    </td>
                    <!-- test중 -->
                    <td class="tdId P-one-price">
                        <input id="vis_price<%=i %>" class="price" name="vis_price" value="" readonly="readonly"> 
                        <input type="hidden" id="price<%=i%>" class="price" name="price" value="<%=productList.get(i).getp_price()%>" readonly="readonly">
                    </td>
                    <td class="tdId  P-price">
                     	<input id="vis_total<%=i %>" class="total" name="vis_total" value="" readonly="readonly">
                        <input type="hidden" id="total<%=i%>" class="total" value="<%= productList.get(i).getp_price() * qtyList.get(i)%>" name="total" readonly="readonly">
                    </td>
                    </tr>
                   
                </tbody>
                <%} %>
            </table>
          
          
          <div class="title-container">
                <div>
                    <button type="button" id="removeSelectBtn" class="check-remove-btn">선택상품 삭제</button>
                    <button type="button" id="removeAllBtn" class="all-remove-btn">장바구니 비우기</button>
                </div>

                <div class="title"> 결제예정금액 :
                	<div> </div>
                    <input type="hidden" class="title-price" id="selectedTotal" name="selectedTotal" readonly="readonly" value="">
                    <input class="title-price" id="vis_selectedTotal" name="vis_selectedTotal" readonly="readonly" value=""> 원<br>
                    <input type="submit" id="submitAllBin" class="submit-btn" value="주문하기">
                </div>
            </div>

            <div class="btn-container">

            </div>
		</form>
        </div>
          
	<%
   }
   %>
   
</div>
	<%@include file="/footer.jsp"%>

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
</body>
</html>