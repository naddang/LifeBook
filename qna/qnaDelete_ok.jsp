<%@page import="lifeBookQnA.QnaBean"%>
<%@page import="lifeBookQnA.QnaDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");
	
	QnaDBBean db = QnaDBBean.getInstance();
	int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
	
	QnaBean faq = db.getQna(qnaNum);
	
	int re = db.deleteQna(qnaNum);
	
	if (re == 1) {
		response.sendRedirect("qnaList.jsp?pageNum=" + pageNum);
	} else if (re == -1) {
%>
	<script>
		alert("삭제에 실패했습니다.");
		history.go(-1);
	</script>
<%
	}
%>