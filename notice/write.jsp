<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookNotice.NoticeBean"%>
<%@page import="lifeBookNotice.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<%
	String pageNum = request.getParameter("pageNum");

	int noticeNum = 0;
	String noticeTitle = "";
	
	if (request.getParameter("noticeNum") != null) {
		noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
	}
	
	NoticeDBBean db = NoticeDBBean.getInstance();
	NoticeBean notice = db.getNotice(noticeNum, false);
	
	if (notice != null) {
		noticeTitle = notice.getNoticeTitle();
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::공지사항</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/faq.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script type="text/javascript" charset="UTF-8">
function check_ok() {
	if (document.notice_form.userID.value.length == 0) {
		alert("관리자 아이디를 입력하세요.");
		notice_form.userID.focus();
		return;
	}
	
	if (document.notice_form.noticeTitle.value.length == 0) {
		alert("글 제목을 입력하세요.");
		notice_form.noticeTitle.focus();
		return;
	}
	
	if (document.notice_form.noticeContent.value.length == 0) {
		alert("글 내용을 입력하세요.");
		notice_form.noticeContent.focus();
		return;
	}
	
	document.notice_form.submit();
}

</script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	
	<div id="content_area">
		<fieldset>
			<legend>공지사항</legend>
			<form name="notice_form" method="post" action="write_ok.jsp">
				<div id="info-area">
					<div id="form_flexBox_1">
						관리자 : <br>
						글제목 : <br>
					</div>
					<div id="form_flexBox_2">
						<input type="text" name="userID" size="15" maxlength="15">
						&nbsp;<br>
						<input type="text" name="noticeTitle" size="50" maxlength="50">
						&nbsp;<br>
						<textarea rows="10" cols="65" name="noticeContent"></textarea>
					</div>	
				</div>
				
				<div id="button_area">
					<button type="button" onclick="check_ok()">등록</button>&nbsp;
					<button type="reset">다시작성</button>&nbsp;
					<button type="button" onclick="javascript:location.href='list.jsp?pageNum=<%= pageNum %>'">글목록</button>
				</div>	
			</form>
		</fieldset>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>