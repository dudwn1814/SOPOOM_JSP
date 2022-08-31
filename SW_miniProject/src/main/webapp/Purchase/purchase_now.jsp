<%@page import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
   //user 정보 받아오기
   String userid = (String)session.getAttribute("userID");
   String userName = "";
   String userTelno = "";
   String userMail = "";
   String postCode = "";
   String address = "";
   String detailAddress = "";
   String extraAddress = "";
   
   String p_name = "";
   int p_unitPrice = 0 ;
   String p_fileName = "";
   
   
   
   //상품정보 받아오기
   request.setCharacterEncoding("UTF-8");
   //productID 받아오기
   String productID = (String) request.getParameter("id");
   System.out.println(productID);

   
   if(userid == null){
      %>
      <script>
      alert("로그인이 필요한 서비스입니다.");
      location.href = "/Login/login.jsp";
      </script>
      <%}


   String url = "jdbc:mariadb://127.0.0.1:3306/inventory";

   String user = "root";
   String pwd = "1234";
   
   Connection con = null;
   Statement stmt = null;
   Statement stmt2 = null;
   ResultSet rs = null;
   ResultSet rs2 = null;
   
   try{
      
      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(url, user, pwd);
      
      //존재하는 아이디인지 확인
      String query = "select * from user where userID='"+userid+"'";
      
      stmt = con.createStatement();
      
      rs = stmt.executeQuery(query);   
      
      while(rs.next()){
         userName = rs.getString("username");
         userTelno = rs.getString("telno");
         userMail = rs.getString("email");
         postCode = rs.getString("postcode");
         address = rs.getString("address");
         detailAddress = rs.getString("detailAddress");
         extraAddress = rs.getString("extraAddress");
      }      
   } catch(Exception e){
      e.printStackTrace();
   } finally{
      stmt.close();
      rs.close();
      con.close();
   }
   
   try{      
	      Class.forName("org.mariadb.jdbc.Driver");
	      con = DriverManager.getConnection(url, user, pwd);
	      
	      //존재하는 아이디인지 확인
	      String query = "select p_name, p_unitPrice, p_fileName from product where p_id='"+productID+"'";
	      System.out.println(query);
	      
	      stmt = con.createStatement();
	      
	      rs = stmt.executeQuery(query);   
	      
	      while(rs.next()){
	    	  p_name = rs.getString("p_name");
	    	  p_unitPrice = rs.getInt("p_unitPrice");
	    	  p_fileName = rs.getString("p_fileName");	
	      }      
	   } catch(Exception e){
	      e.printStackTrace();
	   } finally{
	      stmt.close();
	      rs.close();
	      con.close();
	   }
   
   DecimalFormat df = new DecimalFormat("###,###");
  
   request.setAttribute("totalPrice", p_unitPrice);
   session.setAttribute("strTotal", df.format(p_unitPrice));
   
   %>

	

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
		$("input[name='delivery']").change(function(){
			if($("input[name='delivery']:checked").val() == "default"){
				$("#name").val('<%=userName%>');
				$("#postcode").val('<%=postCode%>');
				$("#address").val('<%=address%>');
				$("#detailAddress").val('<%=detailAddress%>');
				$("#extraAddress").val('<%=extraAddress%>');
				$("#telno").val('<%=userTelno%>');
				
			} else if($("input[name='delivery']:checked").val() == "new"){
				$("#name").val('');
				$("#postcode").val('');
				$("#address").val('');
				$("#detailAddress").val('');
				$("#extraAddress").val('');
				$("#telno").val('');
			}
			
		});		
		
		$("#telno").keypress(function(){
			if ((event.keyCode < 48) || (event.keyCode > 57))	event.returnValue = false;
		});
		
		
		$("#telno").keyup(function(){
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
		
		
		$("#btn_purchase").click(function(){
			
			//이름
			if($("#name").val() == '') { $("#msg_name").css('display', 'block'); $("#name").focus(); return false; }
			else{	$("#msg_name").css('display', 'none');}
			
			
			//주소
			if($("#detailAddress").val() == ''){ $("#msg_address").css('display', 'block'); $("#detailAddress").focus(); return false; }
			else{	$("#msg_address").css('display', 'none');}
			
			//전화번호
		 	if($("#telno").val() == '') { $("#msg_telno").css('display', 'block'); $("#telno").focus(); return false;}
		 	else{	$("#msg_telno").css('display', 'none');}
		 	
		 	$("#postcode").attr("disabled", false);
		 	$("#address").attr("disabled", false);
		 	$("#extraAddress").attr("disabled", false);
			$("#purchaseForm").attr("action","purchase_verify.jsp").submit();	
		});
	});
	
