<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="utf-8">
<title>게시물 등록</title>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
</script>

<script>
	function register() {

		if ($("#p_id").val() == "") {
			alert("상품 코드 입력하세요");
			$("#p_id").focus();
			return false;
		}
		if ($("#p_price").val() == "") {
			alert("가격을 입력하세요");
			$("#p_price").focus();
			return false;
		}
		if ($("#p_amount").val() == "") {
			alert("수량을 입력하세요");
			$("#p_amount").focus();
			return false;
		}
		
		$('#WriteForm').attr('action', '/Admin/Product/processAddProduct.jsp').submit();
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
		<form id="WriteForm" class="form-horizontal" method="POST"
			enctype="multipart/form-data">

			<div class="form-group row">
				<label class="col-sm-3"> * 상품 이미지 </label>
				<div class="col-sm-3">
					<input type="file" name="p_filename">
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-3"> * 상품명 </label>
				<div class="col-sm-3">
					<input type="text" name="p_name" class="form-control">
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2"> 상품 코드 </label>
				<div class="col-sm-3">
					<input type="text" name="p_id" id="p_id" class="form-control">
				</div>
			</div>

			<div class="form-group row">
				<label class="col-sm-2">가격</label>
				<div class="col-sm3">
					<input type="text" name="p_price" id="p_price" class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상세 정보</label>
				<div class="col-sm3">
					<textarea name="description" cols="50" rows="2"
						class="form-control"></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm3">
					<input type="text" name="manufacturer" class="form-control">
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
					<input type="text" name="p_amount" id="p_amount"  class="form-control">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm5">
					<input type="radio" name="condition" value="New"> 신규 제품 
					<input type="radio" name="condition" value="Old"> 중고 제품 
					<input type="radio" name="condition" value="Refurbished"> 재생 제품
				</div>
			</div>
			<div class="form-group row">
				<div class="col-offset-2 col-sm-10">
					<input type="button" onclick="register()" class="btm btm-primary"
						value="등록">
				</div>
			</div>
		</form>
	</div>
</body>
</html>