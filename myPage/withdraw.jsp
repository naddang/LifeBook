<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = (String)session.getAttribute("userID");

	if(session.getAttribute("isMember") == null){
		response.sendRedirect("login.jsp");
}
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/withdraw.css">
	<script type="text/javascript" src="sign.js"></script>
	<script src="../js/withdraw.js"></script>
	<style type="text/css">
	/* @font-face {
    font-family: 'GmarketSansLight';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}
	body{
	  background-color: #ede6dd;
	  font-family: 'GmarketSansLight';
	}
	.container {
	  border-radius: 6px;
	  border: 3px solid #6B5046;
	  width: 400px;
	  height: 200px;
	  margin-top: 40px;
	  margin-bottom: 30px;
	  text-align: center;
	  padding-top: 15px;
	  padding-bottom: 5px;
	}
	.btn2{
	    text-align: center;
	}
	.btn1 {
		display: inline;
	    width: 150px;
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
	.title{
		font-size: large;
		font-weight: bold;
	}
	.inputpwd{
		width: 220px;
		height: 25px;
		padding-left: 10px;
	} */
</style>
</head>
<script type="text/javascript">
/* 	function linkToOpener(URL) {
		if (window.opener && !window.opener.closed) //부모창이 존재하고 닫혀있지 않을 때
		window.opener.location = URL;               //부모창에서 이동할 주소
		window.close();                             //창닫기
	}
	
	function withdraw_ok(){
		if(reg_frm.userPWD.value.length == 0){
			alert("비밀번호를 써주세요.");
			reg_frm.userPWD.focus();
			return;
		}
		
		if (confirm('정말 탈퇴하시겠습니까?') == true) {
			document.reg_frm.submit();
		} else {
			alert("회원 탈퇴를 취소했습니다.");
			document.location.href="javascript:linkToOpener('mypage.jsp')";
		}
			
	} */
</script>
<body>
<center>
	<div id="content_area">
	<div class="container">
		<h1 class="title">회원 탈퇴하기</h1><hr>
		<form name="reg_frm" method="post" action="withdrawOk.jsp?userID=<%= userID %>">
						<b>
							>> <%= userID %>님 패스워드를 입력하세요. <<
						</b><br><br>
						<input type="password" name="userPWD" class="inputpwd" placeholder="Password"><br><br>
						<input type="button" class="btn1 btn2 btnFade" value="회원탈퇴" onclick="withdraw_ok()">&nbsp;&nbsp;&nbsp;
						<input type="button" class="btn1 btn2 btnFade" value="취소" onclick="linkToOpener('../intro/intro.jsp')">
		</form>
	</div>
	</div>
</center>
</body>
</html>