<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>인생책방::로그인 페이지</title>
<link rel="stylesheet" href="../css/login.css">
<script type="text/javascript">
	function winopenid() {
		var left = Math.ceil((window.screen.width - 600)/2);
		var top = Math.ceil((window.screen.height - 400)/2);
		//새창을 열어서 페이지를 오픈 후, 아이디 찾기
			window.open("findId.jsp","", "width="+600+", height="+400+", left="+left+", top="+top );
	}
	function winopenpwd() {
		var left = Math.ceil((window.screen.width - 600)/2);
		var top = Math.ceil((window.screen.height - 500)/2);
		//새창을 열어서 페이지를 오픈 후, 패스워드 찾기
			window.open("findPwd.jsp","", "width="+600+", height="+500+", left="+left+", top="+top );
	}
	function pop_close() {
		if(login.userID.value.length == 0){
			alert("ID를 써주세요.");
			login.userID.focus();
			return;
		}
		
		
		if(login.userPWD.value.length == 0){
			alert("패스워드는 반드시 입력해야 합니다.");
			login.userPWD.focus();
			return;
		}
		
		document.login.action="loginOk.jsp";
		document.login.target=opener.window.name;
		document.login.submit();
		window.close();
	}
	pop_close();
</script>
</head>
	<%
		/*CookieManager 클래스를 이용하여 이름이 loginId인 쿠키를 읽어와 loginId 변수에 저장함.
    	저장된 아이디가 있다면 이 값이 아이디 입력창의 기본값으로 쓰일 것임.*/
    	String loginId = UserInfoDBBean.readCookie(request, "loginId");
	
		String cookieCheck = "";
		if(!loginId.equals("")){  //저장된 아이디가 있다면 loginId에 빈 문자열 외의 문자열을 저장해둠
			cookieCheck = "checked";  //cookieCheck에 "checked"가 대입됨. [아이디 저장하기]체크 박스에 checked 속성이 부여될 것임
		}
	%>
<body onload="init()" link="#6B5046" vlink="#6B5046" alink="#6B5046">
	<div class="logo"><img src="../images/LifeBookOriginal.png" width="350" height="120"></div>
	<div class="container">
		<form method="post" action="loginOk.jsp" name="login">
			<h3 style="text-align: center;">로그인</h3><hr>
			<div class="inputform">
			<div class="inputid">
				<input type="text" name="userID" id="userid" placeholder=" 아이디" value="<%=loginId%>" size="40">
			</div>
			<div class="inputpwd">
				<input type="password" name="userPWD" id="userpwd" placeholder=" 비밀번호" size="40">
			</div>
			</div>
				<p style="font-size: small;"><input type="checkbox" id="checkbox" name="save_chk" value="Y" <%= cookieCheck %>>아이디 저장하기</p>
			<div class="btnlogin">
				<input type="submit" value="로그인" class="button btnFade btnlogin" onclick="pop_close()">
			</div>
		</form><br>
			<div id="nomember">비회원으로 주문하셨나요?</div><br>
			<div>
			<form action="../mall/searchNoMemberOrder.jsp" class="searchno">
				<input type="number" maxlength="10" placeholder="주문번호를 입력해주세요" name="orderNum" id="searchON">
				<input type="submit" value="주문조회" class="btn1 btn2 btnFade">
			</form>
			</div>
	</div>
			<div class="btnetc">
					<a href="javascript:winopenid();">ID 찾기</a>&nbsp|&nbsp
					<a href="javascript:winopenpwd();">비밀번호 찾기</a>&nbsp|&nbsp
					<a href="register.jsp">회원가입</a>&nbsp|&nbsp
					<a href="../intro/intro.jsp">메인으로</a>
			</div>
</body>
</html>