<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="member.managementMemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<jsp:useBean id="member" class="member.managementMemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%
	String userID2 = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID2);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<%
	String userID = request.getParameter("userID");
	String userPWD = request.getParameter("userPWD");
	managementMemberDBBean db = managementMemberDBBean.getInstance();
	int re = db.deleteMemberAdmin(userID, userPWD);
	
	if(re==1){
%>
	<script>
		alert("회원 삭제 성공");
		location.href="listMember.jsp";
	</script>
<%		
	}else{
%>
	<script>
		alert("삭제 실패");
		history.go(-1);
	</script>
<%		
	}
%>