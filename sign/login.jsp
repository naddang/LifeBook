<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>�λ�å��::�α��� ������</title>
<link rel="stylesheet" href="../css/login.css">
<script type="text/javascript">
	function winopenid() {
		var left = Math.ceil((window.screen.width - 600)/2);
		var top = Math.ceil((window.screen.height - 400)/2);
		//��â�� ��� �������� ���� ��, ���̵� ã��
			window.open("findId.jsp","", "width="+600+", height="+400+", left="+left+", top="+top );
	}
	function winopenpwd() {
		var left = Math.ceil((window.screen.width - 600)/2);
		var top = Math.ceil((window.screen.height - 500)/2);
		//��â�� ��� �������� ���� ��, �н����� ã��
			window.open("findPwd.jsp","", "width="+600+", height="+500+", left="+left+", top="+top );
	}
	function pop_close() {
		if(login.userID.value.length == 0){
			alert("ID�� ���ּ���.");
			login.userID.focus();
			return;
		}
		
		
		if(login.userPWD.value.length == 0){
			alert("�н������ �ݵ�� �Է��ؾ� �մϴ�.");
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
		/*CookieManager Ŭ������ �̿��Ͽ� �̸��� loginId�� ��Ű�� �о�� loginId ������ ������.
    	����� ���̵� �ִٸ� �� ���� ���̵� �Է�â�� �⺻������ ���� ����.*/
    	String loginId = UserInfoDBBean.readCookie(request, "loginId");
	
		String cookieCheck = "";
		if(!loginId.equals("")){  //����� ���̵� �ִٸ� loginId�� �� ���ڿ� ���� ���ڿ��� �����ص�
			cookieCheck = "checked";  //cookieCheck�� "checked"�� ���Ե�. [���̵� �����ϱ�]üũ �ڽ��� checked �Ӽ��� �ο��� ����
		}
	%>
<body onload="init()" link="#6B5046" vlink="#6B5046" alink="#6B5046">
	<div class="logo"><img src="../images/LifeBookOriginal.png" width="350" height="120"></div>
	<div class="container">
		<form method="post" action="loginOk.jsp" name="login">
			<h3 style="text-align: center;">�α���</h3><hr>
			<div class="inputform">
			<div class="inputid">
				<input type="text" name="userID" id="userid" placeholder=" ���̵�" value="<%=loginId%>" size="40">
			</div>
			<div class="inputpwd">
				<input type="password" name="userPWD" id="userpwd" placeholder=" ��й�ȣ" size="40">
			</div>
			</div>
				<p style="font-size: small;"><input type="checkbox" id="checkbox" name="save_chk" value="Y" <%= cookieCheck %>>���̵� �����ϱ�</p>
			<div class="btnlogin">
				<input type="submit" value="�α���" class="button btnFade btnlogin" onclick="pop_close()">
			</div>
		</form><br>
			<div id="nomember">��ȸ������ �ֹ��ϼ̳���?</div><br>
			<div>
			<form action="../mall/searchNoMemberOrder.jsp" class="searchno">
				<input type="number" maxlength="10" placeholder="�ֹ���ȣ�� �Է����ּ���" name="orderNum" id="searchON">
				<input type="submit" value="�ֹ���ȸ" class="btn1 btn2 btnFade">
			</form>
			</div>
	</div>
			<div class="btnetc">
					<a href="javascript:winopenid();">ID ã��</a>&nbsp|&nbsp
					<a href="javascript:winopenpwd();">��й�ȣ ã��</a>&nbsp|&nbsp
					<a href="register.jsp">ȸ������</a>&nbsp|&nbsp
					<a href="../intro/intro.jsp">��������</a>
			</div>
</body>
</html>