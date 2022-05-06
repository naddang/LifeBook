<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="userInfo.UserInfoBean"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<%
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	String userID = (String)session.getAttribute("userID");
	String userPWD = request.getParameter("ori_user_pwd");
	int re_1 = userDB.userCheck(userID, userPWD);
	if(re_1 != 1){
%>
		<script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
<%
	}else{
		user.setUserID(userID);
		int re_2 = userDB.updateUser(user);
		
		if(re_2 == 1){
%>
			<script>
				alert("입력하신 대로 회원 정보가 수정되었습니다.");
				document.location.href="../intro/intro.jsp";
			</script>
<%
		}else{
%>
			<script>
				alert("수정이 실패되었습니다.");
				history.go(-1);
			</script>
<%
		}
	}
%>
	
