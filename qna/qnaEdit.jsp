<%@page import="lifeBookQnA.QnaBean"%>
<%@page import="lifeBookQnA.QnaDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	String pageNum = request.getParameter("pageNum");
	
	int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));

	QnaDBBean edit = QnaDBBean.getInstance();
	QnaBean qna = edit.getQna(qnaNum);
%>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::QnA수정</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script>
	function check_ok() {
		if (document.board_form.category.value.length == 0) {
			alert("카테고리를 선택해주세요.");
			board_form.category.focus();
			return;
		}
		
		if (document.board_form.qnatitle.value.length == 0) {
			alert("글 제목을 입력하세요.");
			board_form.qnatitle.focus();
			return;
		}
		
		if (document.board_form.qnacontent.value.length == 0) {
			alert("글 내용을 입력하세요.");
			board_form.qnacontent.focus();
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
		<h1>1:1 문의 게시판</h1>
		<form name="board_form" method="post" action="qnaEdit_ok.jsp?qnanum=<%= qnaNum %>&pageNum=<%= pageNum %>">
			<table>
				<tr>
					<td>카테고리</td>
					<td>
						<select name="category">
        					<option value="">선택</option>
        					<option value="상품문의">상품문의</option>
        					<option value="배송문의">배송문의</option>
        					<option value="교환/반품문의">교환/반품문의</option>
        					<option value="계정관리">계정관리</option>
        					<option value="기타문의">기타문의</option>
        				</select>
					</td>
				</tr>
				
				<tr height="30">
					<td>글제목</td>
					<td colspan="3">
						<input type="text" name="qnaTitle" size="30" maxlength="200" value="<%= qna.getQnaTitle() %>">
					</td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td>
						<input type="text" name="userID" value="<%= qna.getUserID() %>" readonly>
					</td>
					<td>비밀번호</td>
					<td>
						<input type="password" name="qnaPWD">
					</td>
				</tr>
				
				<tr>
					<td colspan="4">
						<textarea rows="10" cols="65" name="qnaContent"><%= qna.getQnaContent() %></textarea>
					</td>
				</tr>
				
				<tr height="50" align="center">
					<td colspan="4">
						<input type="button" value="등록" onclick="check_ok()">&nbsp;
						<input type="reset" value="다시작성">&nbsp;
						<input type="button" value="글목록" onclick="javascript:location.href='qnaList.jsp?pageNum=<%= pageNum %>'">
					</td>				
				</tr>
			</table>
		</form>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>