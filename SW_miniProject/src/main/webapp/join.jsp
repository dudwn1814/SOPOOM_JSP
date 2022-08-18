<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>

	$(document).ready(function(){
		$("#btn_register").click(function(){
			console.log($("id_chk".val));
			//아이디
			if($("#id").val() == '') { $("#msg_id").text("아이디를 입력해주세요."); $("#msg_id").css('display', 'block'); $("#id").focus(); return false;}
			else if	($("#id_chk").val() == "false"){ $("#msg_id").text("중복체크를 해주세요"); $("#msg_id").css('display', 'block'); $("#id").focus(); return false;}
			else{	$("#msg_id").css('display', 'none');}
						
			//비밀번호 
			var Pass = $("#password").val();
			var Pass1 = $("#passwordchk").val();
			
			// 암호유효성 검사
			var num = Pass.search(/[0-9]/g);
		 	var eng = Pass.search(/[a-z]/ig);
		 	var spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);	
			
		 	if(Pass == '') {
				$("#msg_pw").text("비밀번호를 입력하세요."); 
		 		$("#msg_pw").css('display', 'block'); 
				$("#password").focus();
				if(Pass1 == ''){
					$("#msg_pwchk").css('display', 'none');
				}
				return false;
			}

		 	else if(Pass.length < 8 || Pass.length > 20) {
				$("#msg_pw").text("비밀번호의 길이는 8~20로 입력해주세요."); 
		 		$("#msg_pw").css('display', 'block');
		 		return false;
				}
			else if(Pass.search(/\s/) != -1){
				$("#msg_pw").text("비밀번호는 공백 없이 입력해주세요."); 
 				$("#msg_pw").css('display', 'block'); 
 				return false;
				}
			else if(num < 0 || eng < 0 || spe < 0 ){
				$("#msg_pw").text("비밀번호는 영문/숫자/특수문자를 혼합해야 합니다."); 
		 		$("#msg_pw").css('display', 'block');
		 		return false;
			}
			else{
				$("#msg_pw").css('display', 'none');
			}
			
			//비밀번호 재입력
			
			if(Pass != Pass1) { 
				$("#msg_pwchk").text("비밀번호가 일치하지 않습니다."); 	
				$("#msg_pwchk").css('display', 'block'); 
				$("#passwordchk").focus(); 
				return false;
			}
			else{	$("#msg_pwchk").css('display', 'none');}
			
			//이름
			if($("#name").val() == '') { $("#msg_name").css('display', 'block'); $("#name").focus(); return false; }
			else{	$("#msg_name").css('display', 'none');}
			
			
			//주소
			if($("#detailAddress").val() == ''){ $("#msg_address").css('display', 'block'); $("#detailAddress").focus(); return false; }
			else{	$("#msg_address").css('display', 'none');}
			
			//전화번호
		 	if($("#telno").val() == '') { $("#msg_telno").css('display', 'block'); $("#telno").focus(); return false;}
		 	else{	$("#msg_telno").css('display', 'none');}
			
			//이메일
		 	var eMail = $("#email").val();
		 	var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		 	
		 	if($("#email").val() == '') {
		 		$("msg_email").text("이메일주소를 입력하세요."); 
		 		$("#msg_email").css('display', 'block'); 
		 		$("#email").focus();
		 		return false;
		 	}
		 	
		 	else if (!regEmail.test(eMail)) {
		 		$("msg_email").text("이메일 형식이 올바르지 않습니다.");
		 		$("#msg_email").css('display', 'block');
		 		$("#email").focus();
		 		return false;
		      }
		 	else{
		 		$("#msg_email").css('display', 'none');
		 		}
		 	
		 	$("#postcode").attr("disabled", false);
		 	$("#address").attr("disabled", false);
		 	$("#extraAddress").attr("disabled", false);
		 	
			$("#registerForm").attr("action","join_verify.jsp").submit();	
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
    
	function onlyNumber() {
    	if ((event.keyCode < 48) || (event.keyCode > 57))	event.returnValue = false;
    	}
    
    function validCheck(){
	   	var idInput = document.getElementById("id");
	   	if(idInput.value == ''){
	   		var msg_id = document.getElementById("msg_id");
	   		msg_id.innerHTML="아이디를 입력해주세요.";
	   		msg_id.style.display='block';
	   		idInput.focus();
	   	}
	   	else{
	   		window.open("idCheck.jsp?id="+idInput.value,"","width=300, height=50");
	   	}
    }

</script>



<style>
.field{
	border: 1px white solid;
	text-align: center;
	padding: 5px;
	margin: 5px;
}

.btn_register{
	padding: 5px;
	width : 180px;
	margin : 5px
}

.msg{
	font-size:12px;
}

#msg_pwchk, #msg_email, #msg_id, #msg_address, #msg_telno, #msg_name, #msg_pw{
	display : none;
	color: red;
}


</style>
<head>
<meta charset="UTF-8">
<title>JSP미니 프로젝트</title>
</head>
<body>
	<%@include file="top.jsp"%>
	<h1 align="center">회원가입</h1>
	<form name="registerForm" id="registerForm" method="post"> 
	<table style="border: 1px solid black" width="600px" align="center">
			<tr>
				<td class="field">아이디</td>
				<td><input type="text" id="id" name="id" maxlength="50">
				<input type="hidden" id="id_chk" value="false">
				<input type="button" onclick="validCheck()" value="중복확인"><br>
				<div id="msg_id" class="msg"></div>
				</td>
			</tr>
			<tr>
				<td class="field">비밀번호</td>
				<td><input type="password" id="password" name="password" maxlength="50">
				<div class="msg">(영문/숫자/특수문자 모두 포함, 8-20자리)</div>
				<div id="msg_pw" class="msg"></div>
				</td>
			</tr>
			<tr>
				<td class="field">비밀번호 확인</td>
				<td><input type="password" id="passwordchk" name="passwordchk" maxlength="50">
				<div id="msg_pwchk" class="msg"></div>
				</td>
			</tr>
			<tr><td class="field">이름</td>
				<td><input type="text" id="name" name="name" maxlength="50">
				<div id="msg_name" class="msg">이름을 입력해주세요.</div>
				</td></tr>
			<tr>
				<td class="field">주소</td>
				<td>
				<input type="text" id="postcode" name="postcode" placeholder="우편번호" disabled>
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="address" name="address" placeholder="주소" disabled><br>
				<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소">
				<input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목" disabled>
				<div id="msg_address" class="msg">주소지를 입력해주세요.</div></td>
			</tr>
			<tr>
			<tr><td class="field">전화번호</td>
			<td>
				<input type="text" id="telno" name="telno" maxlength="11" onkeypress="onlyNumber();" />
				<div id="msg_telno" class="msg">전화번호를 입력해주세요.</div>
			</td></tr>
			<tr><td class="field">이메일</td>
			<td>
				<input type="text" id="email" name="email" />
				<div id="msg_email" class="msg"></div>
			</td></tr>
	</table>
	<br>
	<div align="center">
		<input type="button" id="btn_register" class="btn_register" value="회원가입">
	</div>
	</form>
	<%@include file="footer.jsp"%>
</body>
</html>