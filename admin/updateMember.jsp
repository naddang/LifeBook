<%@page import="java.sql.Timestamp"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="member.managementMemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID2 = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID2);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
	Timestamp userBirth = Timestamp.valueOf(request.getParameter("userBirth"));
%>
<jsp:useBean id="member" class="member.managementMemberBean"></jsp:useBean>
<jsp:setProperty property="userName" name="member"/>    
<jsp:setProperty property="userPhoneNum" name="member"/>    
<jsp:setProperty property="userAddr" name="member"/>    
<jsp:setProperty property="point" name="member"/>    
<%
	member.setUserBirth(userBirth);
	String userID = request.getParameter("userID");
	member.setUserID(userID);
	managementMemberDBBean db = managementMemberDBBean.getInstance();
	int re = db.updateMember(member);
	
	if(re==1){
		//나중에 메인페이지 만들어지면 회원정보 수정 완료 됐을 때 메인 페이지로 가도록 설정
%>
	<script>
		alert("회원정보 수정 완료");
		document.location.href="listMember.jsp";
	</script>
<%
	}else{
%>
	<script>
		alert("회원정보 수정 실패");
		history.go(-1);
	</script>	
<%		
	}
%>			