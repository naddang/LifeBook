<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String userID = request.getParameter("userID");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/registerIdCheck.css">
<script src="../js/registeridcheck.js"></script>
<style type="text/css">
/* 	@font-face {
    font-family: 'GmarketSansLight';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}
	body{
		font-family: 'GmarketSansLight';
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
	.btnid {
		width: 111px;
	}
	.inputid {
		width: 145px;
		height: 25px;
	} */
</style>
</head>
<body style="background-color:#EDE6DD;">
<center>
<h2>아이디 중복 체크</h2>

<%	
	UserInfoDBBean manager = new UserInfoDBBean();
	
	int result = manager.registerIdCheck(userID);
	if(result == 1){
		out.print("사용가능한 아이디입니다.");
		%>
			<input type="button" class="btn1 btn2 btnFade btnid" value="아이디 사용하기" onclick="result();">
		<%
	}else if(result == 0){
		out.print("이미 존재하는 아이디입니다.");
	}else{
		out.print("에러 발생!"); // result값이 -1이 나옴
	}
%>
	<br><br>
	<form action="registerIdCheck.jsp" method="post" name="chk_frm">
		User ID : <input type="text" class="inputid" name="userID" value="<%= userID %>">
		<input type="submit" class="btn1 btn2 btnFade" value="중복 확인">
	</form>
	
	<script type="text/javascript">
/* 		function result() {
			opener.document.reg_frm.userID.value = document.chk_frm.userID.value;
			
			opener.document.reg_frm.userID.readOnly=true;
			
			window.close();
		} */
	</script>
</center>
</body>
</html>