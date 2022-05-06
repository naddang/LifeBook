<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 비우기</title>
</head>
<body>
	<%
		//모든 상품을 삭제하기 위해 sessionID값을 얻음
		String userID = request.getParameter("userID");
		CartDBBean cartDB = CartDBBean.getinstance();
		cartDB.deleteAllMyCart(userID);
		
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>