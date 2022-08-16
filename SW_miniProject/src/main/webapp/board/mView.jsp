<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>게시물 내용 보기</title>
</head>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }
a:link { color: black; }
a:visited { color: black; }
a:hover { color: red; }
a:active { color: red; }
#hypertext { text-decoration-line: none; cursor: hand; }
#topBanner {
       margin-top:10px;
       margin-bottom:10px;
       max-width: 500px;
       height: auto;
       display: block; margin: 0 auto;
}

.boardView {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  border:4px solid gray;
  border-radius: 20px;
}

.mwriter, .mtitle, .mregDate, .mcontent, .filename {
  width: 90%;
  height:25px;
  outline:none;
  color: #636e72;
  font-size:16px;
  background: none;
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}

.textArea {
  width: 90%;
  height: 350px;
  overflow: auto;
  margin: 22px;
  padding: 10px;
  box-sizing: border-box;
  border: solid #adadad;
  text-align: left;
  font-size: 16px;
  resize: both;
}

.btn_modify  {
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

.btn_delete  {
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: pink;
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

<script>

$(document).ready(function(){
	
	$("#btn_modify").click(function(){
			location.href="/board/mModify?p_id=${list.p_id}"
	}) //End of $("btn_modify")

	$("#btn_delete").click(function(){
		if(confirm("정말로 삭제하시겠습니까?") == true)
			location.href="/board/mDelete?p_id=${list.p_id}"
    }) //End of $("btn_delete")
	
    $("#btn_mreply").click(function(){
    	replyRegister();	
    }) //End of $("#btn_mreply")
	
	
}) //End of $(document).ready(function)



function startupPage(){
	
	var queryString = { "p_id": ${list.p_id} };
	$.ajax({
		url : "/board/mReply?option=L",
		type : "post",
		dataType : "json",
		data : queryString,
		success : replyList,
		error : function(data) {
						alert("서버 오류로 댓글 불러 오기가 실패했습니다.");
              	    	return false;
				}
	}); //End od ajax
}

function fileDownload(){
	
	location.href="/board/fileDownload?p_id=${list.p_id}"
}

</script>
<body onload="startupPage()">

<div>
	<img id="topBanner" src ="/images/logo.jpg" title="서울기술교육센터" >
</div>

	<h1>게시물 내용 보기</h1>
	<br>
	<div class="boardView">
		<div class="mwriter">이름 : ${list.p_id}</div>
		<div class="mtitle">제목 : ${list.p_name}</div>
		<div class="mregDate">날짜 : ${list.p_price}</div>
		<div class="textArea"><pre>${list.p_amount}</pre></div>
		<div class="filename">파일명 : <a href="javascript:fileDownload()">${list.p_name}</a></div>
		<center><div><button class="btn_modify" id="btn_modify">수정</button> 
		<button class="btn_delete" id="btn_delete">삭제</button></div></center>
	</div>

</body>
</html>