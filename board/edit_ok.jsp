<%@page import="lifeBookBoard.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="board" class="lifeBookBoard.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	
	BoardDBBean edit = BoardDBBean.getInstance();
	
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int re = edit.editBoard(board);
	
	if (re == 1) {
%>
	<script>
		alert("게시물이 수정되었습니다.");
	</script>
<%
		response.sendRedirect("../board/freeboard.jsp?pageNum=" + pageNum);
				
	} else if (re == -1) {
%>
	<script>	
	    alert("수정에 실패했습니다.");
	    history.go(-1);
	</script>
<%		
			}
%>