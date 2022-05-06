<%@page import="java.text.DecimalFormat"%>
<%@page import="bookInfo.BookInfoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	DecimalFormat df = new DecimalFormat("###,###");
%>    
<%
  	BookInfoDBBean db = BookInfoDBBean.getInstance();
   	String category = request.getParameter("category");
   	String search = request.getParameter("search");
   	String pageNum = request.getParameter("pageNum");
   	System.out.println("pageNum@@@@@@<<<<<<"+pageNum);
	System.out.println("category@@@@@@<<<<<<"+category);
	System.out.println("search@@@@@@<<<<<<"+search);
   	if(pageNum==null){
   		pageNum = "1";
   	}
      	
      	/* if(request.getParameter("pageNum")!=null){
      		pageNum = Integer.parseInt(request.getParameter("pageNum"));
      	} */
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/searchResult.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>

<script type="text/javascript"></script>
<!-- <style type="text/css">
	/* header{
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
	#container a{
		text-decoration: none;
		color: #823200;
	}
	.title{
		font-size: 20px;
		font-weight: bold;
	}
	.description{
		font-size: 15px;
		color: #823200;
	}
	.info{
		font-size: 15px;
		color: gray;
		width:250px; vertical-align:top;
		display: -ms-flexbox; display: -webkit-box; display: -moz-box; display: box;
		max-height:40px;
        overflow:hidden;
        text-overflow: ellipsis;                /* 글자가 넘치면 생략부호(...) 표시 */
        word-break:break-all;                /* 글자 단위로 "강제" 줄바꿈 처리 */
        -webkit-box-orient:vertical;
        -webkit-line-clamp:2;
		line-height:1.3em; height:3.9em;
	}
	.pageNum{
		align-content: center;
	}
	#container h1{
			font-size: 30px;
			font-weight: bold;
		}
</style> -->
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<h1>검색결과</h1>
		<hr>
		<a href="sort.jsp">도서 검색하기</a><br><br>
		<br>
			<%
				ArrayList<BookInfoBean> books = null;
				System.out.println("category@@@@<<<>>>>"+category);
				if(category == null){
					System.out.println("1번 출력");						
					books = db.searchBookList(pageNum, search);	
					System.out.println("search@@@@>>"+pageNum);	
					
				}else if(category.equals("null")){
					//details에서 넘어오는 카테고리는 문자열 null이라서 조건문 하나 더 넣음
					books = db.searchBookList(pageNum, search);	
				}
				else{
					System.out.println("2번 출력");						
					books = db.getBookList(pageNum, category);
						System.out.println("category@@@@>>"+category);	
						System.out.println("pageNum@@@@>>"+pageNum);	
				}
						System.out.println("size@@@@>>"+books.size());
						for(int i = 0; i < books.size(); i++){
							BookInfoBean book = books.get(i);
							int bookNum = book.getBookNum();
							String bookName = book.getBookName();
							int bookPrice = book.getBookPrice();
							String bookDetails = book.getBookDetails();
							String bookPub = book.getBookPub();
							String author = book.getAuthor();
							String bookImg = book.getBookImg();
							System.out.println(book.getBookName());
			%>
		<table class="contentTable">
			<tr>
				<td rowspan="2" width="150px">
					<a href="details.jsp?bookNum=<%=bookNum %>&pageNum=<%=pageNum%>&category=<%=category%>&search=<%=search%>">
						<img src="<%="\\LifeBook2\\book_imgs\\" + bookImg%>" width="115px" height="170px">
					</a>
				</td>
			</tr>
			<tr>
				<td width="500px" class="valign">					
					<div class="title"><a href="details.jsp?bookNum=<%=bookNum %>&pageNum=<%=pageNum%>&category=<%=category%>&search=<%=search%>"><%=bookName %></a></div>
					<br>						
					<div class="description"><%=author%> | <%=bookPub%></div>
					<br>
					<div class="price"><%=df.format(bookPrice) %>원</div>
					<br>
					<div class="info"><%=bookDetails %></div>
				</td>
				<td rowspan="2" width="350px" class="btn_area">
					<input type="button" value="구매하기" onclick="location='order.jsp?bookNum=<%=bookNum%>&pageNum=<%=pageNum%>'" class="orderBtn">
					<br><br>
					<input type="button" value="장바구니" onclick="location='addCart.jsp?bookNum=<%=bookNum%>&amount=1&pageNum=<%=pageNum%>'" class="cartBtn">
				</td>
			</tr>
			<tr><td colspan="3"><br><hr><br></td></tr>
			<%
						
				}
			%>
		</table>
		<br><br>
		<div id="pageArea"><%= BookInfoBean.pageNumber(5,category) %></div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>