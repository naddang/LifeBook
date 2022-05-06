<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userName = request.getParameter("userName");
	String userPhoneNumber = request.getParameter("userPhoneNumber");
	System.out.println(userName + userPhoneNumber);
	
	UserInfoDBBean manager = new UserInfoDBBean();
	String userID = manager.findId(userName, userPhoneNumber); //아이디를 DB에서 가져온다 실패시 null
%>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::ID찾기 결과</title>
<link rel="stylesheet" href="../css/findIdResult.css">
<script src="../js/findresult.js"></script>
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
	  border: 3px solid #6B5046;
	  border-radius: 6px;
	  width: 400px;
	  height: 240px;
	  margin-top: 30px;
	  margin-bottom: 30px;
	  text-align: center;
	  padding-top: 30xp;
	  display: inline-block;
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
	    margin-top: 20px;
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
	.content1{
		font-size: 20px;
	}
	.content2{
		font-size: 30px;
		font-weight: bold;
	} */
</style>
<script type="text/javascript">
/* 	function linkToOpener(URL) {
		if (window.opener && !window.opener.closed) //부모창이 존재하고 닫혀있지 않을 때
		window.opener.location = URL;               //부모창에서 이동할 주소
		window.close();                             //창닫기
	} */
</script>
</head>
<body>
	<div id="content_area">
		<form name="idsearch" method="post">
	<%
			if(userID != null){
	%>
			<div class="container">
				<div><br>
					<h4 class="content1"> 회원님의 아이디는 </h4>
					<div class="content2"><%=userID%></div>
						<h4 class="content1"> 입니다 </h4><br>
					</div>
				<div>
					<input type="button" class="btn1 btn2 btnFade" value="로그인하러 가기" onclick="linkToOpener('login.jsp')"/>
				</div>
			</div> 
	<%
			}else{
	%>
			<div class="container">
				<div><br><br><br><br>
					<h4 class="p1"> 등록된 정보가 없습니다 </h4>
				</div><br><br><br><br>
				<div class="found-login">
					<input type="button" class="btn1 btn2 btnFade" value="다시 찾기" onclick="history.back()"/>&nbsp
					<input type="button" class="btn1 btn2 btnFade" value="회원가입" onclick="linkToOpener('register.jsp')"/>
				</div>
			</div>
			<%
			}
			%>		
		</form>
	</div>
</body>
</html>