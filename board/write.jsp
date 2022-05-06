<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookBoard.BoardBean"%>
<%@page import="lifeBookBoard.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");

	int boardNum = 0;
	String boardTitle = "";
	
	if (request.getParameter("boardNum") != null) {
		boardNum = Integer.parseInt(request.getParameter("boardNum"));
	}
	
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getBoard(boardNum, false);
	
	if (board != null) {
		boardTitle = board.getBoardTitle();
	}

	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="board.js" charset="UTF-8"></script>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/faq.css">
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
		<fieldset>
			<legend>자유게시판</legend>
			<form name="board_form" method="post" action="write_ok.jsp" enctype="multipart/form-data">
				<input type="hidden" name="userID" size="15" maxlength="15" value="<%= userID %>">

				<div id="info-area">
					<div id="form_flexBox_1">
						글제목 : <br>
					</div>
					
					<div id="form_flexBox_2">
						<input type="text" name="boardTitle" size="50" maxlength="50">
						&nbsp;<br>
						<textarea rows="10" cols="65" name="boardContent"></textarea>
						&nbsp;<br>
						<input type="file" name="fileName">
					</div>					
				</div>
				
					
				<div id="button_area">
					<button type="button" onclick="check_ok()">등록</button>&nbsp;
					<button type="reset">다시작성</button>&nbsp;
					<button type="button" onclick="javascript:location.href='freeboard.jsp?pageNum=<%= pageNum %>'">글목록</button>
				</div>	
			</form>
		</fieldset>
	</div>	
		
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>