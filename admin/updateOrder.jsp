<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="order.OrderBean"%>
<%@page import="order.OrderDBBean"%>
<%@page import="v_order.V_orderBean"%>
<%@page import="v_order.V_orderDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String userID2 = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID2);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<%
	String orderNum = request.getParameter("orderNum");
	OrderDBBean orderDB = OrderDBBean.getInstance();
	OrderBean order = orderDB.getOrder(orderNum);
	String statement = order.getStatement();
	String OrderRecipient = order.getOrderRecipient();
	int bookNum = order.getBookNum();
	String userID = order.getUserID(); 
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
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<div id="form_area">
			<fieldset>
				<legend>주문 상세 정보</legend>
				<form action="updateOrderOK.jsp?orderNum=?&statement=?" name="form">
					주문번호 :
					<input type="text" value="<%=orderNum %>" name="orderNum" readonly="readonly" class="text_box">
					<br>
					아이디 :&nbsp;&nbsp;&nbsp;
					<input type="text" value="<%=userID %>" name="userID" readonly="readonly" class="text_box">
					<br>
					책 번호 :&nbsp;&nbsp;
					<input type="text" value="<%=bookNum %>" name="bookNum" readonly="readonly" class="text_box">
					<br><br>
					현재 배송상태 : <b><%=statement %></b><br>
					<br>
					수정할 배송상태<br>
					<input type="radio" name="statement" value="준비중" checked="checked">준비중
					<input type="radio" name="statement" value="배송준비">배송준비
					<input type="radio" name="statement" value="배송중">배송중
					<input type="radio" name="statement" value="배송완료">배송완료
					<input type="radio" name="statement" value="주문취소">주문취소
				</form>
			</fieldset>
			<div id="button_area">
				<button type="button" id="submit_btn" onclick="document.form.submit()">수정</button>
				<button type="button" id="submit_btn" onclick="history.go(-1)">취소</button>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>