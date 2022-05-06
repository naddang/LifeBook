<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::패스워드 찾기</title>
<script type="text/javascript">
/* 	function pwd_search() {
		if (findpwd.userName.value.length < 1) {
			alert("이름을 입력해주세요");
			return;
		}
		
		if (findpwd.userID.value.length < 1) {
			alert("ID를 입력해주세요");
			return;
		}
		
		if (findpwd.userPhoneNumber.value.length != 11) {
			alert("휴대폰번호를 정확하게 입력해주세요");
			return;
		}
		
		findpwd.method = "post";
		findpwd.submit();
	}
	
	function winclose() {
		window.open('','_self').close();
	} */
</script>
<link rel="stylesheet" href="../css/findPwd.css">
<script src="../js/findpwd.js"></script>
<style type="text/css">
	/* @font-face {
    font-family: 'GmarketSansLight';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}
	body{
	    font-family: 'GmarketSansLight';
		text-align: center;
		background-color: #ede6dd;
	}
	.container {
	  border: 3px solid #6B5046;
	  background-color: #ede6dd;
	  border-radius: 6px;
	  width: 400px;
	  height: 330px;
	  margin-top: 30px;
	  margin-bottom: 30px;
	  text-align: center;
	  padding-top: 15px;
	  display: inline-block;
	}
	.btn2{
	    text-align: center;
	}
	.btn1 {
		display: inline;
	    width: 100px;
	    height: 40px;
	    font-size: large;
	    text-align: center;
	    line-height: 10px;
	    color: white;
	    transition: all 0.2s;
	    border: 2px solid #6B5046;
	}
	.btn2 {
	    background: #6B5046;
	}
	.btnFade.btn2:hover{
	    background: #ede6aa;
	}
	#title{
		font-size: 25px;
		font-weight: bold;
	}
	#subtitle{
		font-size: 20px;
		font-weight: bold;
		margin-top: 15px;
	}
	.searchpwd{
		text-align: left;
	}
	.name{
		margin-right: 36px;
		margin-left: 70px;
		font-weight: bold;
	}
	.id{
		margin-right: 3px;
		margin-left: 70px;
		font-weight: bold;
	}
	.tel{
		margin-right: 6px;
		margin-left: 70px;
		font-weight: bold;
	}
	.inputname {
		width: 25;
		height: 25px;
	}
	.inputid {
		width: 25;
		height: 25px;
	}
	.inputtel {
		width: 25;
		height: 25px;
	} */
</style>
</head>
<body>
	<div id="content_area">
	<div class="container">
		<form method="post" name="findpwd" action="findPwdResult.jsp">
			<div>
				<h3 id="title">User Password 찾기</h3><hr>
				<h3 id="subtitle">휴대폰번호 본인 확인</h3><br>
			</div>
			<section class="searchpwd">
				<div>
					<label class="name">이름</label>
					<input type="text" name="userName" class="inputname" placeholder="등록한 이름">
				<br><br>
				</div>
				<div>
					<label class="id">User ID</label>
					<input type="text" name="userID" class="inputid" placeholder="등록한 ID">
				<br><br>
				</div>
				<div>
					<label class="tel">전화번호</label>
					<input type="text" name="userPhoneNumber" class="inputtel" placeholder="등록한 번호를 '-'없이 입력">
				</div>
				<br><br>
			</section>
			<div>
				<input type="button" class="btn1 btn2 btnFade" name="enter" value="찾기" onclick="pwd_search()">&nbsp;
				<input type="button" class="btn1 btn2 btnFade" name="cancel" value="취소" onclick="winclose()">
			</div>	
		</form>
	</div>
	</div>
</body>
</html>