<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = request.getParameter("userID");
	String userPWD = request.getParameter("userPWD");
	
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int re = userDB.deleteUser(userID, userPWD);
	
	if(re == 1){
%>
	<script src="../js/withdrawok.js"></script>
	<script type="text/javascript">
	
/* 	function linkToOpener(URL) {
		if (window.opener && !window.opener.closed) //�θ�â�� �����ϰ� �������� ���� ��
		window.opener.location = URL;               //�θ�â���� �̵��� �ּ�
		window.close();                             //â�ݱ�
	} */
	
		alert("ȸ�� Ż�� �����߽��ϴ�.");
		document.location.href="javascript:linkToOpener('../intro/intro.jsp')";
<%
		session.invalidate();
%>
	</script>
<%
}else if(re == 0){ //�н����� Ʋ��
%>
	<script>
		alert("�н����尡 ���� �ʽ��ϴ�.");
		history.go(-1);
	</script>
<%
}else if(re == -1){ //Ż�� ����
%>
	<script>
		alert("Ż�� �����Ͽ����ϴ�..");
		history.go(-1);
	</script>
<%
}
%>