<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시물 수정</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	
	$("#btn_modify").click(function(){
		
		if($("#p_amount").val() <= 0) { alert("수량을 입력하세요!!!"); $("#p_amount").focus(); return false;  }
	
		$("#ModifyForm").attr("action", "/Admin/Inventory/inventoryOrder?p_id=${list.p_id}").submit();
	
	})
	
	$("#btn_delete").click(function(){
		
		$("#ModifyForm").attr("action", "/Admin/Inventory/inventoryDelete?p_id=${list.p_id}").submit();
	
	})

})

</script>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }

.ModifyForm {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align: center;
  border:4px solid gray;
  border-radius: 30px;
}

.p_id, .p_name, .p_price, .p_amount, .p_image {
  width: 90%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 20px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.btn_modify, .btn_delete {
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: red;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}
</style>

</head>   
<body>

	<h1>발주 페이지</h1>
	<br>

<form id="ModifyForm" class="ModifyForm" method="POST">
		<div class="p_image">상품이미지 : ${list.filename}</div>
		<div class="p_id">상품번호 : ${list.p_id}</div>
		<div class="p_name">상품이름 : ${list.p_name}</div>
		<div class="p_price">상품가격 : ${list.p_price} \</div>
		<div class="p_amount">상품수량 :  
				 <input type="number" id="p_amount" name='p_amount' value=${list.p_amount}>
		</div>
	<button id="btn_modify" class="btn_modify">수정</button>
	<button id="btn_delete" class="btn_delete">삭제</button>
</form>

</body>
</html>