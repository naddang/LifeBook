<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@page import="bookInfo.BookInfoBean"%>
<%@page import="review.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="review.ReviewDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	ReviewDBBean reviewDB = ReviewDBBean.getInstance();
	ArrayList<ReviewBean> list = reviewDB.getReviewList(pageNum);
	BookInfoDBBean bookDB = BookInfoDBBean.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd hh:mm");
%>
<html>
<head>
<meta charset="EUC-KR">
<title>인생책방::리뷰</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/review.css">
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
		<div id="title">리뷰 게시판</div>
		<div id="boardArea">
			<table width="900" cellspacing="0" style="margin-bottom: 20px">
				<tr height="25" style="border-bottom: 1px gray solid">
					<td width="550" style="padding-left: 10px;">제목</td>
					<td width="100">아이디</td>
					<td width="60">조회수</td>
					<td width="60">추천수</td>
					<td width="150">작성일</td>
				</tr>
	<%
		for(int i = 0; i < list.size(); i++){
			ReviewBean review = list.get(i);
			BookInfoBean book = bookDB.getBookInfo(review.getBookNum());
			Timestamp ts = review.getRegDate();
			ts.getTime();
	%>
				<tr height="25" bgcolor="#f7f7f7"
					onmouseover="this.style.backgroundColor='#eeeeef'"
					onmouseout="this.style.backgroundColor='#f7f7f7'">
					<td style="overflow: hidden; padding-left: 10px;" width="500px" >
						<a href="showReview.jsp?reviewNum=<%=review.getReviewNum()%>">[<%=book.getBookName()%>]<%=review.getReviewTitle() %></a>
					</td>
					<td>
						<%=review.getUserID() %>
					</td>
					<td style="text-align: center;">
						<%=review.getHitCnt() %>
					</td>
					<td style="text-align: center;">
						<%=review.getRecommend() %>
					</td>
					<td>
						<%=sdf.format(new Date(review.getRegDate().getTime()))%>
					</td>
				</tr>
	<%
			}
	%>
			</table>
	</div>
	<div id="pageArea">
		<%=ReviewBean.pageNumber(5) %>
	</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>