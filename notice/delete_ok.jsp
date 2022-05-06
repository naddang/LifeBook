<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookNotice.NoticeBean"%>
<%@page import="lifeBookNotice.NoticeDBBean"%>
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
	
	NoticeDBBean db = NoticeDBBean.getInstance();
	int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
	
	NoticeBean board = db.getNotice(noticeNum, false);
	
	int re = db.deleteNotice(noticeNum);
	
	if (re == 1) {
		response.sendRedirect("list.jsp?pageNum=" + pageNum);
	} else if (re == -1) {
%>
	<script>
		alert("삭제에 실패했습니다.");
		history.go(-1);
	</script>
<%
	}
%>
