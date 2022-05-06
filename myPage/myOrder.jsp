<%@page import="bookInfo.BookInfoBean"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="order.OrderBean"%>
<%@page import="order.OrderDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = (String)session.getAttribute("userID");
	if(userID == null){
		response.sendRedirect("../intro/intro.jsp");
	}
	OrderDBBean orderDB = OrderDBBean.getInstance();
	ArrayList<OrderBean> orders = orderDB.getMyOrder(userID);
	BookInfoDBBean bookDB = BookInfoDBBean.getInstance();
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/myOrder.css">
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
		<h1>나의 주문</h1>
		<br>
		<div id="container">
		<div class="order_table">
		<table class="table_title">
			<tr>
				<th width="102" height="30" style="border-right: 1px solid gray;">주문번호</th>
				<th width="202" style="border-right: 1px solid gray;">내가 주문한 책</th>
				<th width="52" style="border-right: 1px solid gray;">수량</th>
				<th width="352" style="border-right: 1px solid gray;">배송지</th>
				<th width="102" style="border-right: 1px solid gray;">연락처</th>
				<th width="102">배송상태</th>
			</tr>
		</table>	
	<%
		for(int i = 0; i < orders.size(); i++){
			OrderBean order = orders.get(i);
			BookInfoBean book = bookDB.getBookInfo(order.getBookNum());
	%>
		<table class="table_content">
			<tr>
				<td width=102 align="center">
					<%=order.getOrderNum() %>
				</td>
				<td width="202" align="left">
				&nbsp;
					<img src="../../../LifeBook2/bookImgs/<%=book.getBookImg() %>" width="60px" height="85px">
					&nbsp;&nbsp;
					<%=book.getBookName() %>
				</td>
				<td width="52" align="center">
					<%= order.getAmount() %>
				</td>
				<td width="352" align="center">
					<%=order.getOrderAddr() %>
				</td>
				<td width="102" align="center">
					<%=order.getOrderPhoneNum() %>
				</td>
	<%
			if(order.getStatement().equals("배송완료")){
	%>
				<td width="102" align="center">
					<a href="../review/writeReview.jsp?bookNum=<%=book.getBookNum()%>"><%=order.getStatement()%>(리뷰 쓰러가기)</a>
				</td>
	<%
			}else{
	%>
				<td width="102" align="center">
					<%=order.getStatement() %>
				</td>
	<%
			}
	%>
				</tr>
				<tr><td colspan="6"><hr></td></tr>
	<%
			}
	%>	
		</table>
		</div>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>