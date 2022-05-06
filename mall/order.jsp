<%@page import="userInfo.UserInfoBean"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="bookInfo.BookInfoBean"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//쿼리스트링 값과 세션에서 얻어온 아이디값을 변수에 저장
	int bookNum = Integer.parseInt(request.getParameter("bookNum"));
	int amount = 1;
	if(request.getParameter("amount") != null){
		amount = Integer.parseInt(request.getParameter("amount"));
	}
	String userID = "비회원";
	String userName = "";
	String userAddr = "";
	String userPhoneNum = "";
	if(session.getAttribute("isMember") != null){
		userID = (String)session.getAttribute("userID");
		UserInfoDBBean userdb = UserInfoDBBean.getInstance();
		UserInfoBean user = userdb.getUser(userID);
		
		userName = user.getUserName();
		userAddr = user.getUserAddr();
		userPhoneNum = user.getUserPhoneNum();
	}
	
	//db객체들 생성
	BookInfoDBBean bookdb = BookInfoDBBean.getInstance();
	
	//얻어온 정보들로 책과 유저 객체 생성
	BookInfoBean book = bookdb.getBookInfo(bookNum);
%>
<html>
<head>
<style> 
</style>
<link rel="stylesheet" href="../css/order.css">
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script src="../js/admin.js"></script>
<title>Insert title here</title>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		function checkForm() {
			
			var addr1 = $("#postAddr1").val();
            var addr2 = $("#postAddr2").val()+$("#postAddr3").val();
            var orderAddr = addr1 + addr2;
            
			if(document.deliveryForm.orderRecipient.value == 0){
				alert("받는사람 이름은 필수입니다.");
				return;
			}
			if(document.deliveryForm.orderPhoneNum.value == 0){
				alert("연락처는 필수입니다.");
				return;
			}
			if(orderAddr.value == 0){
				alert("배송지는 필수입니다.");
				return;
			}
			
			iamport();
			
		}
	    function iamport(){
			//가맹점 식별코드
			IMP.init('imp37252376');
			
			//폼에서 보내준 값들
            var userName = $("#userName").val();
            var userID = $("#userID").val();
            var userPhoneNum = $("#userPhoneNum").val();
            var addr1 = $("#postAddr1").val();
            var addr2 = $("#postAddr2").val()+$("#postAddr3").val();
            var email = $("#email").val();
            var bookName = $("#bookName").val();
            var amount = $("#amount").val();
            
			IMP.request_pay({
			    pg : 'inicis',
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : bookName , //결제창에서 보여질 이름
			    amount : amount, //실제 결제되는 가격
			    buyer_email : email,
			    buyer_name : userName,
			    buyer_tel : userPhoneNum,
			    buyer_addr : addr1 + addr2,
			    buyer_postcode : '123-456'
			}, function(rsp) {
				console.log(rsp);
			    if ( rsp.success ) {
			    	var msg = '결제가 완료되었습니다.';
	            	document.deliveryForm.submit();
			    } else {
			    	 var msg = '결제에 실패하였습니다.';
			         msg += '에러내용 : ' + rsp.error_msg;
			    }
			    
			    alert(msg);
			    
			});
		}
	    function findAddr(){
			new daum.Postcode({
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
			}).open();
	    }   
	</script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area"> 
		<div id="flex_wrap">
		<div class="title2">주문상품</div>
		<div>
		<div>
			<a href="./details.jsp?bookNumber=<%=bookNum %>"><img src="<%="\\LifeBook2\\book_imgs\\" + book.getBookImg()%>" width="150" height="250"></a>
		</div>
			<%=book.getBookName() %><br>
			가격 : <%=book.getBookPrice() %><br>
			출판사 : <%=book.getBookPub() %><br>
			저자 : <%=book.getAuthor() %>
		</div>
		<div class="title2">배송정보</div>
		<div>
			<form action="orderOK.jsp" method="post" name="deliveryForm">
				<input type="hidden" name="userName" id="userName" value="<%=userName%>">
				<input type="hidden" name="userID" id="userID" value="<%=userID%>">
				<input type="hidden" name="bookName" id="bookName" value="<%=book.getBookName()%>">
				<input type="hidden" name="bookNum" value="<%=bookNum%>">
				<input type="hidden" name="amount" value="<%=amount%>">
				<input type="hidden" name="amount" id="amount" value="<%=amount * book.getBookPrice()%>">
							받는사람<br>
							<input type="text" name="orderRecipient" value="<%=userName%>"><br>
							연락처<br>
							<input type="text" name="orderPhoneNum" id="userPhoneNum" value="<%=userPhoneNum%>"><br>
							주 소*<br>
							<input type="text" name="postAddr1" placeholder="우편번호" id="postAddr1">
								 <input type="button" onclick="findAddr()" value="우편번호 찾기"><br>
							<input type="text" size="30" name="postAddr2" placeholder="도로명 주소" id="postAddr2"><br>
							<input type="hidden" placeholder="지번주소" id="user_jibunAddr"><br>
							<input type="text" size="30" name="postAddr3" placeholder="상세 주소" id="postAddr3"><br>
							이메일<br>
							<input type="text" size="30" name="email" id="email" value="<%=userAddr%>">
			</form>
		</div>
		</div>
			<div id="button_area">
				<button id="btn" type="button" onclick="checkForm()">결제하기</button>
			</div>
		</div>
	<footer>
		<jsp:include page="../intro/footer.jsp"></jsp:include>
	</footer>
</body>
</html>