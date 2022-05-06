<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="lifeBookBoard.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="lifeBookBoard.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	
	BoardDBBean db = BoardDBBean.getInstance();
	ArrayList<BoardBean> boardList = db.listBoard(pageNum);
	
	int boardNum, hitCnt, recommend = 0;
	String userID, boardTitle, boardContent;
	Timestamp regDate;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
	userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
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
		<div id="title">
			<h1>자유게시판</h1>
		</div>
		
		<div id="writeBtn">
			<input type="button" value="글쓰기" onclick="javascript:location.href='write.jsp?pageNum=<%=pageNum%>'">
		</div>
		
		<div id="boardArea">
			<table width="900" cellspacing="0" style="margin-bottom: 20px">
				<tr height="30">
					<td width="40" align="center">번호</td>
					<td width="480" align="center">글제목</td>
					<td width="130" align="center">작성자</td>
					<td width="130" align="center">작성일</td>
					<td width="60" align="center">조회수</td>
					<td width="60" align="center">추천수</td>
				</tr>
<%
					for (int i = 0; i < boardList.size(); i++) {
						BoardBean board = boardList.get(i);
						
						userID = board.getUserID();
						boardTitle = board.getBoardTitle();
						boardContent = board.getBoardContent();
						boardNum = board.getBoardNum();
						hitCnt = board.getHitCnt();
						regDate = board.getRegDate();
						recommend = board.getRecommend();
%>
				<tr height="30" bgcolor="#f7f7f7"
					onmouseover="this.style.backgroundColor='#eeeeef'"
					onmouseout="this.style.backgroundColor='#f7f7f7'">
					<td align="center"><%= boardNum %></td>
					<td style="padding-left: 10px">
						<a href="show.jsp?boardNum=<%= boardNum %>&pageNum=<%= pageNum %>"><%= boardTitle %></a>
					</td>
					<td align="center">
						<%= userID %>
					</td>
					<td align="center"><%= sdf.format(regDate) %></td>
					<td align="center"><%= hitCnt %></td>
					<td align="center"><%= recommend %></td>
				</tr>
<%
					}
%>
			</table>
		</div>
		
		<div id="searchArea">
			<form method="post" action="search.jsp"> 
	        	<table style="margin: auto;">
	        		<tr>
	        			<td>
	        				<select name="searchField">
	        					<option value="0">선택</option>
	        					<option value="boardTitle">글제목</option>
	        					<option value="userID">작성자</option>
	        				</select>
	        			</td>
	        			<td>
	        				<input type="text" size="40" name="searchText" placeholder="검색어 입력">	
	        			</td>
	        			<td>
			               <input type="submit" value="검색">
	        			</td>
	        		</tr>
	        	</table>
	       	</form>
       	</div>
		<div id="pageArea"><%= BoardBean.pageNumber(5) %></div>
	</div>
	
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>