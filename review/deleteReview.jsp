<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/review.css">
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
		<div id="title">���並 �����Ͻðڽ��ϱ�?</div> <br>
		<div id="menu_area" style="margin: 0 auto;">
			<button type="button" onclick="deleteReviewOK.jsp?reviewNum=<%=reviewNum%>">��</button>
			<button type="button" onclick="history.go(-1)">�ƴϿ�</button>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>