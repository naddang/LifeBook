<%@page import="reviewcmt.ReviewCmtDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int rvCmtNum = Integer.parseInt(request.getParameter("rvCmtNum"));
	ReviewCmtDBBean rvCmtDB = ReviewCmtDBBean.getInstance();
	int re = rvCmtDB.deleteRvCmt(rvCmtNum);
	
	if(re == 1){
		%>
			<script>
				alert("삭제완료");
				history.go(-1);
			</script>
		<%
	}else{
		%>
			<script>
				alert("실패");
				history.back();
			</script>
		<%
	}
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>