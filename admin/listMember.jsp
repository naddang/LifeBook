<%@page import="java.text.SimpleDateFormat"%>
<%@page import="userInfo.UserInfoBean"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.managementMemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.managementMemberDBBean"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = (String)session.getAttribute("userID");
	String pageNum = "1";
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
	}
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<jsp:useBean id="member" class="member.managementMemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>    
<%
	ArrayList<UserInfoBean> users = userDB.getAllUser(pageNum);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<html>
<head>
<meta charset="EUC-KR">
<title>�λ�å��::ȸ������</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<!-- <link rel="stylesheet" href="../css/main.css"> -->
<link rel="stylesheet" href="../css/admin.css">
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
		<div id="title">ȸ������</div>
		<div id="index_btn"><button type="button" onclick="location.href='../admin/index.jsp'">������ ��������</button></div>
		<div id="table_area">
			<table>
				<tr align="center">
					<th width="150px">���̵�</th>
					<th width="80px">�̸�</th>
					<th width="150px">�޴�����ȣ</th>
					<th width="350px">�ּ�</th>
					<th width="100px">����</th>
					<th width="80px">ȸ�� ����</th>
				</tr>
				<%				
					for(int i = 0; i < users.size(); i++){
						UserInfoBean user = users.get(i);
				%>
				<tr align="center">
					<td><%=user.getUserID()%></td>
					<td><%=user.getUserName() %></td>
					<td><%=user.getUserPhoneNum()%></td>
					<td><%=user.getUserAddr()%></td>
					<td><%=sdf.format(user.getUserBirth())%></td>	
					<td><button type="button" onclick="location='managementMember.jsp?userID=<%=user.getUserID()%>'" class="management_btn">����</button></td>				
				</tr>						
				<%
					}
				%>		
			</table>
		</div>
		<div id="page_area">
			<p><%=UserInfoBean.pageNumber(4) %></p>
		</div>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>