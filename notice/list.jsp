<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookNotice.NoticeBean"%>
<%@page import="lifeBookNotice.NoticeDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	
	NoticeDBBean db = NoticeDBBean.getInstance();
	ArrayList<NoticeBean> noticeList = db.listNotice(pageNum);
	
	int noticeNum, hitCnt;
	String userID, noticeTitle, noticeContent;
	Timestamp regDate;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	String userID2 = (String)session.getAttribute("userID");
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
		<div id="title">
			<h1>공지사항</h1>
		</div>
<%
	if(userDB.isAdmin(userID2) == 1){
%>
		<div id="writeBtn">
			<input type="button" value="글쓰기" onclick="javascript:location.href='write.jsp'">
		</div>
			
<%
	}
%>
		
		<div id="boardArea">
		<table width="900" cellspacing="0" style="margin-bottom: 20px">
			<tr height="25">
				<td width="40" align="center">번호</td>
				<td width="550" align="center">글제목</td>
				<td width="120" align="center">작성자</td>
				<td width="130" align="center">작성일</td>
				<td width="60" align="center">조회수</td>
			</tr>
<%
				for (int i = 0; i < noticeList.size(); i++) {
					NoticeBean notice = noticeList.get(i);
					
					noticeNum = notice.getNoticeNum();
					noticeTitle = notice.getNoticeTitle();
					noticeContent = notice.getNoticeContent();
					userID = notice.getUserID();
					hitCnt = notice.getHitCnt();
					regDate = notice.getRegDate();
%>
			<tr height="25" bgcolor="#f7f7f7"
				onmouseover="this.style.backgroundColor='#eeeeef'"
				onmouseout="this.style.backgroundColor='#f7f7f7'">
				<td align="center"><%= noticeNum %></td>
				<td style="padding-left: 10px">
					<a href="show.jsp?noticeNum=<%= noticeNum %>&pageNum=<%= pageNum %>"><%= noticeTitle %></a>
				</td>
				<td align="center">
					<%= userID %>
				</td>
				<td align="center"><%= sdf.format(regDate) %></td>
				<td align="center"><%= hitCnt %></td>
			</tr>
<%
				}
%>
		</table>
		</div>
		<div id="pageArea">
			<%= NoticeBean.pageNumber(5) %>
		</div>
	</div>
	
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>