<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<html>
<head>
<meta charset="EUC-KR">
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
		<div id="title">������ ������</div>
		<div id="box_wrap">
			<a href="listMember.jsp">
				<div class="admin_box">
					<b>ȸ������</b> �������� �̵�
				</div>
			</a>
			<a href="addBook.jsp">
				<div class="admin_box">
					<b>���� �߰�</b> �������� �̵�
				</div>
			</a>
			<a href="ordermgmt.jsp">
				<div class="admin_box">
					<b>�ֹ� ����</b>�������� �̵�
				</div>
			</a>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>