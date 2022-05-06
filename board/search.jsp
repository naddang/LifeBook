<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="lifeBookBoard.BoardDBBean"%>
<%@page import="lifeBookBoard.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
	<%
		String pageNum;
		if ((request.getParameter("pageNum")) != null) {
			pageNum = request.getParameter("pageNum");
		} else {
			pageNum = "1"; 
		}
	
		BoardDBBean board = new BoardDBBean();
		String searchField = request.getParameter("searchField");
		String searchText = request.getParameter("searchText");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		ArrayList<BoardBean> boardList = board.getSearch(searchField, searchText);
		
		if (boardList.size() == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('검색결과가 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	<div id="content_area">
		<h1>자유게시판</h1>
		<table border="1" width="800" cellspacing="0" style="margin-bottom: 20px">
			<tr height="25">
				<td width="40" align="center">번호</td>
				<td width="430" align="center">글제목</td>
				<td width="120" align="center">작성자</td>
				<td width="150" align="center">작성일</td>
				<td width="60" align="center">조회수</td>
			</tr>
<%
			for (int i = 0; i < boardList.size(); i++) {
%>
			<tr>
				<td align="center"><%= boardList.get(i).getBoardNum() %></td>
				<td style="padding-left: 10px">
					<a href="show.jsp?b_number=<%= boardList.get(i).getBoardNum() %>&pageNum=<%= pageNum %>"><%= boardList.get(i).getBoardTitle() %></a>
				</td>
				<td align="center"><%= boardList.get(i).getUserID() %></td>
				<td align="center"><%= sdf.format(boardList.get(i).getRegDate()) %></td>
				<td align="center"><%= boardList.get(i).getHitCnt() %></td>
			</tr>
<%
			}
%>
		</table>
		<%= BoardBean.pageNumber(5) %>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>