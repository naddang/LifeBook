<%@page import="cart.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>  
<%
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	String cartNum = request.getParameter("cartNum");
	CartDBBean db = CartDBBean.getinstance();
	int re = db.modifyQuantity(quantity, cartNum);
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(re==1){
	%>
	<script>
			alert("수량이 변경되었습니다");
			System.out.println("변경");
	</script>			
	<%			
			/* response.sendRedirect("cart.jsp"); */
		}else{
	%>
	<script>
			alert("ㅇㅇ");
			System.out.println("변경실패");
	</script>			
	<%		
			/* response.sendRedirect("cart.jsp"); */
		}
	%>
</body>
</html>