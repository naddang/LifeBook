<%@page import="java.util.ArrayList"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@page import="bookInfo.BookInfoBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	DecimalFormat df = new DecimalFormat("###,###");
%>    
<%
   	BookInfoDBBean db = BookInfoDBBean.getInstance();
    String category = request.getParameter("category");
    String pageNum = request.getParameter("pageNum");
    if(pageNum==null){
   		pageNum = "1";
   	}
    
    String path = "D:\\space_java\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\LifeBook2\\bookImgs\\";
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="../js/jquery.js"></script>
<script src="../js/jquery.bxslider.min.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>

<style>
/* 	header{
		width: 1280px;
		height: 100px;
	}
	nav{
		float: left;
		width: 100px;
		height: 700px; 
	}
	body{
		background-color: #EDE6DD;
		width: 1280px;
		height: 1024px;
		margin: 0 auto;
	} */
	
		#content{
		font-size: 17px;
		color: black;
	}
        #rank{
            width: 5px;
            text-align: center;
            color: red;
            float: left;
        }
        #title{
            color: #3a60df;
            font-size: 25px;
            height: 10px;
        }
        #img{
        	float: left;
        }
        #des{
        	float: left;
        }
       .btn{ 
		border: 1px solid #823200; 
		background-color: rgba(0,0,0,0); 
		color: #823200; padding: 5px; 
	}

        .no_deco{
            text-decoration: none;
            color: brown;
        }
        .line{
        	border-left: solid 1px;
        	padding: 10px;
         	height: 150px;
        }
        .img{
        	border: 1px solid gray;
        }
        .search{
        	font-size: 18px;
        	font-weight: bold;
        }
        #container a{
		text-decoration: none;
		color: #823200;
		font-size: 12px;
	}
		#container h1{
			font-size: 30px;
			font-weight: bold;
		}
		#container .mainbest{
			font-weight: bold;
			font-size: 15px;
/* 			color: black; */
		} 
</style>
</head>
<body>
	<!-- <header></header> -->
	<!-- <nav></nav> -->
	<jsp:include page="../intro/header.jsp"></jsp:include>
	<div id="container">
	<h1>?????? ??????????</h1>
	<hr>
	<table>
    <a href="best.jsp" class="mainbest">???? TOP 10</a>
    <tr>
        <td><h4 class="mainbest">????&nbsp;&nbsp;&nbsp;</h4></td>
        <td>
        <a href="cateBest.jsp?category=10101">????</a> |
        <a href="cateBest.jsp?category=10102">??/??????</a> |
        <a href="cateBest.jsp?category=10201">????/????</a> |
        <a href="cateBest.jsp?category=10202">????????</a> |
        <a href="cateBest.jsp?category=10301">??????</a>
        <a href="cateBest.jsp?category=10302">????/????</a> |
        <a href="cateBest.jsp?category=10303">????/????</a> |
        <a href="cateBest.jsp?category=10304">????</a>
        <a href="cateBest.jsp?category=10401">????</a> |
        <a href="cateBest.jsp?category=10402">????/????</a> |
        <a href="cateBest.jsp?category=10403">??????/IT</a>
        <br>
        <a href="cateBest.jsp?category=10501">????(~7??)</a> |
        <a href="cateBest.jsp?category=10502">??????</a> |
        <a href="cateBest.jsp?category=10601">??????????</a> |
        <a href="cateBest.jsp?category=10602">????????????</a> |
        <a href="cateBest.jsp?category=10603">????????</a> |
        <a href="cateBest.jsp?category=10604">??????</a> |
        <a href="cateBest.jsp?category=10605">??????</a>
        <a href="cateBest.jsp?category=10701">????/????</a> |
        <a href="cateBest.jsp?category=10702">????/????/??????</a> |
        <a href="cateBest.jsp?category=10703">????/????</a> |
        <a href="cateBest.jsp?category=10704">????</a> |
        <a href="cateBest.jsp?category=10801">????</a> |
        <a href="cateBest.jsp?category=10802">????</a>
        </td>
    </tr>
    <tr><td><hr></td></tr>
    <tr>
        <td><h4 class="mainbest">????</h4></td>
        <td>
        <a href="cateBest.jsp?category=20101">????</a> |
        <a href="cateBest.jsp?category=20102">??/??????</a> |
        <a href="cateBest.jsp?category=20201">????/????</a> |
        <a href="cateBest.jsp?category=20202">????????</a> |
        <a href="cateBest.jsp?category=20301">??????</a>
        <a href="cateBest.jsp?category=20302">????/????</a> |
        <a href="cateBest.jsp?category=20303">????/????</a> |
        <a href="cateBest.jsp?category=20304">????</a>
        <a href="cateBest.jsp?category=20401">????</a> |
        <a href="cateBest.jsp?category=20402">????/????</a> |
        <a href="cateBest.jsp?category=20403">??????/IT</a>
        <br>
        <a href="cateBest.jsp?category=20501">????(~7??)</a> |
        <a href="cateBest.jsp?category=20502">??????</a> |
        <a href="cateBest.jsp?category=20601">??????????</a> |
        <a href="cateBest.jsp?category=20602">????????????</a> |
        <a href="cateBest.jsp?category=20603">????????</a> |
        <a href="cateBest.jsp?category=20604">??????</a> |
        <a href="cateBest.jsp?category=20605">??????</a>
        <a href="cateBest.jsp?category=20701">????/????</a> |
        <a href="cateBest.jsp?category=20702">????/????/??????</a> |
        <a href="cateBest.jsp?category=20703">????/????</a> |
        <a href="cateBest.jsp?category=20704">????</a> |
        <a href="cateBest.jsp?category=20801">????</a> |
        <a href="cateBest.jsp?category=20802">????</a>
        </td>
    </tr>
</table>
<hr>
<a href="sort.jsp" class="search">???? ????????</a>
<br><br>
<%
	ArrayList<BookInfoBean> books = db.getCateBestList(pageNum,category);
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
	<div id="content">
	<div id="rank"><strong><%=i+1 %></strong></div>
	<div id="img">
		&nbsp;&nbsp;&nbsp;<a href="details.jsp?bookNum=<%=bookNum%>">
           <img src="<%="\\LifeBook2\\book_imgs\\"+bookImg%>"  width="85px" height="118px" class="img">
        </a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div>
		<p><strong><%=bookName%></strong></p>
		<p><%=author%> | <%=bookPub%></p>
		<p><a href="review.jsp?bookNum=<%=bookNum%>" class="no_deco">????????</a></p>
		<p><%=df.format(bookPrice)%></p>
	</div>
	<div>
		<input type="button" value="????????" onclick="location='order.jsp?bookNum=<%=bookNum%>&amount=1'" class="btn">
		<input type="button" value="????????" onclick="location='addCart.jsp?bookNum=<%=bookNum%>&amount=1'" class="btn">
	</div>
	</div>
	<hr>
<%
			}
				
%>
	<a href="sort.jsp" class="search">???? ????????</a>
	<center><%= BookInfoBean.pageNumberBest(5,category) %></center>
</div>
<jsp:include page="../intro/footer.jsp"></jsp:include>
</body>
</html>