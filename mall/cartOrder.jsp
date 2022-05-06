<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = (String)session.getAttribute("userID");
	String[] cartNum = request.getParameterValues("cartNum");
	if(cartNum == null){
		System.out.println("값이없음");
	}
	String recipient = request.getParameter("orderRecipient");
	String orderPhoneNum = request.getParameter("orderPhoneNum");
	String orderAddr = request.getParameter("orderAddr");
	CartDBBean cartDB = CartDBBean.getinstance();
	int re = cartDB.insertSelectedOrder(cartNum, recipient, orderAddr, orderPhoneNum, userID);
	
	if(re == 1){
		response.sendRedirect("../intro/intro.jsp");
	}else{
		response.sendRedirect("../main/asdsadsaf.jsp");
	}
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>