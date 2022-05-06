<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="order.OrderDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<%
	request.setCharacterEncoding("utf-8");
	String statement = request.getParameter("statement");
	String orderNum = request.getParameter("orderNum");
	OrderDBBean orderDB = OrderDBBean.getInstance();
	int re = orderDB.updateOrderStatement(orderNum, statement); 
	
	if(re == 1){
%>
		<script>
			alert("수정완료");
			location.href="ordermgmt.jsp";
		</script>
<%
	}else{
%>
		<script>
			alert("수정실패");
		</script>
<%
	}
%>
