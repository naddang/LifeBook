<%
	request.setCharacterEncoding("UTF-8");
%>
<%@page import="lifeBookBoardComment.CommentDBBean"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cmt" class="lifeBookBoardComment.CommentBean"></jsp:useBean>
<jsp:setProperty property="*" name="cmt"/>
<%
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	String pageNum;
	if ((request.getParameter("pageNum")) != null) {
		pageNum = request.getParameter("pageNum");
	} else {
		pageNum = "1"; 
	}
	cmt.setRegDate(new Timestamp(System.currentTimeMillis()));
	
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();
	cmt.setUserIP(ip);
	
	CommentDBBean cmtdb = CommentDBBean.getInstance(); 
	
	if (cmt.getCmtContent() == null) {
		out.println("<script>");
		out.println("alert('댓글을 입력해주세요.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		cmtdb = new CommentDBBean();
		int res = cmtdb.write(cmt);
		
		if (res == -1) {
			out.println("<script>");
			out.println("alert('댓글쓰기에 실패했습니다.')");
			out.println("history.back()");
			out.println("</script>");	
		} else {
			String url = "show.jsp?boardNum=" + boardNum + "&pageNum=" + pageNum;
			out.println("<script>");
			out.println("location.href='" + url + "'");
			out.println("</script>");
		}
	}
%>