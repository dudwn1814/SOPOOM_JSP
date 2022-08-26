<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시물 등록</title>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="product.css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
	
</script>

<script>
$(document).ready(function(){
	$("#p_price").focusout(function(){
		$(this).val( $(this).val().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	});									
	
	$("#p_price").focusin(function(){
		$(this).val( $(this).val().replace(",", ""));
	});
});

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
			alert("재고 수량을 입력하세요");
			$("#p_amount").focus();
			return false;
		}

		$('#WriteForm').attr('action', '/Admin/Product/processAddProduct.jsp').submit();
	}
</script>

</head>
<body>
	<div align="center">
		<h1 class="editTitle">상품 등록</h1>
		<br>

		<form id="WriteForm" class="WriteForm" method="POST"
			enctype="multipart/form-data">

			<div class="row">
				<label class="title">상품이미지</label> <input type="file"
					name="p_filename" class="p_image" id="p_image">
			</div>

			<div class="row">
				<label class="title">상품이름</label> <input type="text" class="p_name"
					id="p_name" name="p_name">
			</div>

			<div class="row">
				<label class="title">* 상품코드</label> <input type="text" class="p_id"
					id="p_id" name="p_id">
			</div>

			<div class="row">
				<label class="title">* 상품가격</label> <input type="text" class="p_price"
					id="p_price" name="p_price">
			</div>

			<div class="row">
				<label class="title">상세 정보</label>
				<textarea name="description" cols="50" rows="2"
					class="p_description"></textarea>
			</div>

			<div class="row">
				<label class="title">제조사</label> <input type="text"
					class="p_manufacturer" id="p_manufacturer" name="manufacturer">
			</div>

			<div class="row">
				<label class="title">분류</label> <input type="text"
					class="p_category" id="p_category" name="category">
			</div>

			<div class="row">
				<label class="title">* 재고 수</label> <input type="text"
					class="p_amount" id="p_amount" name="p_amount">
			</div>

			<div class="row">
				<label class="title">상태</label>
				<div class="col-sm5">
					<input type="radio" name="condition" value="New"> 신규 제품 <input
						type="radio" name="condition" value="Old"> 중고 제품 <input
						type="radio" name="condition" value="Refurbished"> 재생 제품
				</div>
			</div>

			<button id="btn_registry" class="btn_registry" onclick="register()">등록</button>
			<button id="btn_cancel" class="btn_cancel" onclick="history.back(); return false;">취소</button>

		</form>
	</div>
</body>
</html>