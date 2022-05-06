<%@page import="userInfo.UserInfoDBBean"%>
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
<jsp:useBean id="notice" class="lifeBookNotice.NoticeBean"></jsp:useBean>
<jsp:setProperty property="*" name="notice"/>
<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	
	NoticeDBBean edit = NoticeDBBean.getInstance();
	
	int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
	int re = edit.editNotice(notice);
	
	if (re == 1) {
%>
	<script>
		alert("게시물이 수정되었습니다.");
	</script>
<%
		response.sendRedirect("list.jsp?pageNum=" + pageNum);
				
	} else if (re == -1) {
%>
	<script>	
	    alert("수정에 실패했습니다.");
	    history.go(-1);
	</script>
<%		
			}
%>