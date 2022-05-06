<%@page import="member.managementMemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean id="member" class="member.managementMemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%
	String userID = request.getParameter("userID");
	managementMemberDBBean db = managementMemberDBBean.getInstance();
	member = db.getMember(userID);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>인생책방::회원관리</title>
<script type="text/javascript" src="member.js" charset="utf-8"></script>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/admin.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script src="../js/admin.js"></script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<div id="form_area">
			<fieldset>
				<legend><%=member.getUserID()%> 회 원 정 보</legend>
				<form action="updateMember.jsp?userID=<%=member.getUserID()%>" method="post" name="mana_form">
					아이디 : &nbsp;&nbsp;
					<input type="text" name="userID" value="<%=member.getUserID()%>" class="text_box" readonly="readonly">
					<br>
					이  름 : &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" name="userName" value="<%=member.getUserName()%>" class="text_box" readonly="readonly" style="left: -1px;">
					<br>
					연락처 : &nbsp;&nbsp;
					<input type="text" name="userPhoneNum" value="<%=member.getUserPhoneNum()%>" class="text_box" style="right: 1px; background-color: white;">
					<br>
					주 소 : &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" name="userAddr" value="<%=member.getUserAddr() %>" size="58px" class="text_box" style="left: 1px; background-color: white;">
					<br>
					생년월일 : 
					<input type="text" name="userBirth" value="<%=member.getUserBirth() %>" size="58px" class="text_box" readonly="readonly">
					<br>
					마일리지 : 
					<input type="text" name="point" value="<%= member.getPoint() %>" class="text_box" style="background-color: white;">
				</form>
			</fieldset>
			<div id="button_area">
				<button type="button" onclick="check_ok()" class="button">회원수정</button>
				<button type="button" onclick="location='deleteMember.jsp?userID=<%=member.getUserID()%>&userPWD=<%=member.getUserPWD()%>&userName=<%=member.getUserName()%>'" class="button">회원삭제</button>
				<button type="button" value="취소" onclick="location='listMember.jsp'" class="button">취소</button>
			</div>
		</div>
	</div>
	<%-- <footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer> --%>
</body>
</html>