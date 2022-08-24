<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="utf-8">
<title>게시물 등록</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
function register(){
	
		if($("#p_name").val()=="") { alert("상품명을 입력하세요!!!"); $("#p_name").focus(); return false;  }
		if($("#p_price").val()=="") { alert("가격을 입력하세요!!!");  $("#p_price").focus(); return false;  }
		if($("#p_amount").val() <= 0) { alert("수량을 입력하세요!!!");  $("#p_amount").focus(); return false;  }
		
		$('#WriteForm').attr('action', '/Admin/Product/productReg').submit();
}

</script>

</head>   
<body>
   <div class="jumbotron">
      <div class="container">
         <h1 class="display-3">상품 등록</h1>
      </div>
   </div>
   <div class="container">
      <form id="WriteForm" class="form-horizontal" method="POST" enctype="multipart/form-data">
      
      	<div class="form-group row">
            <label class="col-sm-3"> * 상품 이미지 </label>
            <div class="col-sm-3">
               <input type="file" name="uploadFile">
            </div>
         </div>

         <div class="form-group row">
            <label class="col-sm-3"> * 상품명 </label>
            <div class="col-sm-3">
               <input type="text" id="p_name" name="p_name" placeholder="여기에 이름을 입력하세요" class="form-control">
            </div>
         </div>
         
         <div class="form-group row">
            <label class="col-sm-3">* 가격(숫자) </label>
            <div class="col-sm3">
              <input type="text" id="p_price" name="p_price" placeholder="여기에 가격을 입력하세요" class="form-control">
            </div>
         </div>
         
         <div class="form-group row">
            <label class="col-sm-3">* 수량(숫자) </label>
            <div class="col-sm3">
              <input type="number" id="p_amount" name="p_amount" class="form-control"></input>
            </div>
         </div>
         
         <div class="form-group row">
            <div class="col-offset-2 col-sm-10">
               <input type="button" onclick="register()" class="btm btm-primary" value = "등록">
            </div>
         </div>
      </form>
   </div>

</body>
</html>