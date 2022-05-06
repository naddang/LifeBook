<%@page import="lifeBookQnA.QnaBean"%>
<%@page import="lifeBookQnA.QnaDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");

	int qnaNum = 0, qnaRef = 1, qnaStep = 0, qnaLevel = 0;
	String qnaTitle = "";
	
	if (request.getParameter("qnaNum") != null) {
		qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
	}
	
	QnaDBBean db = QnaDBBean.getInstance();
	QnaBean qna = db.getQna(qnaNum);
	
	if (qna != null) {
		qnaTitle = qna.getQnaTitle();
		qnaRef = qna.getQnaRef();
		qnaStep = qna.getQnaStep();
		qnaLevel = qna.getQnaLevel();
	}
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
<script src="../js/admin.js"></script>
<script>
	function check_ok() {
		if (document.board_form.category.value.length == 0) {
			alert("카테고리를 선택해주세요.");
			board_form.category.focus();
			return;
		}
		
		if (document.board_form.qnaTitle.value.length == 0) {
			alert("글 제목을 입력하세요.");
			board_form.qnaTitle.focus();
			return;
		}
		
		if (document.board_form.qnaContent.value.length == 0) {
			alert("글 내용을 입력하세요.");
			board_form.qnaContent.focus();
			return;
		}
		
		document.board_form.submit();
	}
</script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	
	<div id="content_area">
		<fieldset>
			<legend>1:1 문의 게시판</legend>
			<form name="board_form" method="post" action="qnaWrite_ok.jsp">
				<input type="hidden" name="qnaNum" value="<%= qnaNum %>">
				<input type="hidden" name="qnaRef" value="<%= qnaRef %>">
				<input type="hidden" name="qnaStep" value="<%= qnaStep %>">
				<input type="hidden" name="qnaLevel" value="<%= qnaLevel %>">
				
				<div id="info-area">
					<div id="form_flexBox_1">
						카테고리 : <br>
						글제목 : <br>
						작성자 : <br>
						비밀번호 : <br>
					</div>
					
					<div id="form_flexBox_2">
						<select name="category">
        					<option value="">선택</option>
        					<option value="상품문의">상품문의</option>
        					<option value="배송문의">배송문의</option>
        					<option value="교환/반품문의">교환/반품문의</option>
        					<option value="계정관리">계정관리</option>
        					<option value="기타문의">기타문의</option>
        				</select>
        				&nbsp;<br>
						<%
							if (qnaNum == 0) {
						%>
								<input type="text" name="qnaTitle" size="30" maxlength="200">
						<%							
							} else {
						%>
								<input type="text" name="qnaTitle" size="30" maxlength="200" value="[문의답변]:<%= qnaTitle %>">
						<%
							}
						%>
						&nbsp;<br>
						<input type="text" name="userID">
						&nbsp;<br>
						<input type="password" name="qnaPWD">
						&nbsp;<br>
						<textarea rows="10" cols="90" name="qnaContent"></textarea>
					</div>
				</div>
				
				<div id="button_area">
					<button type="button" onclick="check_ok()">등록</button>&nbsp;
					<button type="reset">다시작성</button>&nbsp;
					<button type="button" onclick="javascript:location.href='qnaList.jsp?pageNum=<%= pageNum %>'">글목록</button>
				</div>					
			</form>
		</fieldset>
	</div>
		
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>