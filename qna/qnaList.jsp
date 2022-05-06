<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="lifeBookQnA.QnaBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="lifeBookQnA.QnaDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// 페이지 넘버 받기
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	
	QnaDBBean db = QnaDBBean.getInstance();
	ArrayList<QnaBean> qnaList = db.listQna(pageNum);
	
	int qnaNum, qnaRef, qnaStep, qnaLevel;
	String userID, category, qnaTitle, qnaContent, qnaPWD;
	Timestamp regDate;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/faq.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<h1>1:1 문의 게시판</h1>
		
		<div id="writeBtn">
			<input type="button" value="글쓰기" onclick="javascript:location.href='qnaWrite.jsp'">
		</div>
		
		<div id="boardArea">
			<table width="900" cellspacing="0" style="margin-bottom: 20px">
				<tr>
					<td width="100" align="center">번호</td>
					<td width="100" align="center">카테고리</td>
					<td width="450" align="center">글제목</td>
					<td width="100" align="center">작성자</td>
					<td width="150" align="center">작성일</td>
				</tr>
	<%
					for (int i = 0; i < qnaList.size(); i++) {
						QnaBean qna = qnaList.get(i);
						
						qnaNum = qna.getQnaNum();
						userID = qna.getUserID();
						category = qna.getCategory();
						qnaTitle = qna.getQnaTitle();
						qnaContent = qna.getQnaContent();
						regDate = qna.getRegDate();
						qnaRef = qna.getQnaRef();
						qnaStep = qna.getQnaStep();
						qnaLevel = qna.getQnaLevel();
	%>
				<tr height="25" bgcolor="#f7f7f7"
					onmouseover="this.style.backgroundColor='#eeeeef'"
					onmouseout="this.style.backgroundColor='#f7f7f7'">
					<td align="center"><%= qnaNum %></td>
					<td align="center"><%= category %></td>
					<td style="padding-left: 10px">
	<%
						if (qnaLevel > 0) {
							for (int j = 0; j < qnaLevel; j++) {
	%>
								&nbsp;&nbsp;
	<%
							}
						}
	%>
						<a href="qnaShow.jsp?qnaNum=<%= qnaNum %>&pageNum=<%= pageNum %>"><%= qnaTitle %></a>
					</td>
					<td align="center"><%= userID %></td>
					<td align="center"><%= sdf.format(regDate) %></td>
				</tr>
	<%
					}
	%>
			</table>
		</div>
		<div id="pageArea"><%= QnaBean.pageNumber(5) %></div>
	</div>
	
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>