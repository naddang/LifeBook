<%@page import="cart.CartBean"%>
<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = "��ȸ��";
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
			alert("�߰��Ǿ����ϴ�.");
			history.back();
		</script>

<%
	}else{
		response.sendRedirect("asdsad");
	}
%>
