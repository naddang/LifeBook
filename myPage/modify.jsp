<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="userInfo.UserInfoBean"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="java.lang.String.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userID = (String)session.getAttribute("userID");

	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	UserInfoBean user = userDB.getUser(userID);
	String addr2 = "";   //도로명 주소
	String addr3 = "";
	
	String userPhoneNum = user.getUserPhoneNum();
	
	Timestamp userBirth = user.getUserBirth();
	
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
	String birthdate = transFormat.format(userBirth);
	
	String split1 = "-";
	String[] sArray1 = birthdate.split(split1);
	String year = sArray1[0];  //태어난 해
	String date = sArray1[2];   //태어난 일
	
	String tel1 = userPhoneNum.substring(3, 7);   //전화번호 가운뎃자리
	String tel2 = userPhoneNum.substring(7, 11);  //전화번호 뒷자리
	
	String addr = user.getUserAddr();
	StringTokenizer st = new StringTokenizer(addr, ",");
	 
	String addr1 = st.nextToken();   //우편번호
	if(st.hasMoreElements()){
		addr2 = st.nextToken();  //도로명 주소
	}
	if(st.hasMoreElements()){
		addr3 = st.nextToken();   //상세 주소
	}
	
	
	if(session.getAttribute("isMember") == null){
		response.sendRedirect("login.jsp");
	}
	
	int isAdmin = user.getIsAdmin(); 
	String admin = "";
	
	if(isAdmin == 1){
		admin = "일반회원";
	}else{
		admin = "관리자";
	}
	
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/modify.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script src="../js/sign.js"></script>
<script src="../js/modify.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
/* 		function findAddr(){
			var width = 500; //팝업창의 너비
			var height = 600; //팝업창의 높이
			var left = (window.screen.width*0.5)-(width*0.5); //잘 구동되는데 /2를 사용하면 밑줄이 그임
			var top = (window.screen.height*0.5)-(height*0.5); //그래서 *0.5를 줬다
			new daum.Postcode({
				width: width,
				height: height,
				oncomplete: function(data) {
					
						console.log(data);
					//팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					//도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					//내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다
					var roadAddr = data.roadAddress; //도로명 주소 변수
					var jibunAddr = data.jibunAddress; //지번 주소 변수
					
					//우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postAddr1').value = data.zonecode;
					
					if (roadAddr !== '') {
						document.getElementById('postAddr2').value = roadAddr;
					}else if (jibunAddr !== '') {
						document.getElementById('postAddr2').value = jibunAddr;
					}
				}
			}).open({
				left: left,
				top: top
			});
		} */
	</script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
	<fieldset>
	<legend id="subject">회원 정보 수정</legend>
	<div class="top">
		<p id="reference">'*' 표시 항목은 필수 입력 항목입니다.</p>
	</div>
		<div class="container">
			<hr>
			<form name="reg_frm" method="post" action="modifyOk.jsp">
				<div class="title">User ID</div>
				<div class="title">
					<%= user.getUserID() %>
				</div>
				<div class="title">현재 암호*</div>
				<div>
					<input type="password" class="box" size="20" name="ori_user_pwd" placeholder="Password">
				</div>
				<div class="title">새 암호*</div>
				<div>
					<input type="password" class="box" size="20" name="userPWD" placeholder="Password">
				</div>
				<div class="title">새 암호 확인*</div>
				<div>
					<input type="password" size="20" class="box" name="userPWD_check" placeholder="Check Password">
				</div>
				<div class="title">이 름</div>
				<div class="title">
					<%= user.getUserName() %>
				</div>
				<div class="title">전화번호*</div>
				<div>
					<select name="user_tel1" class="telbox">
						<option value="010" selected="selected">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="019">019</option>
					</select>
					-
					<input type="number" size="4" name="user_tel2" maxlength="4" class="telbox" value="<%= tel1 %>">
					-
					<input type="number" size="4" name="user_tel3" maxlength="4" class="telbox" value="<%= tel2 %>">
				</div>
				<div class="title">주 소*</div>
				<div>
					<input type="text" class="box postbox" id="postAddr1" name="postAddr1" value="<%= addr1 %>" readonly="readonly">
					<input type="button" onclick="findAddr()" value="우편번호 찾기" class="box postchk btn1 btn2 btnFade">
				</div>
				<div class="addr2">
					<input type="text" size="30" class="box roadbox" id="postAddr2" name="postAddr2" value="<%= addr2 %>" readonly="readonly"><br>
					<input type="hidden" class="box" placeholder="지번주소" id="user_jibunAddr">
				</div>
				<div class="addr3">
					<input type="text" size="30" class="box detailbox" name="postAddr3" id="postAddr3" value="<%= addr3 %>">
				</div>
				<div class="title">생년월일*</div>
				<div>
					<input type="text" name="year" class="box birthbox" maxlength="4" size="5" value="<%=year%>">
					<select name="month" class="box birthbox">
	                       <option value="01">1월</option>
	                       <option value="02">2월</option>
	                       <option value="03">3월</option>
	                       <option value="04">4월</option>
	                       <option value="05">5월</option>
	                       <option value="06">6월</option>
	                       <option value="07">7월</option>
	                       <option value="08">8월</option>
	                       <option value="09">9월</option>                                    
	                       <option value="10">10월</option>
	                       <option value="11">11월</option>
	                       <option value="12">12월</option>
	                   </select>
	                   <input type="text" name="date" class="box birthbox" maxlength="2" placeholder="예)01일" size="5" value="<%=date%>">
				</div><br><br><br>
				<div>
					<input type="button" class="btn1 btn2 btnFade" value="수정하기" onclick="modify_check_ok()">&nbsp&nbsp&nbsp
					<input type="reset" class="btn1 btn2 btnFade" value="다시입력">&nbsp&nbsp&nbsp
					<input type="button" class="btn1 btn2 btnFade" value="수정취소" onclick="javascript:window.location.href='../intro/intro.jsp'">
				</div>
			</form>
		</div>
	</fieldset>
	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>