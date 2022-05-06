<%@page import="cart.CartDBBean"%>
<%@page import="cart.CartBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택상품 삭제</title>
</head>
<body>
	<%
		String cartNum = request.getParameter("cartNum");
	
		CartDBBean cartDB = CartDBBean.getinstance();
		cartDB.deleteCart(cartNum);
		
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>