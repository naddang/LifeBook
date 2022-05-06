<%@page import="sun.reflect.generics.visitor.Reifier"%>
<%@page import="review.ReviewBean"%>
<%@page import="review.ReviewDBBean"%>
<%@page import="bookInfo.BookInfoBean"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userID = (String)session.getAttribute("userID");
	if(userID == null){
		userID = "비회원";
	}
	
 	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
 	ReviewDBBean reviewDB = ReviewDBBean.getInstance();
 	ReviewBean review = reviewDB.getReview(reviewNum);
 	
	BookInfoDBBean bookDB = BookInfoDBBean.getInstance();
 	BookInfoBean book = bookDB.getBookInfo(review.getBookNum());
 	
 		
%>    
<%
	if(reviewDB.checkID(reviewNum, userID)==1){
		review = reviewDB.getReview(reviewNum);		
	}else{	
%>
	<script>
		alert("해당글의 작성자가 아닙니다.");
		history.go(-1);
	</script>
<%		
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::리뷰 수정</title>
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
		<fieldset>
			<legend>리뷰 수정</legend>
			<form action="../review/updateReviewOK.jsp">
				<input type="hidden" value="<%=reviewNum%>" name="reviewNum">
				<input type="hidden" value="<%=userID%>" name="userID">
				<input type="hidden" value="<%=review.getBookNum()%>" name="bookNum">
				<div id="info-area">
					<div id="img-area">
						<img src="../../../LifeBook2/bookImgs/<%=book.getBookImg()%>" width="100px" height="150px">
					</div>
					<div style="width: 150px;">
						책 제목 <br>
						작가 <br> 
						출판사 <br>
						상세정보 <br>
					</div>
					<div style="width: 600px;">
						<%=book.getBookName() %> <br>
						<%=book.getAuthor() %> <br> 
						<%=book.getBookPub() %> <br>
						<span><%=book.getBookDetails() %></span> <br>
					</div>
				</div>
				<div id="form-area">
					<div id="form-title">
						글 제목
					</div>
					<div style="width: 80%">
						<input type="text" placeholder="제목을 입력하세요." name="reviewTitle" style="width: 100%"><br>
						<textarea rows="20" placeholder="내용을 입력하세요." name="reviewContent" style="width: 100%"></textarea>
					</div>
				</div>
				<div id="button_area">
					<button>수정</button>
				</div>
			</form>
		</fieldset>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>