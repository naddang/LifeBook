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
		alert("��õ�߽��ϴ�.");
	</script>
<%
		response.sendRedirect("show.jsp?boardNum=" + board.getBoardNum() + "&pageNum=" + pageNum);
	} else if (re == -1) {
%>
	<script>
		alert("��õ�� �����߽��ϴ�.");
		history.go(-1);
	</script>
<%
	}
%>