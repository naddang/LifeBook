<%@page import="reviewcmt.ReviewCmtDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@page import="lifeBookBoardComment.CommentDBBean"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rvCmt" class="reviewcmt.ReviewCmtBean"></jsp:useBean>
<jsp:setProperty property="*" name="rvCmt"/>
<%
	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));

	String pageNum;
	if ((request.getParameter("pageNum")) != null) {
		pageNum = request.getParameter("pageNum");
	} else {
		pageNum = "1"; 
	}
	rvCmt.setRegDate(new Timestamp(System.currentTimeMillis()));
	
	ReviewCmtDBBean rvCmtDB = ReviewCmtDBBean.getInstance(); 
	
	if (rvCmt.getRvCmtContent() == null) {
		out.println("<script>");
		out.println("alert('댓글을 입력해주세요.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		int res = rvCmtDB.insertRvCmt(rvCmt);
		
		if (res == -1) {
			out.println("<script>");
			out.println("alert('댓글쓰기에 실패했습니다.')");
			out.println("history.back()");
			out.println("</script>");	
		} else {
			String url = "showReview.jsp?reviewNum=" + reviewNum + "&pageNum=" + pageNum;
			out.println("<script>");
			out.println("location.href='" + url + "'");
			out.println("</script>");
		}
	}
%>