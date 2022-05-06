<%@page import="lifeBookQnA.QnaDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="qna" class="lifeBookQnA.QnaBean"></jsp:useBean>
<jsp:setProperty property="*" name="qna"/>
<%
	String pageNum = request.getParameter("pageNum");

	QnaDBBean edit = QnaDBBean.getInstance();
	
	int qnaNum = Integer.parseInt(request.getParameter("qnaNum"));
	int re = edit.editQna(qna);

	if (re == 1) {
%>
	<script>
		alert("수정에 성공했습니다.");
	</script>
<%
		response.sendRedirect("qnaShow.jsp?qnaNum=" + qnaNum);
				
	} else if (re == -1) {
%>
	<script>	
	    alert("수정에 실패했습니다.");
	    history.go(-1);
	</script>
<%		
	}
%>
