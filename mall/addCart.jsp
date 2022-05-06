<%@page import="cart.CartBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = "비회원";
	if(session.getAttribute("isMember") != null){
		userID = (String)session.getAttribute("userID");
	}
	int amount = Integer.parseInt(request.getParameter("amount"));
	int bookNum = Integer.parseInt(request.getParameter("bookNum"));

	CartDBBean cartDB = CartDBBean.getinstance();
	CartBean cart = new CartBean();
	cart.setBookNum(bookNum);
	cart.setQuantity(amount);
	cart.setUserID(userID);
	
	int re = cartDB.insertCart(cart);
	
	if(re == 1){
%>
		<script>
			alert("추가되었습니다.");
			history.back();
		</script>

<%
	}else{
		response.sendRedirect("asdsad");
	}
%>
