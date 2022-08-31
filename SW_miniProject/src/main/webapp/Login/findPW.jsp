<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>

	$(document).ready(function(){
		
		$("#telno").keypress(function(){
			if ((event.keyCode < 48) || (event.keyCode > 57))	event.returnValue = false;
		});
		
		
		$("#telno").keyup(function(){
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
		
		$("#btn_register").click(function(){
			console.log($("id_chk".val));
			//아이디
			if($("#id").val() == '') { $("#msg_id").text("아이디를 입력해주세요."); $("#msg_id").css('display', 'block'); $("#id").focus(); return false;}
			else{	$("#msg_id").css('display', 'none');}
			
			//이름
			if($("#name").val() == '') { $("#msg_name").css('display', 'block'); $("#name").focus(); return false; }
			else{	$("#msg_name").css('display', 'none');}
			
			//전화번호
		 	if($("#telno").val() == '') { $("#msg_telno").css('display', 'block'); $("#telno").focus(); return false;}
		 	else{	$("#msg_telno").css('display', 'none');}
			
			//이메일
		 	var eMail = $("#email").val();
		 	var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		 	
		 	if($("#email").val() == '') {
		 		$("#msg_email").text("이메일주소를 입력하세요."); 
		 		$("#msg_email").css('display', 'block'); 
		 		$("#email").focus();
		 		return false;
		 	}
		 	
		 	else if (!regEmail.test(eMail)) {
		 		$("#msg_email").text("이메일 형식이 올바르지 않습니다.");
		 		$("#msg_email").css('display', 'block');
		 		$("#email").focus();
		 		return false;
		      }
		 	else{
		 		$("#msg_email").css('display', 'none');
		 		}
		 	
			$("#findPWForm").attr("action","findPW_verify.jsp").submit();	
		});
	});	
</script>

<style>
#joinForm{
	margin : auto;
	min-width : 700px;
}

#innerForm{
	margin : auto;
	width : 400px;
}
h3{
	text-align :left;
	margin : 30px 5px;
}

.title{
	display : block;
	margin-bottom : 12px;
	line-height : 17px;
	letter-spacing : -0.1em;
}

.field{
	font-size : 14px;
	line-height:23px;
	width : 100%;
	border : 1px solid #BFBFBF;
	padding : 10px 15px;
	box-sizing : border-box;
}

input:focus{
    outline: none;
}

.row{
	margin : 0px 5px;
	font-size : 14px;
	line-height : 17px;
	margin-bottom : 20px;
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

#btn_register{
	color: #FFFFFF !important;
    background-color: #313131 !important;
    border-color: #313131 !important;
    border-width : 1px;
    transition-duration: 0.4s;
}


#btn_register:hover{
 	opacity : 0.7;
}

.msg{
	font-size:12px;
}

#msg_email, #msg_id, #msg_telno, #msg_name{
	display : none;
	color: red;
}


</style>
<head>
<meta charset="UTF-8">
<title>JSP미니 프로젝트</title>
</head>
<body>
	<%@include file="/top.jsp"%>
	<form name="findPWForm" id="findPWForm" method="post"> 
	<div id="innerForm">
	<h3>비밀번호 찾기</h3>
	<div class="row">
		<label class="title">아이디</label>
		<input type="text" class="field" id="id" name="id" maxlength="50" autofocus autoComplete="off">
		<div id="msg_id" class="msg"></div>
	</div>
	<div class="row">
		<label class="title">이름</label>
		<input type="text" class="field" id="name" name="name" maxlength="50" autoComplete="off">
		<div id="msg_name" class="msg">이름을 입력해주세요.</div>
	</div>
	<div class="row">
		<label class="title">전화번호</label>
		<input type="text" class="field" id="telno" name="telno" maxlength="13" autoComplete="off"  />
		<div id="msg_telno" class="msg">전화번호를 입력해주세요.</div>
	</div>
	<div class="row">
		<label class="title">이메일</label>
		<input type="text" class="field" id="email" name="email" autoComplete="off" />
				<div id="msg_email" class="msg"></div>
	</div>
	<br>
	<div align="center">
		<input type="button" id="btn_register" class="button" value="비밀번호 찾기">
	</div>
	</div>
	</form>
	<%@include file="/footer.jsp"%>
</body>
</html>