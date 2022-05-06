<%@page import="lifeBookBoardComment.CommentBean"%>
<%@page import="lifeBookBoardComment.CommentDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	CommentDBBean db = CommentDBBean.getInstance();
	int cmtNum = Integer.parseInt(request.getParameter("cmtNum"));
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	
	int re = db.deleteComment(cmtNum);
	
	if (re == 1) {
		response.sendRedirect("show.jsp?boardNum=" + boardNum+"&pageNum="+pageNum);
	} else if (re == -1) {
%>
	<script>
		alert("삭제에 실패했습니다.");
		history.go(-1);
	</script>
<%
	}
%>
