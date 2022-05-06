<%@page import="reviewcmt.ReviewCmtDBBean"%>
<%@page import="review.ReviewDBBean"%>
<%@page import="lifeBookBoardComment.CommentDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="rvCmt" class="reviewcmt.ReviewCmtBean"></jsp:useBean>
<jsp:setProperty property="*" name="rvCmt"/>
<%
	String pageNum = request.getParameter("pageNum");
	
	ReviewCmtDBBean rvCmtDB = ReviewCmtDBBean.getInstance();	

	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
	int rvCmtNum = Integer.parseInt(request.getParameter("rvCmtNum"));
	
	int re = rvCmtDB.updateRvCmt(rvCmt);
	
	if (re == 1) {
%>
	<script>
		alert("댓글이 수정되었습니다.");
	</script>
<%
		response.sendRedirect("showReview.jsp?reviewNum=" + reviewNum);
				
	} else if (re == -1) {
%>
	<script>	
	    alert("수정에 실패했습니다.");
	    history.go(-1);
	</script>
<%		
			}
%>