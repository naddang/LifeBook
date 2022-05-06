<%@page import="lifeBookBoardComment.CommentBean"%>
<%@page import="lifeBookBoardComment.CommentDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
	int rvCmtNum = Integer.parseInt(request.getParameter("rvCmtNum"));

	CommentDBBean edit = CommentDBBean.getInstance();
%>
<jsp:useBean id="rvCmt" class="reviewcmt.ReviewCmtBean"></jsp:useBean>
<jsp:setProperty property="*" name="rvCmt"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>댓글 수정</h3>
	<form method="post" action="rvCmtEdit_ok.jsp?rvCmtNum=<%= rvCmtNum%>&reviewNum=<%= reviewNum %>">
		<input type="text" name="rvCmtContent" value="<%= rvCmt.getRvCmtContent() %>">
		<input type="submit" value="수정">
		<input type="reset" value="다시작성">
	</form>
</body>
</html>