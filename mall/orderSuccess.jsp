<%@page import="v_order.V_orderBean"%>
<%@page import="v_order.V_orderDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%

	String orderNum = request.getParameter("orderNum");
	V_orderDBBean orderViewDB = V_orderDBBean.getInstance();
	V_orderBean order = orderViewDB.getOrderView(orderNum);
	
%>
<html>
<head>
<meta charset="EUC-KR">
<title>인생책방::주문 완료</title>
<link rel="stylesheet" href="../css/orderSuccess.css">
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
</style>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div class="content_area" align="center">
		<h1>주문 완료</h1>
		<br>
		<h2>주문해주셔서 감사합니다. 주문정보를 확인해주세요.</h2>
		<br><br>
		<table>
			<tr>
				<td rowspan="8" colspan="2">
					<img src="<%="\\LifeBook2\\bookImgs\\" + order.getBookImg() %>" width="300" height="429">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					책이름
				</td>
				<td>
					&nbsp;&nbsp;&nbsp;&nbsp;<%=order.getBookName() + " " %>
				</td>
			</tr>
			<tr>
				<td>
					수  량
				</td>
				<td>
					&nbsp;&nbsp;&nbsp;&nbsp;<%=order.getAmount()+"권" %>
				</td>
			</tr>
			<tr>
				<td>
					주문번호
				</td>
				<td>
					&nbsp;&nbsp;&nbsp;&nbsp;<%=order.getOrderNum() %>
				</td>
			</tr>
			<tr>
				<td>
					주문날짜
				</td>
				<td>
					<% SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 E요일 hh:mm:ss");
						String orderdate = sf.format(order.getOrderDate());
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;<%=orderdate%>
				</td>
			</tr>
			<tr>
				<td>
					받으시는분
				</td>
				<td>
					&nbsp;&nbsp;&nbsp;&nbsp;<%=order.getOrderRecipient() %>
				</td>
			</tr>
			<tr>
				<td>
					연락처
				</td>
				<td>
					&nbsp;&nbsp;&nbsp;&nbsp;<%=order.getOrderPhoneNum() %>
				</td>
			</tr>
			<tr>
				<td>
					배송지
				</td>
				<td>
					&nbsp;&nbsp;&nbsp;&nbsp;<%=order.getOrderAddr() %>
				</td>
			</tr>
		</table>
		<br><br><br>
		<a href="../intro/intro.jsp"> >>메인화면으로 </a>
		<br><br>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>