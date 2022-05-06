<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="userInfo.UserInfoBean"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userID = (String)session.getAttribute("userID");

	if(session.getAttribute("isMember") == null){
	%>
		<script>
			alert("비회원은 접근할 수 없습니다!");
			location.href="../sign/login.jsp";
		</script>
	<%
		return;
	}
	
	 UserInfoDBBean userDB = new UserInfoDBBean();
	 UserInfoBean user = userDB.getUser(userID);
	 
	 Timestamp birth = user.getUserBirth();
	 
	 int isAdmin = user.getIsAdmin(); 
		String admin = "";
		
		if(isAdmin == 1){
			admin = "일반회원";
		}else{
			admin = "관리자";
		}
	 
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
	String birthdate = transFormat.format(birth);
%>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::마이페이지</title>
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
		<div id="title">마이페이지</div>
		<div id="box_wrap">
			<a href="../myPage/modify.jsp">
				<div class="admin_box">
					<b>정보 변경</b> 페이지로 이동
				</div>
			</a>
			<a href="../mall/cart.jsp">
				<div class="admin_box">
					<b>장바구니</b> 페이지로 이동
				</div>
			</a>
			<a href="../myPage/myOrder.jsp">
				<div class="admin_box">
					<b>나의 주문</b> 페이지로 이동
				</div>
			</a>
	</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>