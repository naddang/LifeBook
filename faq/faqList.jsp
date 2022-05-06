<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="lifeBookFAQ.FaqBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="lifeBookFAQ.FaqDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// 페이지 넘버 받기
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	
	// 데이터 베이스 연결
	FaqDBBean db = FaqDBBean.getInstance();
	ArrayList<FaqBean> faqList = db.listFaq(pageNum);
	
	// 변수 설정
	int faqNum;
	String faqCategory, faqTitle, faqContent;
	Timestamp regDate;
	
	// 날짜 데이터 형식 변환
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String userID = (String)session.getAttribute("userID");
	UserInfoDBBean userDB = UserInfoDBBean.getInstance();
%>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/faq.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script type="text/javascript">
$(function() {
	
    var menu_ul = $('.menu > li > ul'), //menu클래스의 li의 자식인 ul
           menu_a  = $('.menu > li > a'); //menu클래스의 li의 자식인 a
    
    menu_ul.hide();

    menu_a.click(function(e) {
        e.preventDefault();//기본동작을 방지함
        if(!$(this).hasClass('active')) { // active라는건 동작중이라는것->동작중이 아닌경우
            menu_a.removeClass('active'); // 동작을 멈추게하고
            menu_ul.filter(':visible').slideUp('normal'); //menu_ul를 보이게하고 slideUp함
            $(this).addClass('active').next().stop(true,true).slideDown('normal');//동작하게하고 
        } else {//동작중일때
            $(this).removeClass('active');//동작하는것을 멈추게하고
            $(this).next().stop(true,true).slideUp('normal');//현재 동작중인것을 전부 중단하고 slideUp함
        }
    });
    
    $(".menu > li:odd").css({"background":"#F6EEE6"});
    $(".menu > li:even").css({"background":"#F3ECE6"});
    
    $(".answer").css({"background":"#FFFCF9"});
    
    $(".menu > li").hover(
    	function(){
    		$(this).css({"background":"#E3DBCE"});
    	},
    	function() {
    		$(".menu > li:odd").css({"background":"#F6EEE6"});
    	    $(".menu > li:even").css({"background":"#F3ECE6"});
		}
    	);
});
</script>
<style type="text/css">
	#faq_content{
		padding-top: 50px;
		padding-bottom: 50px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더영역 -->
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
	<!-- 섹션 영역 -->
		<div id="wrapper">
			<div id="title">자주 묻는 질문</div>
				<!-- 관리자 로그인이 확인되면 글쓰기 버튼 노출하게 처리해야함 -->
	<%
				if(userDB.isAdmin(userID) == 1){
	%>
			<div id="wirteBtn">
				<button type="button" onclick="location.href='faqWrite.jsp'">글쓰기</button>
			</div>
	<%
				}
	%>
			<div id="menu_area">
				<ul class="menu">
	<%
					for (int i = 0; i < faqList.size(); i++) {
						FaqBean faq = faqList.get(i);
						
						faqNum = faq.getFaqNum();
						faqCategory = faq.getFaqCategory();
						faqTitle = faq.getFaqTitle();
						faqContent = faq.getFaqContent();
						regDate = faq.getRegDate();
	%>
					<li> <a href="#"> <img src="../images/icon_q.gif"> <b> [<%=faqCategory %>]</b> <%=faqTitle %> </a>
						<ul >
							<li class="answer">
								<hr>
								<div id="faq_content">
									<img alt="x" src="../images/icon_a.gif"> 
									<%=faqContent.replace("\r\n", "<br>") %> 
									<br><br>
	<%
						if(userDB.isAdmin(userID) == 1){
	%>
									<button type="button" onclick="location.href='../faq/faqEdit.jsp?faqNum=<%=faqNum%>'">수정하기</button>
	<%	
						}
	%>
								</div> 
							</li>				
						</ul>
					</li>
	<%
					}
	%>	
				</ul>
			</div>
			
			<div class="searchArea">
				<form method="post" action="faqSearch.jsp"> 
		        	<table>
		        		<tr>
		        			<td>
		        				<select name="searchField">
		        					<option value="0">선택</option>
		        					<option value="faqCategory">카테고리</option>
		        					<option value="faqTitle">글제목</option>
		        				</select>
		        			</td>
		        			<td>
		        				<input type="text" size="40" name="searchText" placeholder="검색어 입력">	
		        			</td>
		        			<td>
				               <input type="submit" value="검색">
		        			</td>
		        		</tr>
		        	</table>
		       	</form>
				</div> 
				<br>
				<div id="pageArea"><%= FaqBean.pageNumber(5) %></div>
			</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
	</div>
</body>
</html>