<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookQnA.QnaBean"%>
<%@page import="lifeBookQnA.QnaDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 데이터 한글 처리
	request.setCharacterEncoding("UTF-8");	
	
	// FAQ 리스트 페이지 번호
	String pageNum = request.getParameter("pageNum");
	
	// 날짜 표시 형식 변경
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	// QNA 리스트에서 해당글 번호 받기
	int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
	
	// QNA 테이블에서 정보 받기 위해 데이터베이스 연결
	QnaDBBean db = QnaDBBean.getInstance();
	QnaBean qna = db.getQna(qnaNum);
	
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	String userID = (String)session.getAttribute("userID"); 
%>
<html>
<head>
<meta charset="UTF-8">
<title>인생책방::QnA</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
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
		<div id="title">
			<h1>1:1 문의 게시판</h1>
		</div>
		
		<div id="boardArea">
			<table border="1" width="900" cellspacing="0">
				<tr>
					<td colspan="4">
						<h1 class="title" style="padding: 10px"><b>[<%= qna.getCategory() %>]<%= qna.getQnaTitle() %></b></h1>
					</td>
				</tr>
			
				<tr height="30" align="center">
					<td width="150" align="center">글번호</td>
					<td width="300" align="center"><%= qnaNum %></td>
					<td width="150" align="center">작성일</td>
					<td width="300" align="center"><%= sdf.format(qna.getRegDate()) %></td>
				</tr>
		
				<tr height="30">
					<td align="center">작성자</td>
					<td colspan="3" width="200" align="center"><%= qna.getUserID() %></td>
				</tr>
				
				<tr height="100">
					<td colspan="4" style="padding: 10px">
						<%= qna.getQnaContent() %>
					</td>
				</tr>
				
			</table>
		</div>
		
		<div id="writeBtn">
<%		if(userDB.isAdmin(userID) == 1){
%>
			<input type="submit" value="답글" onclick="location.href='qnaWrite.jsp?qnaNum=<%= qna.getQnaNum() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
<%
		}
%>
			<input type="submit" value="글수정" onclick="location.href='qnaEdit.jsp?qnaNum=<%= qna.getQnaNum() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" value="글삭제" onclick="location.href='qnaDelete_ok.jsp?qnaNum=<%= qna.getQnaNum() %>&pageNum=<%= pageNum %>'">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글목록" onclick="window.location='qnaList.jsp?pageNum=<%= pageNum %>'">
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>