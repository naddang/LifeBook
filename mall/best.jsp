<%@page import="bookInfo.BookInfoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@ page import="java.text.*" %>
<%
	DecimalFormat df = new DecimalFormat("###,###");
%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
	BookInfoDBBean db = BookInfoDBBean.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script src="../js/admin.js"></script>

<style>
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
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="container">
		<h1>전체 TOP 10</h1>
		<hr>
	    <a href="best.jsp" class="mainbest">전체 TOP 10</a>
		<table>
		    <tr>
		        <td><h4 class="mainbest">국내&nbsp;&nbsp;&nbsp;</h4></td>
		        <td>
			        <a href="cateBest.jsp?category=10101">소설</a> |
			        <a href="cateBest.jsp?category=10102">시/에세이</a> |
			        <a href="cateBest.jsp?category=10201">경제/경영</a> |
			        <a href="cateBest.jsp?category=10202">자기계발</a> |
			        <a href="cateBest.jsp?category=10301">인문학</a>
			        <a href="cateBest.jsp?category=10302">예술/종교</a> |
			        <a href="cateBest.jsp?category=10303">정치/사회</a> |
			        <a href="cateBest.jsp?category=10304">역사</a>
			        <a href="cateBest.jsp?category=10401">과학</a> |
			        <a href="cateBest.jsp?category=10402">기술/공학</a> |
			        <a href="cateBest.jsp?category=10403">컴퓨터/IT</a>
			        <br>
			        <a href="cateBest.jsp?category=10501">유아(~7세)</a> |
			        <a href="cateBest.jsp?category=10502">어린이</a> |
			        <a href="cateBest.jsp?category=10601">초등참고서</a> |
			        <a href="cateBest.jsp?category=10602">중고등참고서</a> |
			        <a href="cateBest.jsp?category=10603">대학교재</a> |
			        <a href="cateBest.jsp?category=10604">수험서</a> |
			        <a href="cateBest.jsp?category=10605">외국어</a>
			        <a href="cateBest.jsp?category=10701">가정/육아</a> |
			        <a href="cateBest.jsp?category=10702">건강/헬스/스포츠</a> |
			        <a href="cateBest.jsp?category=10703">여행/요리</a> |
			        <a href="cateBest.jsp?category=10704">취미</a> |
			        <a href="cateBest.jsp?category=10801">만화</a> |
			        <a href="cateBest.jsp?category=10802">잡지</a>
		        </td>
		    </tr>
			<tr><td><hr></td></tr>
		    <tr>
		        <td><h4 class="mainbest">해외</h4></td>
		        <td>
			        <a href="cateBest.jsp?category=20101">소설</a> |
			        <a href="cateBest.jsp?category=20102">시/에세이</a> |
			        <a href="cateBest.jsp?category=20201">경제/경영</a> |
			        <a href="cateBest.jsp?category=20202">자기계발</a> |
			        <a href="cateBest.jsp?category=20301">인문학</a>
			        <a href="cateBest.jsp?category=20302">예술/종교</a> |
			        <a href="cateBest.jsp?category=20303">정치/사회</a> |
			        <a href="cateBest.jsp?category=20304">역사</a>
			        <a href="cateBest.jsp?category=20401">과학</a> |
			        <a href="cateBest.jsp?category=20402">기술/공학</a> |
			        <a href="cateBest.jsp?category=20403">컴퓨터/IT</a>
			        <br>
			        <a href="cateBest.jsp?category=20501">유아(~7세)</a> |
			        <a href="cateBest.jsp?category=20502">어린이</a> |
			        <a href="cateBest.jsp?category=20601">초등참고서</a> |
			        <a href="cateBest.jsp?category=20602">중고등참고서</a> |
			        <a href="cateBest.jsp?category=20603">대학교재</a> |
			        <a href="cateBest.jsp?category=20604">수험서</a> |
			        <a href="cateBest.jsp?category=20605">외국어</a>
			        <a href="cateBest.jsp?category=20701">가정/육아</a> |
			        <a href="cateBest.jsp?category=20702">건강/헬스/스포츠</a> |
			        <a href="cateBest.jsp?category=20703">여행/요리</a> |
			        <a href="cateBest.jsp?category=20704">취미</a> |
			        <a href="cateBest.jsp?category=20801">만화</a> |
			        <a href="cateBest.jsp?category=20802">잡지</a>
		        </td>
		    </tr>
		</table>
		<hr>
		<a href="sort.jsp" class="search">도서 검색하기</a>
		<br><br>
<%
	ArrayList<BookInfoBean> books = db.getBestList();
	int rank = 1;
	for(int i=0;i<books.size();i++){
		if(rank>10) break;
		BookInfoBean book = books.get(i);
		int bookNum = book.getBookNum();
		String bookName = book.getBookName();
		int bookPrice = book.getBookPrice();
		String bookPub = book.getBookPub();
		String author = book.getAuthor();
		String bookImg = book.getBookImg();
		
%>
		<div id="content">
			<div id="rank"><strong><%=rank %></strong></div>
			<div id="img">
				&nbsp;&nbsp;&nbsp;<a href="details.jsp?bookNum=<%=bookNum%>">
		           <img src="<%="\\LifeBook2\\book_imgs\\"+bookImg%>"  width="85px" height="118px" class="img">
		        </a>
		        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<div>
				<strong><p><%=bookName%></p></strong>
				<p><%=author%> | <%=bookPub%></p>
				<p><a href="review.jsp?bookNum=<%=bookNum%>" class="no_deco">리뷰보기</a></p>
				<p><%=df.format(bookPrice)%></p>
			</div>
			<div>
				<input type="button" value="구매하기" onclick="location='order.jsp?bookNum=<%=bookNum%>&amount=1'" class="btn">
				<input type="button" value="장바구니" onclick="location='addCart.jsp?bookNum=<%=bookNum%>&amount=1'" class="btn">
			</div>
		</div>
		<hr>
<%
			rank++;
			}					
%>
	<a href="sort.jsp" class="search">도서 검색하기</a>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>