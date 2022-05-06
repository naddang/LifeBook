<%@page import="userInfo.UserInfoBean"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="org.apache.el.lang.ELSupport"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = request.getParameter("userID");
	String userPWD = request.getParameter("userPWD");
	String userName = request.getParameter("userName");
	String save_chk = request.getParameter("save_chk"); //아이디 저장하기 체크 여부 가져옴
	
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int check = userDB.userCheck(userID, userPWD);
	UserInfoBean user = userDB.getUser(userID);
	
	if(user == null){
%>
		<script>
			alert("존재하지 않는 회원");
			history.go(-1);
		</script>
<%
	}else{
		if(check == 1){
			session.setAttribute("userID", userID);
			session.setAttribute("isMember", "yes");
			session.setAttribute("userName", userName);
			
			if(save_chk != null && save_chk.equals("Y")){  //[아이디 저장하기]체크 확인
				UserInfoDBBean.makeCookie(response, "loginId", userID, 60*60*24); //쿠키생성
			}else{
				UserInfoDBBean.deleteCookie(response, "loginId"); //쿠키삭제
			}
			
			response.sendRedirect("../intro/intro.jsp"); 
		}else if(check == 0){
%>
			<script>
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>
<%
		}else{
%>
			<script>
				alert("아이디가 맞지 않습니다.");
				history.go(-1);
			</script>
<%
			
		}
	}
%>
