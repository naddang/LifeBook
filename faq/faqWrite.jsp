<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	} */
%>
<%
	String pageNum = request.getParameter("pageNum");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/faq.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script type="text/javascript" src="board.js"></script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<fieldset>
			<legend>자주 묻는 질문</legend>
			<form name="board_form" method="post" action="faqWrite_ok.jsp">
				<div id="info-area">
					<div id="form_flexBox_1">
						카테고리 : <br>
						글제목 : <br>
					</div>
					<div id="form_flexBox_2">
						<select name="faqCategory">
		    				<option value="">-----선택-----</option>
		    				<option value="상품문의">상품문의</option>
		    				<option value="배송문의">배송문의</option>
		    				<option value="교환/반품문의">교환/반품문의</option>
		    				<option value="계정관리">계정관리문의</option>
		    				<option value="기타문의">기타문의</option>
		   				</select>&nbsp;<br>
					<input type="text" name="faqTitle" size="64" maxlength="200">&nbsp;
					<br>
					<textarea rows="15" cols="65" name="faqContent"></textarea>
	       			</div>
				</div>
       			<div id="button_area">
       				<button type="button" onclick="check_ok()">등록</button>
       				<button type="button" onclick="document.board_form.reset()">다시작성</button>
       				<button type="button" onclick="javascript:location.href='faqList.jsp?pageNum=<%= pageNum %>'">글목록</button>
       			</div>
			</form>
		</fieldset>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>