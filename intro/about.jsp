<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css"> <!--css���� ��ü�� �������մϴ� �ٽ� �ٸ��ֱ����ؼ�   -->
<link rel="stylesheet" href="../css/common.css"> <!--�������� ����κ�, Ǫ�ͺκ�, ���� width 1008px ���� ���������Դϴ�!  -->
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
		<div class="title"><img alt="�λ�å�� ����,Ÿ��Ʋ" src="../images/library.png"></div>
		<div class="kpi-title">�λ�å���� �ٽɰ�ġ</div>
		<div class="book-kpi">
			<ul>
				<li>
					<img alt="�ٽɰ�ġ1" src="../images/kpi-1.png">
				</li>
				<li>
					<img alt="�ٽɰ�ġ2" src="../images/kpi-2.png">
				</li>
				<li>
					<img alt="�ٽɰ�ġ3" src="../images/kpi-3.png">
				</li>
			</ul>
		</div>
	<div id="container">
		<section class="introduce-self-part">
			<div class="intoduce-main-title">
				<�λ�å�濡���� ���Ե鲲 �� ���� ����� �帳�ϴ�>
			</div>
			<ul>
				<li>
					<img alt="�ٷι��" src="../images/delivery.png">
					<ul>
						&nbsp;
						<li>
							<h4 class="introduce-sub-title1">�ٷι��</h4>
						</li>&nbsp;&nbsp;&nbsp;
						<li>	
							��ì������  '�ٷι��'���񽺴� ���� �� ���ͳ� �������� ���� �߼� ���� ������ ���� ����� ��Ȳ���� ���� ����ȭ �� ��۽ý����� �����̱� ���Ͽ� ���� �Ǿ����ϴ�.
							������ �ֹ��ϸ� ���Ŀ�,
							���Ŀ� �ֹ��ϸ� ���� �� �޾ƺ� �� �ִ� ��Ư�� ��� �����Դϴ�.
						</li>
					</ul>
				</li>
			</ul>
			<ul>
				<li>
					<img alt="�����̾����" src="../images/premium.png">
					<ul>
						&nbsp;
						<li>
							<h4 class="introduce-sub-title2">�����̾����</h4>
						</li>&nbsp;&nbsp;&nbsp;
						<li>
							��鸲�� ��ü�� ������ ���� źź�ϰ� ����ص帮�� ��ۻ�ǰ �������� �����Դϴ�.
						</li>
					</ul>
				</li>
			</ul>
			<ul>
				<li>
					<img alt="������ 24�ð��" src="../images/24hours.png">
					<ul>
						&nbsp;
						<li>
							<h4 class="introduce-sub-title3">������</h4>
						</li>&nbsp;&nbsp;&nbsp;
						<li>	
							���Ե��� ������ �Ͻôµ� �������� ������ 24�ð� �����͸� ��ϴ� �����Դϴ�.
						</li>
					</ul>
				</li>
			</ul>
		</section>	
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>