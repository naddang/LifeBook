<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookFAQ.FaqDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
		return;
	}
%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="faq" class="lifeBookFAQ.FaqBean"></jsp:useBean>
<jsp:setProperty property="*" name="faq"/>
<%
	faq.setRegDate(new Timestamp(System.currentTimeMillis()));

	FaqDBBean db = FaqDBBean.getInstance();
	
	int re = db.insertFaq(faq);
	
	if (re == 1) {
		response.sendRedirect("faqList.jsp");
	} else {
		response.sendRedirect("faqWrite.jsp");
	}
%>