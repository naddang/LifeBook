<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookFAQ.FaqBean"%>
<%@page import="lifeBookFAQ.FaqDBBean"%>
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
	String pageNum = request.getParameter("pageNum");
	
	FaqDBBean db = FaqDBBean.getInstance();
	int faqNum = Integer.parseInt(request.getParameter("faqNum"));
	
	FaqBean faq = db.getFaq(faqNum);
	
	int re = db.deleteFaq(faqNum);
	
	if (re == 1) {
		response.sendRedirect("faqList.jsp?pageNum=" + pageNum);
	} else if (re == -1) {
%>
	<script>
		alert("삭제에 실패했습니다.");
		history.go(-1);
	</script>
<%
	}
%>