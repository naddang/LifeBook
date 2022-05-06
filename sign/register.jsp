<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/register.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script src="../js/register.js"></script>
<script src="../js/sign.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
	/* @font-face {
    font-family: 'GmarketSansLight';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}
	body{
	  background-color: #ede6dd;
	  text-align: center;
	  font-family: 'GmarketSansLight';
	}
	.container {
	  border-radius: 6px;
 	  width: 305px;
	  height: 630px;
	  display: inline-block;
	  margin-top: 10px;
	}
	.btn1 {
		display: inline;
	    width: 75px;
	    height: 30px;
	    text-align: center;
	    line-height: 10px;
	    color: white;
	    transition: all 0.2s;
	    border: 2px solid #6B5046;
	    font-family: 'HallymMjo-Regular';
	    
	}
	.btn2 {
	    background: #6B5046;
	}
	.btnFade.btn2:hover{
	    background: #ede6aa;
	}
	.tel2, .tel3{
		width: 40px;
	}
	#subject {
		font-size: large;
		font-weight: bold;
	}
	#reference {
		margin-top: 10px;
	}
	.box {
		height: 30px;
		width: 300px;
		padding-left: 5px;
	    font-family: 'HallymMjo-Regular';
	}
	.title{
		text-align: left;
		margin-left: 5px;
		margin-bottom: 3px;
		margin-top: 10px;
		font-weight: bold;
	}
	.idbox {
		width: 220px;
	}
	.idchk {
		width: 75px;
		padding-left: 0px;
	}
	.telbox {
	    font-family: 'HallymMjo-Regular';
		padding-left: 5px;
		height: 30px;
		width: 90px;
	}
	.postbox {
		width: 200px;
		margin-bottom: 5px;
	}
	.roadbox {
		margin-bottom: 5px;
	}
	.detailbox {
		margin-bottom: 5px;
	}
	.postchk {
		width: 95px;
		padding-left: 0px;
	}
	.birthbox {
		width: 97px;
	}
	.top{
		font-family: 'HallymMjo-Regular';
	}
	fieldset {
		border: 1px solid #66310d;
		border-radius: 20px;
		width: 1008px;
		height: 700px;
		margin: 50 auto;
		margin-top: 20px;
	}
	.outer {
		align-content: center;
	} */
</style>

	<script>
		/* function winopen() {
			var left = Math.ceil((window.screen.width - 400)/2);
			var top = Math.ceil((window.screen.height - 200)/2);
			//새창을 열어서 페이지를 오픈 후, 회원 아이디 정보를 가지고 중복체크
			if (reg_frm.userID.value =="" || reg_frm.userID.value.length < 0) {
				alert("아이디는 반드시 입력해야합니다.")
				reg_frm.userID.focus();
			}else {
				window.open("registerIdCheck.jsp?userID="+reg_frm.userID.value,"", "width="+400+", height="+200+", left="+left+", top="+top );
			}
		}
		
		function findAddr(){
			var width = 500; //팝업창의 너비
			var height = 600; //팝업창의 높이
			var left = (window.screen.width*0.5)-(width*0.5); //잘 구동되는데 /2를 사용하면 밑줄이 그임
			var top = (window.screen.height*0.5)-(height*0.5); //그래서 *0.5를 줬다
			new daum.Postcode({
				width: width,
				height: height,
				oncomplete: function(data) {
					
						console.log(data);
					//팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					//도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					//내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다
					var roadAddr = data.roadAddress; //도로명 주소 변수
					var jibunAddr = data.jibunAddress; //지번 주소 변수
					
					//우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postAddr1').value = data.zonecode;
					
					if (roadAddr !== '') {
						document.getElementById('postAddr2').value = roadAddr;
					}else if (jibunAddr !== '') {
						document.getElementById('postAddr2').value = jibunAddr;
					}
				}
			}).open({
				left: left,
				top: top
			});
		} */
	</script>
	
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
	<fieldset>
	<legend id="subject">회원 가입 신청</legend>
	<div class="top">
		<p id="reference">'*' 표시 항목은 필수 입력 항목입니다.</p>
	</div>
		<div class="container">
			<hr>
			<form name="reg_frm" method="post" action="registerOk.jsp">
				<div class="title">User ID*</div>
				<div class="title">
					<input type="text" class="box idbox" name="userID" placeholder="User ID">
					<input type="button" class="box idchk btn1 btn2 btnFade" value="중복확인" onclick="winopen()">
				</div>
				<div class="title">암호*</div>
				<div>
					<input type="password" class="box" size="20" name="userPWD" placeholder="Password">
				</div>
				<div class="title">암호 확인*</div>
				<div>
					<input type="password" size="20" class="box" name="userPWD_check" placeholder="Check Password">
				</div>
				<div class="title">이 름*</div>
				<div>
					<input type="text" size="20" class="box" height="20" name="userName" placeholder="이름">
				</div>
				<div class="title">전화번호*</div>
				<div>
					<select name="user_tel1" class="telbox">
						<option value="010" selected="selected">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="019">019</option>
					</select>
					-
					<input type="number" size="4" name="user_tel2" maxlength="4" class="telbox">
					-
					<input type="number" size="4" name="user_tel3" maxlength="4" class="telbox">
				</div>
				<div class="title">주 소*</div>
				<div>
					<input type="text" class="box postbox" id="postAddr1" name="postAddr1" placeholder="우편번호">
					<input type="button" onclick="findAddr()" value="우편번호 찾기" class="box postchk btn1 btn2 btnFade">
				</div>
				<div class="addr2">
					<input type="text" size="30" class="box roadbox" id="postAddr2" name="postAddr2" placeholder="도로명 주소"><br>
					<input type="hidden" class="box" placeholder="지번주소" id="user_jibunAddr">
				</div>
				<div class="addr3">
					<input type="text" size="30" class="box detailbox" name="postAddr3" placeholder="상세 주소" id="postAddr3">
				</div>
				<div class="title">생년월일*</div>
				<div>
					<input type="text" name="year" class="box birthbox" maxlength="4" placeholder="연(4자)" size="5">
					<select name="month" class="box birthbox">
	                       <option value="01">1월</option>
	                       <option value="02">2월</option>
	                       <option value="03">3월</option>
	                       <option value="04">4월</option>
	                       <option value="05">5월</option>
	                       <option value="06">6월</option>
	                       <option value="07">7월</option>
	                       <option value="08">8월</option>
	                       <option value="09">9월</option>                                    
	                       <option value="10">10월</option>
	                       <option value="11">11월</option>
	                       <option value="12">12월</option>
	                   </select>
	                   <input type="text" name="date" class="box birthbox" maxlength="2" placeholder="예)01일" size="5">
				</div><br><br><br>
				<div>
					<input type="button" class="btn1 btn2 btnFade" value="가입하기" onclick="check_ok()">&nbsp&nbsp&nbsp
					<input type="reset" class="btn1 btn2 btnFade" value="다시입력">&nbsp&nbsp&nbsp
					<input type="button" class="btn1 btn2 btnFade" value="가입안함" onclick="javascript:window.location.href='login.jsp'">
				</div>
			</form>
		</div>
	</fieldset>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>