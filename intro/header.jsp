<%@page import="userInfo.UserInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="pop_close">
<title>Insert title here</title>
<script>
function window_open() { 
	window.name = "intro-page";
	window.open("../sign/login.jsp","" ,"width=800, height=800, left=100, top=50");
	}
</script>
<style type="text/css">
*{
    font-family: 'GmarketSansMedium';
}
</style>
</head>
<body>
 	<%
		if(session.getAttribute("Member") == null){
			response.sendRedirect("../sign/login.jsp");
		}
	%>
	<%
		String userID = (String)session.getAttribute("userID");
		UserInfoDBBean userDB = UserInfoDBBean.getInstance();
	%>
	<div id="header-wrap">
		<header class="header-inner">
			<h1>
				<a href="../intro/intro.jsp">
				<picture>
					<source media="(max-width:800px)" srcset="../images/title2.png">
					<img src="../images/title1.png" alt="인생책방">
				</picture>
				</a>
			</h1>
			<p class="mobile-menu-open">
				<button>
								<span class="blind">메뉴 열기</span>
								<span></span>
								<span></span>
								<span></span>
				</button>
			</p>
			<div class="mobile-menu-wrap">
				<div class="mobile-menu-scroll">
			<!-- 회원 -->
			<%
				if(userID != null){
			%>
				<div class="util-menu-top">
					<ul class="util-menu">
						<li><a href="../myPage/my.jsp"><%=userID%>님!</a></li>
						<li><a href="../intro/intro.jsp">Home</a></li>
						<li><a href="../sign/logOut.jsp">Logout</a></li>
						<li><a href="../myPage/cart.jsp">Cart</a></li>
			<%
					if(userDB.isAdmin(userID) == 1){
			%>
						<li><a href="../admin/index.jsp">관리자 페이지로</a></li>
			<%
					}
			%>
					</ul>
				</div>
			
			<%	
			/* 비회원  */
				} else {
			%>
				<div class="util-menu-top">
					<ul class="util-menu">
						<li><a href="../intro/intro.jsp">Home</a></li>
						<li><a href="javascript:window_open()" id="btn">Login</a></li>
						<li><a href="../sign/login.jsp">Cart</a></li>
					</ul>
				</div>	
			<%
				}
			%> 
					<nav id="gnb">
						<!-- <h2 class="blind">메인메뉴</h2> -->
						<ul>
							<li class="m1">
								<a href="../intro/about.jsp" >인생책방</a>
								<ul>
									<li><a href="../intro/about.jsp">인생책방 소개</a></li>
									<li><a href="../intro/how-to-come.jsp">오시는 길</a></li>
								</ul>
							</li>
							<li class="m2">
								<a href="../mall/best.jsp">쇼핑몰</a>
								<ul>
									<li><a href="../mall/best.jsp">베스트셀러</a></li>
				                    <li><a href="../mall/sort.jsp">책 검색</a></li>
								</ul>
							</li>
							<li class="m3">
								<a href="../board/freeboard.jsp">게시판</a>
								<ul>
									<li><a href="../review/reviewList.jsp">책 후기</a></li>
	                    			<li><a href="../board/freeboard.jsp">자유게시판</a></li>
								</ul>
							</li>
							<li class="m4">
								<a href="../notice/list.jsp">고객의 소리</a>
								<ul>
									<li><a href="../notice/list.jsp">공지사항</a></li>
	                    			<li><a href="../faq/faqList.jsp">FAQ</a></li>
	                    			<li><a href="../qna/qnaList.jsp">1:1문의</a></li>
								</ul>	
							</li>
						</ul>
					</nav>
				</div>
				<p class="mobile-menu-close">
					<button>
						<span class="blind">메뉴닫기</span>
						<span></span>
						<span></span>
					</button>
				</p>
			</div>
		</header>
	</div>
	</body>
</html>