</script>

<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
</script>

<style>
form{
	margin:auto;
	width : 70%;
	min-width : 764px;
}

#innerForm{
	margin : auto;
	width : 764px;
	height : fit-content;
}

#innerForm2{
	background-color : rgba(0, 0, 0, 0.04);
}

.title h3{
	margin: 24px 0px;
}

.orderComponentCard{
	display : flex;
	margin-bottom : 24px;
}


.detailForm{
	min-width : 700px;
	background-color : #FFFFFF;
	padding : 24px 16px;
	margin-bottom : 16px;
}

.productInfo{
	margin : 3px 16px;
}

.divPname{
	margin-bottom : 2px;
}

.priceInfo{
	margin-top : 8px;
}

hr{
	background-color : #ececec;
	height : 1px;
	border : 0;
	margin-bottom : 24px;
}

.totalPriceRow{
	display : flex;
}

.totalPrice{
	text-align : right;
	flex : 1;
}

.divPname{
	font-size:16px;
	font-weight:normal;
	margin-bottom:2px;
	line-height : 150%;
}

.divPriceCount{
	font-weight:normal;
	margin-top:8px;
	line-height : 150%;
}

.label{
	font-size : 16px;
	font-weight : normal;
	line-height : 150%;
}

.totalPrice{
	font-size : 20px;
	font-weight : bold;
	color : #4053ff;

}

.cardRow{
	margin : 0px 5px;
	font-size : 14px;
	line-height : 17px;
	margin-bottom : 20px;
}

.rowTitle{
	display : block;
	margin-bottom : 12px;
	line-height : 17px;
	letter-spacing : -0.1em;
}

.field{
	font-size : 14px;
	line-height:23px;
	width : 50%;
	border : 1px solid #BFBFBF;
	padding : 10px 15px;
	box-sizing : border-box;
	margin-bottom : 6px;
}

#orderPersonInfo .cardRow .field{
	border : none;
}

.radio_btn{
	margin-bottom : 24px;
	font-size : 14px;
}


 #btn_address{
	font-size : 14px;
	margin-left : 8px;
	margin-bottom : 18px;
	padding : 10px 7px;
	line-height: 23px;
	display:inline;
	border : 1px solid  #313131;
	background-color :  #313131;
	color : #FFFFFF;
	cursor : pointer;
	transition-duration: 0.4s;
}

input:focus{
    outline: none;
}


.button{
	padding: 5px;
	margin : auto;
	cursor : pointer;
	border-radius : 50px;
	width : 100%;
	max-width : 240px;
	min-width : 160px;
	height : 54px ! important;
	min-height : 54px;
	font-size : 14px !important;
	font-weight : 700;
}

#btn_purchase{
	color: #FFFFFF !important;
    background-color: #313131 !important;
    border-color: #313131 !important;
    border-width : 1px;
    transition-duration: 0.4s;
}

#btn_address:hover, #btn_purchase:hover{
 	opacity : 0.7;
}

#btn_row{
	margin-top : 36px;
	margin-bottom : 5em;
	text-align : center;
}
<!-- -->

#msg_address, #msg_telno, #msg_name{
	font-size:12px;
	display : none;
	color: red;
}



#strTotal{
	font-size : 2em;
	font-weight : bold;
}
</style>

