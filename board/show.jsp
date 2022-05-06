<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="lifeBookBoardComment.CommentBean"%>
<%@page import="lifeBookBoardComment.CommentDBBean"%>
<%@page import="lifeBookBoard.BoardBean"%>
<%@page import="lifeBookBoard.BoardDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 데이터 한글 처리
	request.setCharacterEncoding("UTF-8");	

	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = null;
	sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	BoardDBBean boarddb = BoardDBBean.getInstance();
	BoardBean board = boarddb.getBoard(boardNum, true);
	
	String userID = "";
	if (session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
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
		<!-- 본문영역 -->
		<div id="boardArea">
			<table border="1" width="900" cellspacing="0">
				<tr>
					<td colspan="4">
						<h1 style="padding: 10px; background-color: #eee"><b><%= board.getBoardTitle() %></b></h1>
					</td>
				</tr>
				<tr height="30" align="center">
					<td width="150" align="center">글번호</td>
					<td width="300" align="center"><%= board.getBoardNum() %></td>
					<td width="150" align="center">조회수</td>
					<td width="300" align="center"><%= board.getHitCnt() %></td>
				</tr>
				<tr height="30">
					<td align="center">작성자</td>
					<td align="center"><%= board.getUserID() %></td>
					<td align="center">작성일</td>
					<td align="center"><%= sdf.format(board.getRegDate()) %></td>
				</tr>
				<tr height="30">
					<td align="center">파&nbsp;일</td>
					<td align="center">
				<%
					if (board.getFileName() != null) {
						out.println("<p>첨부파일" + "<a href='FileDownload.jsp?fileN=" + board.getBoardNum() + "'>" + board.getRealFileName() + "</a>" + "</p>");
					} else {
						out.println("파일없음");
					}
				%>
					</td>
					<td align="center">추천수</td>
					<td align="center"><%= board.getRecommend() %></td>
					</tr>
				<tr >
					<td height="250" align="center">글내용</td>
					<td colspan="3" style="padding: 10px; vertical-align: top">
						<%= board.getBoardContent() %>
					</td>
				</tr>
			</table>
		</div>
		
		<div id="writeBtn">
			<tr height="30">
				<td colspan="4" align="right">
				<%
					if (userID != null) {
				%>
					<input type="submit" value="글추천" onclick="location.href='rec_ok.jsp?boardNum=<%= board.getBoardNum() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
				<%
					}
				
					if (userID.equals(board.getUserID())) {
				%>
					<input type="submit" value="글수정" onclick="location.href='edit.jsp?boardNum=<%= board.getBoardNum() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" value="글삭제" onclick="location.href='delete_ok.jsp?boardNum=<%= board.getBoardNum() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
				<%						
					} 
				%>
					<input type="button" value="글목록" onclick="window.location='freeboard.jsp?pageNum=<%= pageNum %>'">
				</td>
			</tr>
		</div>
		<br>
		
		<!-- 댓글영역 -->
		<div id="boardArea">
			<form method="post" action="comment_ok.jsp?boardNum=<%= board.getBoardNum() %>">
				<table border="1" width="900" cellspacing="0">
					<tr height="30">
						<td colspan="4">
							<h3 style="padding: 10px; background-color: #eee"><b>댓글</b></h3>
						</td>
					</tr>
				<%
						CommentDBBean cmtdb = CommentDBBean.getInstance();
						ArrayList<CommentBean> cmtList = cmtdb.getList(boardNum);
						
						
						for(int i = 0; i < cmtList.size(); i++) {
							CommentBean comment = cmtList.get(i);
							
							int cmtNum = comment.getCmtNum();
							String cmtContent = comment.getCmtContent();
							Timestamp regDate = comment.getRegDate();
				%>
					<tr height="30">
						<td colspan="2" style="padding: 10px;"><%= cmtContent %></td>
						<td width="200" align="center">
							<%= sdf.format(regDate) %>
							<input type="hidden" name="cmtNum" value="<%= cmtNum %>">
						</td>
				<%	
						if(userDB.isAdmin(userID) == 1){
							
				%>
						<td width="200" align="center">
							<input type="button" value="수정" onclick="location.href='commentEdit.jsp?cmtNum=<%= cmtNum %>&boardNum=<%= boardNum %>&pageNum=<%=pageNum%>'">
							<input type="button" value="삭제 " onclick="location.href='commentDelete_ok.jsp?cmtNum=<%= cmtNum %>&boardNum=<%= boardNum %>&pageNum=<%=pageNum%>'">
						</td>
				<%	
						}
				%>
					</tr>
				<%
							
						}
				%>
					<tr height="30">
						<td colspan="4">
							<input type="text" size="50" name="cmtContent" placeholder="댓글 입력" style="margin: 10px;">
							<input type="submit" value="등록">
						</td>
					</tr>
				</table>
				<input type="hidden" name="boardNum" value="<%= boardNum %>">
				<input type="hidden" name="pageNum" value="<%= pageNum %>">
			</form>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>