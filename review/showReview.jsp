<%@page import="sun.reflect.generics.visitor.Reifier"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="reviewcmt.ReviewCmtBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="reviewcmt.ReviewCmtDBBean"%>
<%@page import="bookInfo.BookInfoBean"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@page import="review.ReviewDBBean"%>
<%@page import="review.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
	ReviewDBBean reviewDB = ReviewDBBean.getInstance();
	ReviewBean review = reviewDB.getReview(reviewNum);
	BookInfoDBBean bookDB = BookInfoDBBean.getInstance();
	BookInfoBean book = bookDB.getBookInfo(review.getBookNum());
	String userID = (String)session.getAttribute("userID");
	SimpleDateFormat sdf2 = new SimpleDateFormat("YY.MM.dd hh:mm");
	
%>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::책 리뷰</title>
<link rel="stylesheet" href="../css/showReview.css">
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
		<div id="padding_area">
		<br>
		<div class="border_area">
		<table id="content_table">
			<tr>
				<td rowspan="4" width="100" height="150">
					<img src="../../../LifeBook2/bookImgs/<%=book.getBookImg()%>" width="100px" height="150px" class="img_margin">
				</td>
			</tr>
			<tr>
				<td width="200" valign="top">
					<p class="book_name"><%=book.getBookName() %></p>
				</td>
			</tr>
			<tr>
				<td width="200" valign="top">
					<%=book.getAuthor() %> / <%=book.getBookPub() %>
				</td>
			</tr>
			<tr>
				<td width="850px" valign="top">
					<div class="details_area"><%=book.getBookDetails() %></div>
				</td>
			</tr>
		</table>
		</div>
		<br>
		<div class="content_top_area">
		<div class="review_title">
			<%= review.getReviewTitle()%>			
		</div>
		<div>
			조회수&nbsp;&nbsp;<%=review.getHitCnt()%>&nbsp;&#8226;&nbsp;추천수&nbsp;&nbsp;<%=review.getRecommend()%>&nbsp;&nbsp;
			<button type="button" onclick="location.href='rvAddHit.jsp?reviewNum=<%=reviewNum%>'">추천</button>
			<br>
			등록일&nbsp;&nbsp;<%= sdf2.format(review.getRegDate()) %>
		</div>
		</div>
		<br>
		<div class="review_content">
			<%=review.getReviewContent() %>		
		</div>
	<%
		if(reviewDB.checkID(reviewNum, userID) == 1){
	%>
		<div class="btn1" align="right">
			<button type="button" onclick="location='updateReview.jsp?reviewNum=<%=reviewNum%>'" class="updateBtn">수정하기</button>
			<button type="button" onclick="location='deleteReview.jsp?reviewNum=<%=reviewNum%>'" class="deleteBtn">삭제하기</button>
		</div>
	<%
		}
	%>
		<br>
		<div id="cmt_area">
		<form method="post" action="rvCmtOK.jsp?reviewNum=<%=reviewNum%>">
		<div class="cmt_title">댓글</div>
		<table border="1" width="880px" cellspacing="0">
	<%
		ReviewCmtDBBean rvCmtdb = ReviewCmtDBBean.getInstance();
		ArrayList<ReviewCmtBean> rvCmtList = rvCmtdb.getList(reviewNum);
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd hh:mm");
			System.out.println(rvCmtList.size());
		
		for(int i = 0; i < rvCmtList.size(); i++) {
			ReviewCmtBean rvCmt = rvCmtList.get(i);
			
			int rvCmtNum = rvCmt.getRvCmtNum();
			String cmtContent = rvCmt.getRvCmtContent();
			Timestamp regDate = rvCmt.getRegDate();
	%>
			<tr height="30">
				<td colspan="2"><p class="cmt_content"><%= cmtContent %></p></td>
				<td width="100" align="center"><%= sdf.format(regDate) %></td>
				<td width="120" align="center">
					<input type="hidden" name="reviewNum" value="<%= reviewNum %>">
					<input type="hidden" name="rvCmtNum" value="<%= rvCmtNum %>">
					<button type="button" onclick="location.href='updateRvCmt.jsp?rvCmtNum=<%= rvCmtNum %>&reviewNum=<%= reviewNum %>'" class="rvupBtn">수정</button>
					<button type="button" onclick="location.href='deleteRvCmt.jsp?rvCmtNum=<%= rvCmtNum %>&reviewNum=<%= reviewNum %>'" class="rvdeBtn">삭제</button>
					<%-- <input type="button" value="수정" onclick="location.href='updateRvCmt.jsp?rvCmtNum=<%= rvCmtNum %>&reviewNum=<%= reviewNum %>'"> --%>
					<%-- <input type="button" value="삭제" onclick="location.href='deleteRvCmt.jsp?rvCmtNum=<%= rvCmtNum %>&reviewNum=<%= reviewNum %>'"> --%>
				</td>
			</tr>
	<%
						
		}
	%>
			<tr height="30">
				<td colspan="4">
					<input type="text" size="50" name="rvCmtContent" placeholder="댓글 입력">
					<input type="submit" value="등록">
				</td>
			</tr>
		</table>
	</form>
	</div>
	</div>
	<footer class="footer">
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
	</div>
</body>
</html>