<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookNotice.NoticeDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="notice" class="lifeBookNotice.NoticeBean"></jsp:useBean>
<jsp:setProperty property="*" name="notice"/>
<%
	notice.setRegDate(new Timestamp(System.currentTimeMillis()));
	
	NoticeDBBean db = NoticeDBBean.getInstance(); 
	
	int re = db.insertNotice(notice);
	
	if (re == 1) {
		response.sendRedirect("list.jsp");
	} else {
		response.sendRedirect("write.jsp");	
	}
%>