<%@page import="lifeBookBoardComment.CommentDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="cmt" class="lifeBookBoardComment.CommentBean"></jsp:useBean>
<jsp:setProperty property="*" name="cmt"/>
<%
	String pageNum = request.getParameter("pageNum");
	
	CommentDBBean edit = CommentDBBean.getInstance();
	
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int cmtNum = Integer.parseInt(request.getParameter("cmtNum"));
	
	int re = edit.editComment(cmt);
	
	if (re == 1) {
%>
	<script>
		alert("댓글이 수정되었습니다.");
	</script>
<%
		response.sendRedirect("show.jsp?boardNum=" + boardNum);
				
	} else if (re == -1) {
%>
	<script>	
	    alert("수정에 실패했습니다.");
	    history.go(-1);
	</script>
<%		
			}
%>