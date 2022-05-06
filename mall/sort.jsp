<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/sort.css">
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script src="../js/admin.js"></script>
<script type="text/javascript">
	function searchCheck() {
		if (document.bookSearchForm.search.value == 0) {
			alert("검색창을 입력해 주세요");
			return;
		}
		document.bookSearchForm.submit();
	}
</script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<div id="title">책 검색 페이지</div>
		<div class="search_area">
			<div class="search_input">
				<form action="searchResult.jsp?search=?" name="bookSearchForm">
				<label for="search">
					<input type="text" name="search" size="50" id="search" class="text_input" placeholder="    책 제목 또는 저자로 검색하기">
				</label>
				<button type="button" onclick="searchCheck()" class="search_btn">검색</button>
			</form>
			</div>
		</div>
		<div id="total">
		
		<div id="korean" align="center">
		<table class="tb1">
			<tr>
				<th>국내</th>
			</tr>
			<tr>
				<td>
					<p class="cate">문학</p>
					<a href="searchResult.jsp?category=10101">소설</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10102">시/에세이</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10201">경제/경영</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10202">자기계발</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10301">인문학</a>
					<hr>
					
					<p class="cate">사회</p>
					<a href="searchResult.jsp?category=10302">예술/종교</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10303">정치/사회</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10304">역사</a>
					<hr>
					
					<p class="cate">과학</p>
					<a href="searchResult.jsp?category=10401">과학</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10402">기술/공학</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10403">컴퓨터/IT</a>
					<hr>
					
					<p class="cate">유아/학습</p>
					<a href="searchResult.jsp?category=10501">유아(~7세)</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10502">어린이</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10601">초등참고서</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10602">중고등참고서</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10603">대학교재</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10604">수험서</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10605">외국어</a>
					<hr>
					
					<p class="cate">생활</p>
					<a href="searchResult.jsp?category=10701">가정/육아</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10702">건강/헬스/스포츠</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10703">여행/요리</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10704">취미</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10801">만화</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=10802">잡지</a>
					<hr>
				</td>
			</tr>
		</table>
		</div>
		<div id="global" align="center">
		<table class="tb2">
			<tr>
				<th>해외</th>
			</tr>
			<tr>
				<td>
					<p class="cate">문학</p>
					<a href="searchResult.jsp?category=20101">소설</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20102">시/에세이</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20201">경제/경영</a> |&nbsp;&nbsp;
					<a href="searchResult.jsp?category=20202">자기계발</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20301">인문학</a>
					<hr>
					
					<p class="cate">사회</p>
					<a href="searchResult.jsp?category=20302">예술/종교</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20303">정치/사회</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20304">역사</a>
					<hr>
					
					<p class="cate">과학</p>
					<a href="searchResult.jsp?category=20401">과학</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20402">기술/공학</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20403">컴퓨터/IT</a>
					<hr>
					
					<p class="cate">유아/학습</p>
					<a href="searchResult.jsp?category=20501">유아(~7세)</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20502">어린이</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20601">초등참고서</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20602">중고등참고서</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20603">대학교재</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20604">수험서</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20605">외국어</a>
					<hr>
					
					<p class="cate">생활</p>
					<a href="searchResult.jsp?category=20701">가정/육아</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20702">건강/헬스/스포츠</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20703">여행/요리</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20704">취미</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20801">만화</a> &nbsp;&nbsp;
					<a href="searchResult.jsp?category=20802">잡지</a>	
					<hr>			
				</td>
			</tr>			
		</table>
		</div>
		</div>
		<div class="menu_area" align="center">
			<button type="button" onclick="location='../intro/intro.jsp'" class="btn1">메인 화면</button>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" onclick="location='./best.jsp'" class="btn1">베스트셀러</button>
		</div>

	</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>