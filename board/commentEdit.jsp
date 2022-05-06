<%@page import="lifeBookBoardComment.CommentBean"%>
<%@page import="lifeBookBoardComment.CommentDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int cmtNum = Integer.parseInt(request.getParameter("cmtNum"));

	CommentDBBean edit = CommentDBBean.getInstance();
	CommentBean cmt = edit.getComment(cmtNum);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script src="../js/admin.js"></script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<h3>댓글 수정</h3>
		<form method="post" action="commentEdit_ok.jsp?cmtNum=<%= cmtNum%>&boardNum=<%= boardNum %>">
			<input type="text" name="cmtContent" value="<%= cmt.getCmtContent() %>">
			<input type="submit" value="수정">
			<input type="reset" value="다시작성">
		</form>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>