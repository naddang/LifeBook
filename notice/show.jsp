<%@page import="lifeBookNotice.NoticeBean"%>
<%@page import="lifeBookNotice.NoticeDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");	

	String pageNum = request.getParameter("pageNum");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
	NoticeDBBean db = NoticeDBBean.getInstance();
	NoticeBean notice = db.getNotice(noticeNum, true);
%>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::공지사항</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
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
		<div id="boardArea">
			<table width="900" cellspacing="0">
				<tr height="30" align="center">
					<th width="150" align="center">글번호</th>
					<td width="300" align="center"><%= notice.getNoticeNum() %></td>
					<th width="150" align="center">조회수</th>
					<td width="300" align="center"><%= notice.getHitCnt() %></td>
				</tr>
				<tr height="30">
					<th align="center">작성자</th>
					<td align="center"><%= notice.getUserID() %></td>
					<th align="center">작성일</th>
					<td align="center"><%= sdf.format(notice.getRegDate()) %></td>
				</tr>
				<tr height="30">
					<th align="center">글제목</th>
					<td colspan="3" style="padding-left: 10px"><%= notice.getNoticeTitle() %></td>
				</tr>
				<tr>
					<td height="250" align="center">글내용</td>
					<td colspan="3" style="padding: 10px; vertical-align: top"><%= notice.getNoticeContent() %></td>
				</tr>
			</table>
		</div>
		
		<div id="button_area">
			<button type="button" onclick="location.href='edit.jsp?noticeNum=<%= notice.getNoticeNum() %>&pageNum=<%= pageNum %>'">글수정</button>
			<button type="button" onclick="location.href='delete_ok.jsp?noticeNum=<%= notice.getNoticeNum() %>&pageNum=<%= pageNum %>'">글삭제</button>
			<button type="button" onclick="window.location='list.jsp?pageNum=<%= pageNum %>'">글목록</button>
		</div>
	</div>
	
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>