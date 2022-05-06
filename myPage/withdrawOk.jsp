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
		if (window.opener && !window.opener.closed) //부모창이 존재하고 닫혀있지 않을 때
		window.opener.location = URL;               //부모창에서 이동할 주소
		window.close();                             //창닫기
	} */
	
		alert("회원 탈퇴에 성공했습니다.");
		document.location.href="javascript:linkToOpener('../intro/intro.jsp')";
<%
		session.invalidate();
%>
	</script>
<%
}else if(re == 0){ //패스워드 틀림
%>
	<script>
		alert("패스워드가 맞지 않습니다.");
		history.go(-1);
	</script>
<%
}else if(re == -1){ //탈퇴 실패
%>
	<script>
		alert("탈퇴에 실패하였습니다..");
		history.go(-1);
	</script>
<%
}
%>