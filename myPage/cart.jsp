<%@page import="userInfo.UserInfoBean"%>
<%@page import="userInfo.UserInfoDBBean"%>
<%@page import="bookInfo.BookInfoBean"%>
<%@page import="bookInfo.BookInfoDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="order.OrderDBBean"%>
<%@page import="order.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cart.CartDBBean"%>
<%@page import="cart.CartBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--@include file="" --%>
<%	
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
	BookInfoDBBean bookDB = BookInfoDBBean.getInstance();
	CartDBBean db = CartDBBean.getinstance();
	ArrayList<CartBean> cartList = db.getCartList(userID);
	
	DecimalFormat dFormat = new DecimalFormat("###,###");
	
%>
<!DOCTYPE html>
<html>
<head>



<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="../css/cart.css">
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
<script type="text/javascript">
	function checkForm() {
		if(document.cart_form.orderRecipient.value == 0){
			alert("빈창은 허용되지않습니다");
			return;
		}
		if(document.cart_form.orderPhoneNum.value == 0){
			alert("빈창은 허용되지않습니다");
			return;
		}
		if(document.cart_form.orderAddr.value == 0){
			alert("빈창은 허용되지않습니다");
			return;
		}
		if($(".checkbox").is(":checked") == false){
			alert("구매하실 품목을 선택해주세요.");
			return;
		}
		
		document.cart_form.submit();
	}
 	/* function updateQuantity() {
 		var size = $("input[name='cartNum']").length;
 		for (var i = 0; i < size; i++) {
			var quantity = $("#quantity"+i).val();
			var cartNum = $("#cartNum"+i).val();
			location.href="updateQuantity.jsp?cartNum="+cartNum+"&quantity="+quantity;
			return;
			
		}
	} */
  	function moidfyQuantity() {
		var quantity = $("#quantity").val();
		var cartNum = $("#cartNum").val();
		location.href="updateQuantity.jsp?cartNum="+cartNum+"&quantity="+quantity;
		return;
	} 
	function selectAll(selectAll)  {
		  const checkboxes 
		       = document.getElementsByName('cartNum');
		  
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked;
		  });
		}
