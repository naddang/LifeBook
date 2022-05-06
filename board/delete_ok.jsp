<%@page import="lifeBookBoard.BoardBean"%>
<%@page import="lifeBookBoard.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	BoardDBBean db = BoardDBBean.getInstance();
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	
	BoardBean board = db.getBoard(boardNum, false);
	
	int re = db.deleteBoard(boardNum);
	
	if (re == 1) {
		response.sendRedirect("../board/freeboard.jsp?pageNum=" + pageNum);
	} else if (re == -1) {
%>
	<script>
		alert("삭제에 실패했습니다.");
		history.go(-1);
	</script>
<%
	}
%>
