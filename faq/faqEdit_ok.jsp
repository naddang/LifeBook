<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="lifeBookFAQ.FaqDBBean"%>
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
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="faq" class="lifeBookFAQ.FaqBean"></jsp:useBean>
<jsp:setProperty property="*" name="faq"/>
<%
	String pageNum = request.getParameter("pageNum");

	FaqDBBean edit = FaqDBBean.getInstance();
	
	int faqNum = Integer.parseInt(request.getParameter("faqNum"));
	int re = edit.editFaq(faq);

	if (re == 1) {
%>
	<script>
		alert("수정에 성공했습니다.");
	</script>
<%
		response.sendRedirect("../faq/faqList.jsp");
				
	} else if (re == -1) {
%>
	<script>	
	    alert("수정에 실패했습니다.");
	    history.go(-1);
	</script>
<%		
	}
%>