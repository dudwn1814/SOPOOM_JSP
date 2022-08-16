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
	
		if($("#p_name").val()=="") { alert("이름을 입력하세요!!!"); $("#p_name").focus(); return false;  }
		if($("#mtitle").val()=="") { alert("제목을 입력하세요!!!");  $("#mtitle").focus(); return false;  }
		if($("#mcontent").val()=="") { alert("내용을 입력하세요!!!");  $("#mcontent").focus(); return false;  }
		
		$('#WriteForm').attr('action', '/board/mWrite').submit();
		
		console.log("p_name = " + $("#p_name").val());
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
            <label class="col-sm-2"> * 상품명 </label>
            <div class="col-sm-3">
               <input type="text" id="p_name" name='p_name' placeholder="여기에 이름을 입력하세요" class="form-control">
            </div>
         </div>
         
         <div class="form-group row">
            <label class="col-sm-2">* 가격(숫자)</label>
            <div class="col-sm3">
              <input type="text" id="mtitle" name='mtitle' placeholder="여기에 제목을 입력하세요" class="form-control">
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">* 수량(숫자)</label>
            <div class="col-sm3">
              <textarea id="mcontent" cols="100" row="500" name='mcontent' placeholder="여기에 내용을 입력하세요" class="form-control"></textarea>
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">제조사</label>
            <div class="col-sm3">
               <input type="hidden" name="msex" value="female" class="form-control">
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">분류</label>
            <div class="col-sm3">
               <input type="text" name="category" class="form-control">
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">재고 수</label>
            <div class="col-sm3">
               <input type="text" name="unitsInStock" class="form-control">
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">상태</label>
            <div class="col-sm5">
               <input type="radio" name="condition" value ="New" 신규 제품>
               <input type="radio" name="condition" value ="Old" 중고 제품>
               <input type="radio" name="condition" value ="Refurbished" 재생 제품>
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