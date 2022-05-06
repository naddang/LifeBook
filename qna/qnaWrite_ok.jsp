<%@page import="lifeBookQnA.QnaDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="qna" class="lifeBookQnA.QnaBean"></jsp:useBean>
<jsp:setProperty property="*" name="qna"/>
<%
	qna.setRegDate(new Timestamp(System.currentTimeMillis()));

	QnaDBBean db = QnaDBBean.getInstance();
	
	int re = db.insertQna(qna);
	
	if (re == 1) {
		response.sendRedirect("qnaList.jsp");
	} else {
		response.sendRedirect("qnaWrite.jsp");
	}
%>