</script>
</head>
<body>
	<header>
		<jsp:include page="../intro/header.jsp"></jsp:include>
	</header>
	<div id="content_area">
		<form action="../mall/cartOrder.jsp" method="get" name="cart_form">
			<input type="hidden" name="userID" value="<%=userID%>">
			<div id="title">
				<h1>Shopping Cart</h1>
				<p>장바구니목록</p>
			</div>
			<div class="basketinfo">
				<div class="menu">
				</div>
			</div>
		<%-- 있으면 목록 출력 없으면 비어있음 표시--%>
		<%	
			
			System.out.println(cartList.size());
			if(cartList.size() == 0){
		%>
			<div class="empty">
			<div class="table_empty">
			<table class="table_title">
				<tbody>
		            <tr>
		                <th width="100" height="29" align="center"></th>
		                <th width="230" height="29">상품정보</th>
		                <th width="150" height="29">가격</th>
		                <th width="120" height="29">수량</th>
		                <th width="100" height="29">주문금액</th>
		                <th width="70">비고</th>
		            </tr>
		            <tr></tr>
            	</tbody>
			</table>
			<table class="empty_content">
				<tr>
					<td colspan="7" align="center" width="1008px" height="100px">
						<div class="span1">
						<p>장바구니가 비어있습니다.</p>
						<br>
						<p><a href="../mall/sort.jsp" class="deco">책 검색하기</a></p>
						</div>
					</td>
				</tr>
			</table>
		
			</div>
			</div>
		<%	} else {%>
			<div class="container">
			<div style="padding-top:50px;" id="cart_table">
				<table class="table_title">
				<tbody>
		            <tr>
		                <th width="100" height="29" align="center"></th>
		                <th width="230" height="29">상품정보</th>
		                <th width="150" height="29">가격</th>
		                <th width="120" height="29">수량</th>
		                <th width="100" height="29">주문금액</th>
		                <th width="100"><input type="checkbox" name="cartNum" value="selectAll" onclick="selectAll(this)">모두선택</th>
		                <th width="70">비고</th>
		            </tr>
		            <tr></tr>
            	</tbody>
       			</table>
       			<table class="table_content">
		<%	
			//out.print("cartList크기: "+ cartList.size());
			int sum = 0; 
			for(int i=0; i<cartList.size(); i++){
				CartBean cart = cartList.get(i);
				BookInfoBean book = bookDB.getBookInfo(cart.getBookNum());
				// 소계 = 가격 * 수량
				int total = cart.getTotalPrice();
				sum = sum + total;
		%>
					 <tr>
                		<td width="60">
                			<img src="../../../LifeBook2/book_imgs/<%=book.getBookImg()%>" width="60px" height="85px">
                		</td>
		                <td width="310">
		                	&nbsp;&nbsp;&nbsp;[<%=cart.getBookNum()%>]
		                	<br>
		                	<a href="details.jsp?bookNum=<%=cart.getBookNum()%>">
		                	&nbsp;&nbsp;&nbsp;<%= book.getBookName() %>
		                	</a>
		                </td>
		                <td width="130"><%=dFormat.format(book.getBookPrice())%></td>
		                <td width="100" align="left">	
		                	<input type="number" value="<%=cart.getQuantity()%>" width="3" name="quantity" min="1" max="50" id="quantity"><br>
		                	<input type="button" onclick="return updateQuantity(this.form);" value="변경">
		                </td>
		                <td width="100">&nbsp;<%=dFormat.format(total)%></td>
		                <td width="25" align="center">
		                
		                	<input type="checkbox" name="cartNum" value="<%=cart.getCartNum()%>" class="checkbox">
		                </td>
		                <td width="100" align="center">
		                	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                	<input type="button" onclick="location='../myPage/removeCart.jsp?cartNum=<%= cart.getCartNum()%>'"  value="삭제">
		                </td>
            		</tr>
            		<tr><td colspan="7"><hr></td></tr>
		<%
			}
		%>			
					</table>
					<div align="right" class="empty_area">
						<button onclick="location='../myPage/deleteCart.jsp?userID=<%= userID %>'" class="btn2">
							장바구니 비우기
						</button>
					</div>
					<br><br>
					
					<p class="order_info_title">주문 정보</p>
					<br>
					<table id="order_info">
					<tr>
						<th align="left">
							수령자
						</th>
						<td>
							<input type="text" name="orderRecipient" value="<%=userName%>">
						</td>
					</tr>
					<tr>
						<th align="left">
							연락처
						</th>
						<td>
							<input type="text" name="orderPhoneNum" value="<%=userPhoneNum%>">
						</td>
					</tr>
					<tr>
						<th align="left">
							배송지
						</th>
						<td>
							<input type="text" name="orderAddr" value="<%=userAddr%>">
						</td>
					</tr>
				</table>
				
				<br><br>
				
					<table id="total_table">
					<tr align="center">
						<td class="total_main">
							총 주문 금액<br>
							<p class="span1"><%=dFormat.format(sum) %></p>
						</td>
						<td class="total_blank"><p class="span1">+</p></td>
						<td class="total_main">
							배송비<br>
							<p class="span1">0</p>							
						</td>
						<td class="total_blank"><p class="span1">=</p></td>
						<td class="total_main">
							최종 주문 금액<br>
							<p class="span2"><%=dFormat.format(sum) %></p>
						</td>
					</tr>
					</table>
					
					<br><br>
					
				<div class="btn_area1" align="center">
					<button type="button" onclick="checkForm()" class="btn1">구매</button>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" onclick="location='../intro/intro.jsp'" class="btn1">쇼핑 계속하기</button>
				</div>
				
			</div>
		</div>
			<%}%>
		</form>	
	</div>
	
	<footer>
		<jsp:include page="../intro/footer.jsp" />
	</footer>
</body>
</html>