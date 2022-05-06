<%@page import="review.ReviewDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="review" class="review.ReviewBean"></jsp:useBean>
<jsp:setProperty property="*" name="review"/>
<%
	ReviewDBBean reviewDB = ReviewDBBean.getInstance();
	int re = reviewDB.insertReview(review);
	
	if(re == 1){
		System.out.println("등록성공");
		response.sendRedirect("../review/reviewList.jsp");
	}else{
		System.out.println("등록실패");
		response.sendRedirect("../review/intro.jsp");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>