<head>
<meta charset="UTF-8">
<title>JSP미니 프로젝트</title>
</head>
<body>
	<%@include file="/top.jsp"%>
	<form name="purchaseForm" id="purchaseForm" method="post">
	<div id="innerForm">
	<div id="innerForm2">
	<div class="detailForm">
			<div class="row">
			<label class="title"><h3>주문 상품</h3></label> 
			<div class="orderComponentCard">
				<img src="/upload/<%=p_fileName %>" alt="productImg" width="90" height="120">
				<div class="productInfo">
				<div class="divPname"><%=p_name %></div>
				<input type="hidden" name="p_id" value="<%=productID%>">
				<div class="priceInfo"> 1 개 /  <%= df.format(p_unitPrice) %> 원 </div>
				<input type="hidden" name="count" value="1">
				</div>
			</div>
            			
			<hr>
			<div class="totalPriceRow">
			<span class="label">상품 합계</span>
			<div class="totalPrice">상품전체금액 <%= df.format(p_unitPrice)%> 원</div>
			</div>
		</div>		
	</div>
	
	<div class="detailForm">
			<div class="row">
			<label class="title"><h3>주문자</h3></label>
			<div class="orderInfoCard" id="orderPersonInfo">
					<div class="cardRow">
					<label class="rowTitle">이름</label>
					<input type="text" class="field" value="<%= userName %>" disabled>
					</div>
					<div class="cardRow">
					<label class="rowTitle">전화번호</label>
					<input type="text" class="field" value="<%= userTelno %>" disabled>
					</div>
					<div class="cardRow">
					<label class="rowTitle">이메일</label>
					<input type="text" class="field" value="<%= userMail %>" disabled>
					</div>
			</div>
		</div>		
	</div>
	
	
	<div class="detailForm">
		<div class="row">
		<label class="title"><h3>배송지</h3></label>
		<div class="orderInfoCard">
		<div class="radio_btn">
				<input type="radio" name="delivery" value="default" checked="checked">기존 배송지&nbsp;&nbsp;
				<input type="radio" name="delivery" value="new">새로운 배송지</td>
		</div>
				<div class="cardRow">
				<label class="rowTitle">이름</label>
				<input type="text" class="field" id="name" name="name" maxlength="50" value="<%=userName %>" autoComplete="off">
				<div id="msg_name" class="msg">이름을 입력해주세요.</div>
				</div>
				<div class="cardRow">
				<label class="rowTitle">우편번호</label>
				<input type="text" class="field" id="postcode" name="postcode" placeholder="우편번호" value="<%=postCode %>" disabled>
				<input type="button" id="btn_address" onclick="execDaumPostcode()" value="우편번호 찾기">
				</div>
				<div class="cardRow">
				<label class="rowTitle">주소</label>
				<input type="text" class="field" id="address" name="address" placeholder="기본주소" value="<%=address %>" disabled><br>
				<input type="text" class="field" id="detailAddress" name="detailAddress" value="<%=detailAddress %>" placeholder="상세주소" autoComplete="off">
				<input type="hidden" class="field" id="extraAddress" name="extraAddress" value="<%=extraAddress %>" disabled>
				<div id="msg_address" class="msg">주소지를 입력해주세요.</div>
				</div>
				<div class="cardRow">
				<label class="rowTitle">전화번호</label>
				<input type="text" class="field" id="telno" name="telno" maxlength="13" value="<%=userTelno %>"  autoComplete="off"  />
				<div id="msg_telno" class="msg">전화번호를 입력해주세요.</div>
		</div>
		</div>		
	</div>
	</div>
		
		</div>
		<input type="hidden" name="totalPrice" value="<%=p_unitPrice%>" />
		<div class="row" id="btn_row">
		<input type="button" id="btn_purchase" class="button" value="<%=df.format(p_unitPrice)%>원 결제하기">
		<input type="hidden" name = "totalPrice"  value="<%=p_unitPrice%>">
		
		</div>
	</div>
	</form>
	<%@include file="/footer.jsp"%>
</body>
