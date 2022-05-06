<%@page import="bookInfo.BookInfoBean"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	DecimalFormat df = new DecimalFormat("###,###");
	String pageNum = request.getParameter("pageNum");
	String category = request.getParameter("category");
	String search = request.getParameter("search");
	System.out.println("pageNum@@@@@@>>>>>"+pageNum);
	System.out.println("category@@@@@@>>>>>"+category);
	System.out.println("search@@@@@@>>>>>"+search);
	
%>
<%
	//여기서는 bookNum중복돼서 받는 책번호는 booknumber로 변수 세팅했어요
	int bookNum = Integer.parseInt(request.getParameter("bookNum"));
	System.out.println("bookNum@@@@@>>>>"+bookNum);
	BookInfoDBBean db = BookInfoDBBean.getInstance();
	BookInfoBean book = db.getBookInfo(bookNum);
	String bookName = book.getBookName();
	int bookPrice = book.getBookPrice();
	String BookDetails = book.getBookDetails();
	String bookPub = book.getBookPub();
	String author = book.getAuthor();
	String bookImg = book.getBookImg();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" href="../css/details.css">
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>

<!-- <style type="text/css">
/* 	header{
		width: 1280px;
		height: 100px;
	}
	nav{
		float: left;
		width: 100px;
		height: 700px; 
	} */
	body{
		background-color: #EDE6DD;
/* 		width: 1280px;
		height: 1024px;
		margin: 0 auto; */
	}
	#content{
		font-size: 17px;
		color: black;
		line-height: 40px;
	}
	.img{
		float: left;
	}
	.title{
		color: #3a60df;
		font-size: 20px;
		font-weight: bold; 
	}
	.info{
		color: gray;
	}
	.deco{
		text-decoration: none;
		color: brown;
	}
	.button{
		font-size: 15px;
		border: none;
		background: none;
	}
	.info{
		color: black;
		width:800px; vertical-align:top;
		display: -ms-flexbox; display: -webkit-box; display: -moz-box; display: box;              /* 글자가 넘치면 생략부호(...) 표시 */
        word-break:break-all;
        -webkit-box-orient:vertical;
		line-height:1.3em; height:3.9em;
	}
	#container h1{
			font-size: 30px;
			font-weight: bold;
		}
</style> -->
<script>
	function numcheck(val) {
		if(val<2){
			form.amount.value=1;
		}
	}
	function up(val) {
		form.amount.value=(val/1)+1;
	}
	function down(val) {
		if (val<2) {
			form.amount.value=1;
		} else {
			form.amount.value=val-1;
		}
	}
	function submit2(frm) {
		frm.action='addCart.jsp?bookNum=<%=bookNum%>&amount=?';
		frm.submit();
		return true;
	}
</script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>	
	</header>
	<div id="content_area">
		<h1>책 상세정보</h1>
		<hr>
		<br>
		<%-- <a href="searchResult.jsp?pageNum=<%=pageNum%>&category=<%=category%>&search=<%=search%>">목록으로</a> --%>
		<a onclick="history.go(-1)" href="#">뒤로가기</a><br><br>
		<div id="content">
			<div class="img">
				<img src="<%="\\LifeBook2\\book_imgs\\" + bookImg %>" width="200px" height="280px">
				&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<div>
				<h4 class="title"><%= bookName %></h4>
				<p><b>저자</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=author %></p>
				<p><b>출판사</b>&nbsp;&nbsp;&nbsp; <%=bookPub %></p>
				<p><a href="review.jsp?bookNum=<%=bookNum%>" class="deco"><b>리뷰보기</b></a></p>
				<p><b>판매가</b>&nbsp;&nbsp;&nbsp; <%=df.format(bookPrice) %></p>
				<%-- <p><input type="button" value="구매하기" onclick="location='order.jsp?bookNumber=<%=book_number%>'"></p> --%>
				<div>
				<form name="form" action="order.jsp?bookNum=<%=bookNum%>&amount=?">
					<input type="hidden" name="bookNum" value="<%=bookNum%>">
					<div>
						<label for="구매수량"><b>구매수량</b></label>
						<input type="button" value="+"  onclick="up(this.form.amount.value)" class="button"> 
						<input type="number" name="amount" min="1" max="50" value="1" size="2">
						<input type="button" value="-"  onclick="down(this.form.amount.value);" class="button">
						<br>
						<input type="submit" value="구매하기" class="orderBtn">
						<input type="button" value="장바구니" onclick="return submit2(this.form);" class="cartBtn">
					</div>
				</form>
				</div>
			</div>
			<br>
			<hr>
			<p><b>책 소개</b></p>
			<div class="info" align="left"><%=BookDetails %></div>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>