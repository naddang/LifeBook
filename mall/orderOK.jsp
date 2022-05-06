<%@page import="java.sql.Timestamp"%>
<%@page import="order.OrderDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="order" class="order.OrderBean"></jsp:useBean>
<jsp:setProperty property="*" name="order"/>
<%
	System.out.println("id===>"+request.getParameter("userID"));
	OrderDBBean orderDB = OrderDBBean.getInstance();
	order.setOrderNum(String.valueOf(orderDB.getTodayOrderNumber()));
	
	int re = orderDB.insertOrder(order);
	
	if(re == 1){
		response.sendRedirect("orderSuccess.jsp?orderNum="+order.getOrderNum());
	}else{
		response.sendRedirect("sort.jsp");
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>