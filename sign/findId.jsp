<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::ID찾기</title>
<script type="text/javascript">
/* 	function id_search() {
		if (findid.userName.value.length < 1) {
			alert("이름을 입력해주세요");
			return;
		}
		
		if (findid.userPhoneNumber.value.length != 11) {
			alert("휴대폰번호를 정확하게 입력해주세요");
			return;
		}
		
		findid.method = "post";
		findid.submit();
	}
	
	function winclose() {
		window.open('','_self').close();
	} */
</script>
<link rel="stylesheet" href="../css/findId.css">
<script src="../js/findid.js"></script>
<style type="text/css">
	/* @font-face {
    font-family: 'GmarketSansLight';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}
	body{
		text-align: center;
		background-color: #ede6dd;
		font-family: 'GmarketSansLight';
	}
	.container {
	  border: 3px solid #6B5046;
	  background-color: #ede6dd;
	  border-radius: 6px;
	  width: 400px;
	  height: 280px;
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
	    text-align: center;
	    line-height: 10px;
	    font-size: large;
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
	.searchid{
		text-align: left;
	}
	.name{
		margin-right: 39px;
		margin-left: 70px;
		font-weight: bold;
	}
	.tel{
		margin-right: 8px;
		margin-left: 70px;
		font-weight: bold;
	}
	.inputname {
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
		<form method="post" name="findid" action="findIdResult.jsp">
			<div>
				<h2 id="title">User ID 찾기</h2><hr>
				<h3 id="subtitle">휴대폰번호 본인 확인</h3><br>
			</div>
			<section class="searchid">
				<div>
					<label class="name">이름</label>
					<input type="text" name="userName" class="inputname" placeholder="등록한 이름">
					<br><br>
				</div>
				<div>
					<label class="tel">전화번호</label>
					<input type="text" name="userPhoneNumber" class="inputtel" placeholder="등록한 번호를 '-'없이 입력">
				</div>
				<br><br>
			</section>
			<div>
				<input type="button" class="btn1 btn2 btnFade" name="enter" value="찾기" onclick="id_search()">&nbsp
				<input type="button" class="btn1 btn2 btnFade" name="cancel" value="취소" onclick="winclose()">
			</div>	
		</form>
	</div>
	</div>
</body>
</html>