<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID2 = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID2);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<jsp:useBean id="member" class="member.managementMemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>    
<%
	String userID = request.getParameter("userID");
	String userPWD = request.getParameter("userPWD");
	String userName = request.getParameter("userName");
%>
<!DOCTYPE html>
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
		<div id="title">회원 삭제하기</div>
		<section>
			해당 회원을 삭제하시겠습니까?<br><br>
			회원 아이디&nbsp;&nbsp;&nbsp;
			<%= userID %><br>
			회원 이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%= userName %><br>
		</section>
		<div id="button_area">
			<button type="button" onclick="location.href='deleteMember_ok.sp?userID=<%=userID%>'">삭제</button>
			<button type="button" onclick="history.go(-1)">취소</button>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>