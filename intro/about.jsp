<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css"> <!--css파일 전체로 리셋을합니다 다시 꾸며주기위해서   -->
<link rel="stylesheet" href="../css/common.css"> <!--공통적인 헤더부분, 푸터부분, 메인 width 1008px 넓이 설정위주입니다!  -->
<link rel="stylesheet" href="../css/about.css">
<script src="../js/jquery.js"></script>
<script src="../js/common.js"></script>

<!-- <style type="text/css">
	.title img{
		width: 100%;
	}
	.kpi-title{
		margin-top :40px;
		margin-bottom: 40px;
		font-size: 30px;
		font-weight: bold;
		text-align: center;
		color:black;
	}
	.book-kpi ul{
		display:flex;
		justify-content : center;
		background-color: white;
	}
	.book-kpi ul li{
		width : 220px;
		height : 220px;
		margin-right : 60px;
		margin-bottom: 30px;
	}
	.introduce-self-part ul {
		margin-bottom: 80px;
	}
	.introduce-self-part ul img{
		width: 231px;
		height :231px;
		border: 1px solid black;
		margin-right: 50px;
		border-radius: 10px;
		background-color: #fff
	}
	.introduce-self-part ul li{
		 display: flex;
		/* float: left; */
		padding-right: 20px;
	}
	.intoduce-main-title{
		margin-top :80px;
		margin-bottom: 160px;
		text-align: center;
		font-size: 30px;
		font-weight : bold;
		color:black;
	}
	.introduce-sub-title1, .introduce-sub-title2, .introduce-sub-title3{
		font-size: 20px;
		font-weight: bold;
		color: black;
	}
	
</style> -->
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
		<div class="title"><img alt="인생책방 모토,타이틀" src="../images/library.png"></div>
		<div class="kpi-title">인생책방의 핵심가치</div>
		<div class="book-kpi">
			<ul>
				<li>
					<img alt="핵심가치1" src="../images/kpi-1.png">
				</li>
				<li>
					<img alt="핵심가치2" src="../images/kpi-2.png">
				</li>
				<li>
					<img alt="핵심가치3" src="../images/kpi-3.png">
				</li>
			</ul>
		</div>
	<div id="container">
		<section class="introduce-self-part">
			<div class="intoduce-main-title">
				<인생책방에서는 고객님들께 세 가지 약속을 드립니다>
			</div>
			<ul>
				<li>
					<img alt="바로배송" src="../images/delivery.png">
					<ul>
						&nbsp;
						<li>
							<h4 class="introduce-sub-title1">바로배송</h4>
						</li>&nbsp;&nbsp;&nbsp;
						<li>	
							인챙색방의  '바로배송'서비스는 현재 각 인터넷 서점들의 당일 발송 제공 지역이 각각 비슷한 상황에서 더욱 차별화 된 배송시스템을 선보이기 위하여 마련 되었습니다.
							오전에 주문하면 오후에,
							오후에 주문하면 다음 날 받아볼 수 있는 초특급 배송 서비스입니다.
						</li>
					</ul>
				</li>
			</ul>
			<ul>
				<li>
					<img alt="프리미엄배송" src="../images/premium.png">
					<ul>
						&nbsp;
						<li>
							<h4 class="introduce-sub-title2">프리미엄배송</h4>
						</li>&nbsp;&nbsp;&nbsp;
						<li>
							흔들림과 일체의 구겨짐 없이 탄탄하게 배송해드리는 배송상품 안전보장 서비스입니다.
						</li>
					</ul>
				</li>
			</ul>
			<ul>
				<li>
					<img alt="고객센터 24시간운영" src="../images/24hours.png">
					<ul>
						&nbsp;
						<li>
							<h4 class="introduce-sub-title3">고객센터</h4>
						</li>&nbsp;&nbsp;&nbsp;
						<li>	
							고객님들의 독서를 하시는데 불편함이 없도록 24시간 고객센터를 운영하는 서비스입니다.
						</li>
					</ul>
				</li>
			</ul>
		</section>	
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>