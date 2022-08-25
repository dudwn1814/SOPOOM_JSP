<%@page import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%
	//user 정보 받아오기
	//String userid = (String)session.getAttribute("userid");
	String userid = "dudwn1814";
	String userName = "";
	String userTelno = "";
	String userMail = "";
	String postCode = "";
	String address = "";
	String detailAddress = "";
	String extraAddress = "";


<<<<<<< HEAD:SW_miniProject/src/main/webapp/purchase.jsp
	String url = "jdbc:mariadb://127.0.0.1:3306/SW_miniProject";
	String user = "root";
	String pwd = "0000";
=======
	String url = "jdbc:mariadb://127.0.0.1:3306/inventory";
	String user = "root";
	String pwd = "1234";
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/purchase.jsp
	
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
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
	
	if(userid == null){
		%>
		<script>
		alert("로그인이 필요한 서비스입니다.");
		location.href = "login.jsp";
		</script>
		<%
	}
	
	//상품정보 받아오기
	DecimalFormat df = new DecimalFormat("###,###");
	
	String pName = "상품명";
	int intPrice = 1000;
	String strPrice = df.format(intPrice);
	
	String strCount = "1";
	int count = Integer.parseInt(strCount);
	int pTotal =  intPrice * count;
	String strPTotal = df.format(pTotal);
	
	int total = 0;
	total += pTotal;
	
	String strTotal = df.format(total);
	
	System.out.println(total);
	//request.setAttribute("totalPrice", total);
	session.setAttribute("strTotal", strTotal);
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
#productTbl{
	border: 1px solid black;
	margin : auto;
	width:100%;
	min-width : 700px;
	padding : 10px;
}
.infoTbl{
	border: 1px solid black;
	margin : auto;
	width:100%;
	min-width : 700px;
	padding : 10px;

}

.infoTbl td{
	text-align : left;
}

.tblLabel{
	font-weight : bold;
	width : 100px;
}

form{
	margin:auto;
	width : 70%;
	min-width : 700px;
}
.detailForm{
	width : 100%;
	margin : auto;
}

.td{
	width : 120px;
	margin : auto;
}

.tdPname{
	text-align : left;
}


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


	<%@include file="top.jsp"%>
	<form name="purchaseForm" id="purchaseForm" method="post">
	
	<div id="productChk" class="detailForm">
	<h3>상품 확인</h3>
	<table id="productTbl">
	<tr><th class="td"></th><th>상품명</th><th class="td">판매가</th><th class="td">수량</th><th class="td">합계</th></tr>
	<tr><td><img src="/img/sample.png" alt="productImg" width="90" height="120"></td><td class="tdPname"><%= pName%></td><td><%= strPrice%></td><td><%= count%></td><td><%= strPTotal%></td></tr>
	</table>
	</div>
	
	<div>
	<h3 class="label">주문 정보</h3>
	<table class="infoTbl">
	<tr><td class="tblLabel">주문자</td><td><%= userName %></td></tr>
	<tr><td class="tblLabel">전화번호</td><td><%= userTelno %></td></tr>
	<tr><td class="tblLabel">이메일</td><td><%= userMail %></td></tr>
	</table>
	</div>
	
	<div>
	<h3 class="label">배송지 입력</h3>
	<table class="infoTbl">
	<tr>
	<td colspan='2'><input type="radio" name="delivery" value="default" checked="checked">기존 정보와 동일&nbsp;&nbsp;
	<input type="radio" name="delivery" value="new">새로운 배송지</td>
	</tr>
	<tr id="deliveryForm">
		<td class="field">이름</td>
			<td><input type="text" id="name" name="name" maxlength="50" value="<%=userName %>">
			<div id="msg_name" class="msg">이름을 입력해주세요.</div>
			</td></tr>
		<tr>
			<td class="field">주소</td>
			<td>
			<input type="text" id="postcode" name="postcode" placeholder="우편번호" value="<%=postCode %>" disabled>
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="address" name="address" placeholder="주소" value="<%=address %>" disabled><br>
			<input type="text" id="detailAddress" name="detailAddress" value="<%=detailAddress %>" placeholder="상세주소">
			<input type="text" id="extraAddress" name="extraAddress" value="<%=extraAddress %>" disabled>
			<div id="msg_address" class="msg">주소지를 입력해주세요.</div></td>
		</tr>
			<tr><td class="field">전화번호</td>
			<td>
				<input type="text" id="telno" name="telno" maxlength="13" value="<%=userTelno %>" />
				
				<div id="msg_telno" class="msg">전화번호를 입력해주세요.</div>
			</td>
			</tr>
	</table>
	</div>
	
	<div>
	<h3 class="label">최종 결제 금액</h3>
	<span id="strTotal"><%=strTotal %></span> 원
	<input type="hidden" name="totalPrice" value="<%=total %>" />
	</div>
	<br>
	
	<div align="center">
		<input type="button" id="btn_purchase" class="btn_purchase" value="결제하기">
	</div>
	
	</form>
	<%@include file="footer.jsp"%>
</body>
<<<<<<< HEAD:SW_miniProject/src/main/webapp/purchase.jsp
=======
</html>
>>>>>>> b3fedd22fbba6d0ed3fddc75570f9461d1f05f94:src/main/webapp/purchase.jsp
