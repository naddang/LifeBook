<%@page import="order.OrderBean"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="v_order.V_orderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="v_order.V_orderDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String userID2 = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	String pageNum = "1";
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
	}
	int isAdmin = userDB.isAdmin(userID2);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<%
	V_orderDBBean orderDB = V_orderDBBean.getInstance(); 
	ArrayList<V_orderBean> orders = orderDB.getAllOrderView(pageNum);
%>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/admin.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script src="../js/admin.js"></script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<div id="title">주문 관리</div>
		<div id="index_btn"><button type="button" onclick="location.href='../admin/index.jsp'">관리자 메인으로</button></div>
		<div id="table_area">
			<table>
				<tr>
					<th>주문번호</th>
					<th>주문날짜</th>
					<th>회원아이디</th>
					<th>회원이름</th>
					<th>회원 연락처</th>
					<th>회원 주소</th>
					<th>책 번호</th>
					<th>책 이름</th>
					<th>관리</th>
				</tr>
			<%
				
				for(int i = 0; i<orders.size();i++){
					V_orderBean order_view = orders.get(i);
					String orderNum = order_view.getOrderNum();
					Timestamp orderDate = order_view.getOrderDate();
					String userID = order_view.getUserID();
					String orderPhoneNum = order_view.getOrderPhoneNum();
					String orderRecipient = order_view.getOrderRecipient();
					String OrderAddr = order_view.getOrderAddr();
					int bookNum = order_view.getBookNum();
					String bookName = order_view.getBookName();
			%>
				<tr>
					<td><%= orderNum %></td>
					<td><%= orderDate %></td>
					<td><%= userID %></td>
					<td><%= orderPhoneNum %></td>
					<td><%= orderRecipient %></td>
					<td><%= OrderAddr %></td>
					<td><%= bookNum %></td>
					<td><%= bookName %></td>
					
					<td><button type="button" onclick="location.href='updateOrder.jsp?orderNum=<%=orderNum%>'" class="management_btn">수정</button></td>
				</tr>
			<%
				}
			%>
			</table>
		</div>
		<div id="pageArea">
			<%= V_orderBean.pageNumber(4)%>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>