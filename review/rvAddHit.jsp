<%@page import="review.ReviewDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
	ReviewDBBean rvDB = ReviewDBBean.getInstance();
	int re = rvDB.addRec(reviewNum);
	
	if(re == 1){
%>
	<script>
		location.href="showReview.jsp?reviewNum=<%=reviewNum%>";
	</script>
<%
	}else{
%>
	<script>
		location.href="asdsad";
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