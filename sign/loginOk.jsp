<%@page import="userInfo.UserInfoBean"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="org.apache.el.lang.ELSupport"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String userID = request.getParameter("userID");
	String userPWD = request.getParameter("userPWD");
	String userName = request.getParameter("userName");
	String save_chk = request.getParameter("save_chk"); //���̵� �����ϱ� üũ ���� ������
	
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int check = userDB.userCheck(userID, userPWD);
	UserInfoBean user = userDB.getUser(userID);
	
	if(user == null){
%>
		<script>
			alert("�������� �ʴ� ȸ��");
			history.go(-1);
		</script>
<%
	}else{
		if(check == 1){
			session.setAttribute("userID", userID);
			session.setAttribute("isMember", "yes");
			session.setAttribute("userName", userName);
			
			if(save_chk != null && save_chk.equals("Y")){  //[���̵� �����ϱ�]üũ Ȯ��
				UserInfoDBBean.makeCookie(response, "loginId", userID, 60*60*24); //��Ű����
			}else{
				UserInfoDBBean.deleteCookie(response, "loginId"); //��Ű����
			}
			
			response.sendRedirect("../intro/intro.jsp"); 
		}else if(check == 0){
%>
			<script>
				alert("��й�ȣ�� ���� �ʽ��ϴ�.");
				history.go(-1);
			</script>
<%
		}else{
%>
			<script>
				alert("���̵� ���� �ʽ��ϴ�.");
				history.go(-1);
			</script>
<%
			
		}
	}
%>
