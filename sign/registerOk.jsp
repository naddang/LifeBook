<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="userInfo.UserInfoBean"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<%
	UserInfoDBBean manager = UserInfoDBBean.getInstance();
	//받아온 연,월,일을 변수에 담음
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = request.getParameter("date");
	//Timestamp에 들어갈 수 있도록 양식을 맞춰줌
	String birthdate = year+"-"+month+"-"+date+" 00:00:00.0";
	Timestamp ts = Timestamp.valueOf(birthdate);
	user.setUserBirth(ts);
	
	int isAdmin = 0;  //1이 관리자 0이 일반회원   원래는 1이 관리자 2가 일반회원이었다
	user.setIsAdmin(isAdmin);  //관리자는 처음부터 있고 시작하고, 회원가입은 무조건 일반회원으로 가입되게 한다
	
	//받아온 전화번호를 합쳐서 변수에 넣음
	String tels = request.getParameter("user_tel1")+request.getParameter("user_tel2")+request.getParameter("user_tel3");
	user.setUserPhoneNum(tels);
	
	//받아온 주소를 합쳐서 변수에 넣음
	String addr = request.getParameter("postAddr1")+", "+request.getParameter("postAddr2")+", "+request.getParameter("postAddr3");
	user.setUserAddr(addr);
	
	if(manager.confirmID(user.getUserID()) == 1){ // 같은 id가 이미 있다면
%>
		<script>
			alert("중복되는 아이디가 존재합니다.");
			history.back();
		</script>
<%
	}else{
		int re = manager.insertUser(user);
		
		if(re == 1){
%>
			<script type="text/javascript">
				alert("회원가입을 축하드립니다.\n회원으로 로그인 해주세요.");
				document.location.href="login.jsp";
			</script>
<%
		}else{
%>
			<script>
				alert("회원가입에 실패했습니다.");
				document.location.href="login.jsp";
			</script>
<%
		}
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>