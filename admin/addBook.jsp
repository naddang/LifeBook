<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	int isAdmin = userDB.isAdmin(userID);
	
	if(isAdmin == 0){
		response.sendRedirect("../intro/intro.jsp");
	}
%>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script>
/* js파일이 정상작동하지않아 부득이하게 여기에 폼을 검사하는 함수를 작성하였습니다. */
	function checkform(){
		
		if(document.bookAddForm.bookName.value == 0){
			alert("책이름은 반드시 입력되어야합니다");
			bookAddForm.bookName.focus();
			return;
		}
		
		if(document.bookAddForm.bookPrice.value == 0){
			alert("가격을 입력해주세요");
			bookAddForm.bookPrice.focus();
			return;
		}
		
		if(document.bookAddForm.bookPub.value == 0){
			alert("출판사는 반드시 입력되어야합니다");
			form.bookPub.focus();
			return;
		}
		
		if(document.bookAddForm.author.value == 0){
			alert("작가는 반드시 입력되어야합니다");
			form.author.focus();
			return;
		}
		
		if(document.bookAddForm.bookStock.value > 9999){
			alert("9999개 이상의 재고는 등록할 수 없습니다");
			form.bookStock.focus();
			return;
		}
		
		document.bookAddForm.submit();
	}
</script>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/admin.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
</head>
<body>
<!-- 관리자페이지/도서 추가 페이지 -->
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<div id="form_area">
			<fieldset>
			<legend>도서 추가</legend>
			<form action="addBookOK.jsp" name="bookAddForm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
				대분류:
				<input type="radio" name="nation" value="10">국내
				<input type="radio" name="nation" value="20">해외
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				소분류:
			  		<select name="category">
			  			<option value="101">소설</option>
			  			<option value="102">시/에세이</option>
			  			<option value="201">경제/경영</option>
			  			<option value="202">자기계발</option>
			  			<option value="301">인문학</option>
			  			<option value="302">예술/종교</option>
			  			<option value="303">정치/사회</option>
			  			<option value="304">역사</option>
			  			<option value="401">과학</option>
			  			<option value="402">기술/공학</option>
			  			<option value="403">컴퓨터/IT</option>
			  			<option value="501">유아(~7세)</option>
			  			<option value="502">어린이</option>
			  			<option value="601">초등참고서</option>
			  			<option value="602">중고등참고서</option>
			  			<option value="603">대학교재</option>
			  			<option value="604">수험서</option>
			  			<option value="605">외국어</option>
			  			<option value="701">가정/육아</option>
			  			<option value="702">건강/헬스/스포츠</option>
			  			<option value="703">여행/요리</option>
			  			<option value="704">취미</option>
			  			<option value="801">만화</option>
			  			<option value="802">잡지</option>
			  		</select>
			  		<br>
			  		도서 이름:
				   	<input type="text" name="bookName" placeholder="도서 이름을 적어주세요" maxlength="20" class="text_box">
				   	<br>
			  		도서 가격:
				   	<input type="number" name="bookPrice" placeholder="가격을 입력해주세요" maxlength="20" class="text_box">
				   	<br>
			  		도서 정보
			  		<br>
			  		<textarea rows="10" cols="100" name="bookDetails" placeholder="상세정보를 입력해주세요."></textarea>
				   	<!-- <input type="text" name="bookDetails" placeholder="도서 정보를 적어주세요" maxlength="3000" id="text_box">
				   	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
				   	<br>
			  		도서 표지:
				   	<input type="file" name="bookImg">
				   	<br>
			  		출판사 : &nbsp;&nbsp;
				   	<input type="text" name="bookPub" placeholder="출판사를 적어주세요" maxlength="20" class="text_box">
				   	<br>
			  		작 가 : &nbsp;&nbsp;&nbsp;&nbsp;
				   	<input type="text" name="author" placeholder="작가의 이름을 적어주세요" maxlength="20" class="text_box">
				   	<br>
			  		재고 수량:
				   	<input type="number" name="bookStock" placeholder="재고 수량을 적어주세요" max="9999" value="1" maxlength="4" min="1" class="text_box">
	  		</form>
			</fieldset>
	  		<div id="button_area">
				<button type="button" id="submit_btn" onclick="checkform()">작성 완료</button>
				<button id="btn2" onclick="location.href='../admin/index.jsp'">작성 취소</button>
			</div>
		</div>
	</div>
    <footer>
    	<jsp:include page="../intro/footer.jsp"></jsp:include>
    </footer>
</body>
</html>