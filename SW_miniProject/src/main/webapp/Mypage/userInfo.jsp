<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="userInfo.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.5/dist/web/static/pretendard.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" integrity="sha512-NhSC1YmyruXifcj/KFRWoC561YpHpc5Jtzgvbuzx5VozKpWvQ+4nXhPdFgmx8xqexRcpAglTj9sIBWINXa8x5w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<script>

$(document).ready(function(){

    /*유저 비번 변경 버튼 */
	$("#btn_register_pw").click(function(){
			
			//비밀번호
			var Pass = $("#password").val();
			var Pass1 = $("#passwordchk").val();
			
			console.log(Pass,Pass1);
	
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
			return false;}
	
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
		$("#pwchange").attr("action","join_verify.jsp").submit();
	})
	
	
	/* 유저 정보 변경 버튼 */
	$("#btn_register_info").click(function(){
		
		var address = $("#address").val();
		var extraAddress = $("#extraAddress").val();
		var detailAddress = $("#detailAddress").val();
		var postcode = $("#postcode").val();
		
		if ((address && extraAddress && detailAddress && postcode) == null){
			$("#msg_pw").text("빈 칸 없이 입력 해 주세요.");
			$("#msg_pw").css('display', 'block');
			return false;
		}
		else { $("#msg_pwchk").css('display', 'none');
		$("#infochange").attr("action","change_info.jsp").submit();
		}

})
})


</script>

<!-- 다음 주소  API -->
<script type="text/javascript"> 
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
.msg {
	font-size: 12px;
}

#msg_pwchk, #msg_email, #msg_id, #msg_address, #msg_telno, #msg_name,
	#msg_pw {
	display: none;
	color: red;
}
</style>

<body>
	<%@include file="/top.jsp"%>
	<%
	request.setCharacterEncoding("utf-8");

	String userid = (String) session.getAttribute("userID");

	if (userid == null) {
	%>
	alert("로그인이 필요한 서비스입니다."); location.href = "./login.jsp";s
	<%
	}

	if (userid == null) {
	response.sendRedirect("index.jsp");
	}

	String username = "";
	String password = "";
	String telno = "";
	String postcode = "";
	String address = "";
	String detailAddress = "";
	String extraAddress = "";
	String email = "";

	//DB에서 사용자 정보
	String url = "jdbc:mariadb://127.0.0.1:3306/sw_miniproject";
	String uid = "root";
	String pwd = "0000";
	String query = "select * from user where userid ='" + userid + "'";

	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;

	try {

	Class.forName("org.mariadb.jdbc.Driver");
	con = DriverManager.getConnection(url, uid, pwd);
	stmt = con.createStatement();
	rs = stmt.executeQuery(query); // 쿼리문 실행 코드

	while (rs.next()) {
		username = rs.getString("username");
		password = rs.getString("password");
		telno = rs.getString("telno");
		postcode = rs.getString("postcode");
		address = rs.getString("address");
		detailAddress = rs.getString("detailAddress");
		extraAddress = rs.getString("extraAddress");
		email = rs.getString("email");

	}
	stmt.close();
	con.close();
	rs.close();

	} catch (Exception e) {
	e.printStackTrace();
	}
	%>

	<div id="display-canvas">
		<div class="mypage">

			<div class="container">
				<div class="head-title">
					<div class="heade-title-container">
						<span class="mainTitle">회원 정보</span>
					</div>
					<div class="logout-btn">
						<span href="./logout.jsp">logout</span>
					</div>
				</div>

				<form name=pwchange id=pwchange method="post">
					<div class="left-container">
						<div class="row">
							<label class="title">로그인 아이디</label>
							<input type="text" class="field" readonly="readonly" value="<%=userid%>">
						</div>
						<div class="row">
							<label class="title">회원 이메일</label>
							<input type="text" class="field" readonly="readonly" value="<%=email%>">
						</div>
						<div class="row">
							<label class="title">비밀번호</label>
							<input type="password" class="field" id="password" name="password" maxlength="50" placeholder="영문/숫자/특수문자 모두 포함, 8-20자리">
							<p id="msg_pw" class="msg"></p>
						</div>
						<div class="row">
							<label class="title">비밀번호 확인</label>
							<input type="password" class="field" id="passwordchk" name="passwordchk" maxlength="50">
							<p id="msg_pwchk" class="msg"></p>
							<input type="button" id="btn_register_pw" class="field user-info-modify-btn" value="비밀번호 변경">
						</div>

					</div>
				</form>

				<form name=infochange id=infochange method="post">
					<div class="right-container">
						<div class="row">
							<label class="title">이름</label>
							<input type="text" class="field" readonly="readonly" value="<%=username%>">
						</div>
						<div class="row">
							<label class="title">휴대폰 번호</label>
							<input type="text" class="field" value="<%=telno%>">
							<!-- 나중에 번호인증하는 api 받아와서 적용하면 더 좋을거같아요. -->
						</div>
						<div class="row">
							<label class="title">우편 번호</label>
							<input type="text" name="postcode" id="postcode" class="field" readonly="readonly" value="<%=postcode%>">
							<input type="button" id="btn_address" onclick="execDaumPostcode()" value="우편번호 찾기">
						</div>
						<div class="row">
							<label class="title">주소</label>
							<input type="text" name="address" id="address" class="field " readonly="readonly" value="<%=address%>">
							<input type="text" name="extraAddress" id="extraAddress" class="field" readonly="readonly" value="<%=detailAddress%>">
							<input type="text" name="detailAddress" id="detailAddress" class="field" placeholder="<%=extraAddress%>">
							<p id="msg_pwchk" class="msg"></p>
						</div>
						<div class="row">
							<input type="submit" id="btn_register_info" class="field user-info-modify-btn" value="회원정보 수정">
						</div>
					</div>
					</form>
			</div>
		</div>
		
	</div>




	<%@include file="/footer.jsp"%>
</body>
</html>