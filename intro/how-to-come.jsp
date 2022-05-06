<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/reset.css">
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<style type="text/css">
	.about {
		display: flex;
		margin: 20px auto;
		background-color: #fff;
		padding: 20px;
		border-radius: 10px;
		width: 1000px;
	}
	
	.about_title {
		width: 300px;
		text-align: center;
		line-height: 300px;
	}
	
	.about_content {
		width: 700px;
		font-size: 16px;
	}
	
	.map {
		width: 300px;
		text-align: center;
		line-height: 300px;
	}
</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../js/jquery.bxslider.js"></script>
<script src="../js/isotope.pkgd.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/main.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="about">
		<div class="map">
			<h1 style="font-size: 30px">위치</h1>
		</div>
	
		<div id="map" style="width:700px;height:500px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8f87e104e2b813e4a12cd8b15e00bd58"></script>
		<script>
			var container = document.getElementById('map');
			var options = {
				center: new kakao.maps.LatLng(35.15959577938923, 129.06020570174974),
				level: 3
			};
	
			var map = new kakao.maps.Map(container, options);
	        
	        // 마커가 표시될 위치입니다 
	        var markerPosition  = new kakao.maps.LatLng(35.15959577938923, 129.06020570174974); 
	
	        // 마커를 생성합니다
	        var marker = new kakao.maps.Marker({
	            position: markerPosition
	        });
	
	        // 마커가 지도 위에 표시되도록 설정합니다
	        marker.setMap(map)
		</script>
	</div>
	<section class="about">
		<div class="about_title">
			<h1 style="font-size: 30px">오시는 길</h1>
		</div>
		
		<div class="about_content">
			<h3 style="font-size: 20px">그린컴퓨터아카데미 부산서면2별관</h3>
			<h4>부산 부산진구 중앙대로 749</h4>
			<br><br>
			<p>
				[지하철 안내]<br><br>
				본관 : 1,2호선 서면역 2번 출구에서 300M <br>
				서면 1별관: 1,2호선 서면역 2번 출구에서 50M<br>
				서면 2별관: 1,2호선 서면역 15번 출구에서 70M<br>
				경성대 별관 : 경성대,부경대역 6번출구에서 50M<br>
			</p>
		</div>
	</section>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>