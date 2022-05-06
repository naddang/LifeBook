<%@page import="lifeBookBoard.BoardBean"%>
<%@page import="lifeBookBoard.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	BoardDBBean db = BoardDBBean.getInstance();
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	
	BoardBean board = db.getBoard(boardNum, false);
	
	int re = db.recBoard(boardNum);
	
	if (re == 1) {
%>
	<script>
		alert("추천했습니다.");
	</script>
<%
		response.sendRedirect("show.jsp?boardNum=" + board.getBoardNum() + "&pageNum=" + pageNum);
	} else if (re == -1) {
%>
	<script>
		alert("추천에 실패했습니다.");
		history.go(-1);
	</script>
<%
	}
%>