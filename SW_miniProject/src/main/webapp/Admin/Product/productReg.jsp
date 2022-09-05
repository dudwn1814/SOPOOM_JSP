<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시물 등록</title>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="product.css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
	
</script>

<style>
.ImageRegistration {
	border: 2px solid #BFBFBF;
    width: 450px;
    height: 200px;
    text-align: center;
    vertical-align: middle;
    margin: 30px;
    padding: 10px 10px;
    display: table-cell;
}
</style>

<script>
	$(document).ready(function() {
		$("#p_price").focusout(function() {
			$(this).val($(this).val().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		});

		$("#p_price").focusin(function() {
			$(this).val($(this).val().replace(",", ""));
		});

		var objDragAndDrop = $("#ImageRegistration");

		//이미 등록되어져 있는 자바 스크립트의 이벤트 --> 웹브라우저가 수행하는 이벤트
		//드래그는 안돼서 일단 삭제
		
		//drag 영역 클릭시 파일 선택창
		objDragAndDrop.on('click', function(e) {
			$("#fileUpload").trigger('click');
		});

		$("#fileUpload").on('change', function(e) {
			var files = e.originalEvent.target.files;
			imageView(files, objDragAndDrop);
		});
	});
	
	var imgcheck = "N";
	var imgFile = null;
	function imageView(f,obj){

		obj.html("");
		imgFile = f[0];

		//if(imgFile.size > 1024*1024) { alert("1MB 이하 파일만 올려주세요."); return false; }
		if(imgFile.type.indexOf("image") < 0) { alert("이미지 파일만 올려주세요"); return false; }

		const reader = new FileReader();
		reader.onload = function(event){
			obj.html("<img src=" + event.target.result + " id='uploadImg' style='width:350px; height:auto;'>");
		};
		reader.readAsDataURL(imgFile);
		imgcheck = "Y";
	}

	function register() {
		if(imgcheck == "N") { 
			alert("이미지를 업로드하세요."); 
			return false; 
		}
		if ($("#p_name").val() == "") {
			alert("상품명을 입력하세요");
			$("#p_name").focus();
			return false;
		}
		if ($("#p_id").val() == "") {
			alert("상품 코드 입력하세요");
			$("#p_id").focus();
			return false;
		}
		if($("#id_chk").val() == "false"){
			var idInput = document.getElementById("p_id");
			if(idInput.value != ''){
				window.open("pidCheck.jsp?p_id="+idInput.value,"","width=400, height=200");
			}  
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

		$('#WriteForm').attr('action', '/Admin/Product/processAddProduct.jsp')
				.submit();
	}
</script>

</head>
<body>
<%@include file="/top.jsp"%>
	<div align="center">
		<h1 class="editTitle">상품 등록</h1>
		<br>

		<form id="WriteForm" class="WriteForm" method="POST"
			enctype="multipart/form-data">

			<div class="row">
				<label class="title"><p class="mustIn">*</p> 상품이미지</label> <input type="file"
					name="fileUpload" id="fileUpload" style="display: none;" />
					<div class="ImageRegistration" id="ImageRegistration">클릭해서 사진을 등록해 주세요.</div>
			</div>

			<div class="row">
				<label class="title"><p class="mustIn">*</p> 상품이름</label> <input type="text" class="p_name"
					id="p_name" name="p_name">
			</div>

			<div class="row">
				<label class="title"><p class="mustIn">*</p> 상품코드</label> <input type="text" class="p_id"
					id="p_id" name="p_id">
					<input type="hidden" id="id_chk" value="false">
			</div>

			<div class="row">
				<label class="title"><p class="mustIn">*</p> 상품가격</label> <input type="text"
					class="p_price" id="p_price" name="p_price">
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
				<label class="title">분류</label> 
			<select class="p_category" id="p_category" name="category">
				<option value="FRAME">FRAME</option>
				<option value="HOMEWARE">HOMEWARE</option>
				<option value="OBJECT">OBJECT</option>
				<option value="TEXTILE">TEXTILE</option>
			</select>
			</div>

			<div class="row">
				<label class="title"><p class="mustIn">*</p> 재고 수</label> <input type="text"
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

			<button type="button" id="btn_registry" class="button" onclick="register()">등록</button>
			<button id="btn_cancel" class="button"
				onclick="history.back(); return false;">취소</button>

		</form>
	</div>
	<%@include file="/footer.jsp"%>
</body>
</html>