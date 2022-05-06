<%@page import="review.ReviewDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = (String)session.getAttribute("userID");
	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
	ReviewDBBean reviewDB = ReviewDBBean.getInstance();
	int re = reviewDB.deleteReview(reviewNum, userID);
	
	if(re == 1){
		%>
		<script>
			alert("삭제되었습니다.");
			location.href="reviewList.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("삭제실패.");
			history.go(-1);
			</script>
		<%
	}
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>