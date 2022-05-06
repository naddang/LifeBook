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
	System.out.println(review.getBookNum());
	System.out.println(review.getUserID());
	int re = reviewDB.updateReview(review);
	
	if(re==1){
%>
	    <script>
	        alert("입력하신대로 리뷰가 수정되었습니다.");
	        document.location.href="reviewList.jsp";
	    </script>
<%        
	    }else{
%>
	    <script>
	        alert("수정에 실패했습니다.");
	        history.go(-1);
	    </script>
<%                
	    }
%>