<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hommie</title>
<LINK REL="SHORTCUT ICON"
	HREF="${pageContext.request.contextPath}/resources/img/favicon.ico" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myCSS.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
<style>
.logsuc a {
	text-decoration: none;
	color: gray;
}

.carousel-caption {
	background-color: #2225;
}
</style>
<script>
	function chatListOpen() {
		window.open("chatList", "chatting",
				"width=400, height=600, left=700, top=100");
	}
</script>
</head>

<body>
	<div class="container">
		<!-- 로고 및 네비 -->
		<header>
			<nav
				class="navbar navbar-expand-lg navbar-light bg-light nav justify-content-end">
				<div class="container-fluid">
					<a href="#"><img class="me-auto logo"
						src="${pageContext.request.contextPath}/resources/img/logo.png"
						alt="logo"></a>
					<button class="navbar-toggler ms-auto" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
							<li class="nav-item"><a class="nav-link big-item"
								aria-current="page" href="findF">방찾기</a></li>
							<li class="nav-item"><a class="nav-link big-item"
								href="myFlats">방내놓기</a></li>
							<li class="nav-item dropdown"><a
								class="nav-link dropdown-toggle big-item" href="#"
								id="navbarDropdown" role="button" data-bs-toggle="dropdown"
								aria-expanded="false"> 관심목록 </a>
								<ul class="dropdown-menu big-item"
									aria-labelledby="navbarDropdown">
									<li><a class="dropdown-item" href="dipsF">찜한 목록</a></li>
									<li><a class="dropdown-item" href="recentViews">최근 본 방</a></li>
								</ul></li>
							<c:choose>
								<c:when test="${logID !=null }">
									<li class="nav-item dropdown"><a class="nav-link big-item"
										href="#" id="navbarDropdown" role="button"
										data-bs-toggle="dropdown" aria-expanded="false"><i
											class="fa fa-user-circle-o" aria-hidden="true"></i> ${logID }</a>
										<ul class="dropdown-menu big-item"
											aria-labelledby="navbarDropdown">
											<li><a class="dropdown-item" onclick="chatListOpen()">내
													채팅</a></li>
											<li><a class="dropdown-item" href="logout">로그아웃</a></li>
										</ul></li>
								</c:when>
								<c:otherwise>
									<li class="nav-item"><a class="nav-link" href="login">로그인
											| 회원가입</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</div>
			</nav>
		</header>
		<!-- 검색 -->
		<form action="findF" method="GET" class="search_room">
			<h1 class="sch_guide">
				<span class="blue-txt">원하는 동네</span>를<br>검색하세요!
			</h1>
			<span class="sch_bar"> <i class="fa fa-search fa-lg"
				aria-hidden="true"> | </i> <input name="schWord" class="sch_box"
				type="search"> <input class="btn btn-primary sch_btn"
				type="submit" value="방찾기">
			</span>
		</form>
		<!-- 내 주변 방 찾기 -->
		<article class="keyword_room">
			<!-- PC 키워드 방찾기 -->
			<hr class="gubun1 ">
			<div class="sm-title1">
				<h3>내 주변 방 찾기</h3>
				<p id="centerAddr"></p>
				<input id="whereMe" type="hidden" value="null">
			</div>
			<div>
				<ul id="whereMeContainer" class="keysch">
				</ul>
			</div>
			<div id="map" style="display: none;"></div>
		</article>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08492f1f66baf843bb674685c1c67160&libraries=services"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
				level : 1
			// 지도의 확대 레벨
			};
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			/// HTML5의 geolocation을 사용할 수 있는지 확인합니다 
			if (navigator.geolocation) {

				// GeoLocation을 이용해서 접속 위치를 얻어옵니다
				navigator.geolocation.getCurrentPosition(function(position) {

					var lat = position.coords.latitude, // 위도
					lon = position.coords.longitude; // 경도

					var locPosition = new kakao.maps.LatLng(lat, lon); // 좌표를 geolocation으로 얻어온 좌표로 생성합니다
					// 지도 중심좌표를 접속위치로 변경합니다
					map.setCenter(locPosition);
					searchAddrFromCoords(map.getCenter(), displayCenterInfo);
				});
			} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

				alert("현재 위치를 가져오는데 실패했습니다.");
				var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);
				// 지도 중심좌표를 접속위치로 변경합니다
				map.setCenter(locPosition);
				searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			}

			function searchAddrFromCoords(coords, callback) {
				// 좌표로 주소 정보를 요청합니다
				geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
			}

			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result) {
				var infoDiv = document.getElementById('centerAddr');

				for (var i = 0; i < result.length; i++) {
					// 행정동의 region_type 값은 'H' 이므로
					if (result[i].region_type === 'H') {
						infoDiv.innerHTML = "<i class='fa fa-location-arrow' aria-hidden='true'></i>&nbsp;"
								+ result[i].address_name;
						$("#whereMe").val(result[i].address_name);
						break;
					}
				}
				var whereMe = $("#whereMe").val();
				var logID = $("nowID").val();
				if (whereMe != "null") {
					$.ajax({
						url : "flatsNearMe",
						type : "POST",
						data : whereMe,
						dataType : "json",
						contentType : "application/json; charset=UTF-8",
						success : function(data) {
							$("#whereMeContainer").empty();
							if (data.length > 0) {
								for ( var i in data) {
									$("#whereMeContainer") .append(
										$("<li>").attr(
											"onclick",
											"javascript:moveItemViewPage(\""
											+ logID
											+ "\",\""
											+ data[i].rentType
											+ "\",\""
											+ data[i].deposit
											+ "\",\""
											+ data[i].rent
											+ "\",\""
											+ data[i].title
											+ "\",\""
											+ data[i].flatID
											+ "\",\"${pageContext.request.contextPath}/download?filename="
											+ data[i].fileName
											+ "\"); return false;").append(
												$("<img>").attr({
													"src" : "${pageContext.request.contextPath}/download?filename="
													+ data[i].fileName,
													"class" : "keyword"
												})).append(
													$("<p>").append(
														data[i].rentType
														+ " "
														+ data[i].deposit
														+ "/"
														+ data[i].rent
														+ "<br>"
														+ data[i].title)));
										}
									} else {
										$("#whereMeContainer").append(
											'<p class="nothingF">아직 주변에 올라온 방이 없습니다!</p>');
									}
								},
								error : function(request, status, error) {
									console.log("AJAX_ERROR");
								}
							});
				}
			}
		</script>
		<!-- 최근 본 방 -->
		<article class="recent_view">
			<input id="nowID" type="hidden" value="${logID }">
			<!-- PC 최근 본 방 -->
			<hr class="d-block d-lg-none">
			<hr class="d-none d-lg-block gubun3">
			<div class="sm-title1">
				<h3>내가 본 방</h3>
				<p>최근에 본 방을 다시 볼 수 있어요!</p>
			</div>
			<div>
				<ul id="latelyViewItemList_ul" class="keysch"></ul>
			</div>
			<div class="spacie"></div>
			<a href="#" id="seeAll" class="saa see_all"></a>
		</article>

		<!-- 푸터 -->
		<footer class="foo">
			<div class="left-top">
				<ul>
					<li>회사소개</li>
					<li>이용약관</li>
					<li>개인정보처리방침</li>
					<li>매물관리규정</li>
				</ul>
			</div>
			<hr class="gubun2">
			<div class="left-bottom">
				<p>(주)나현주식회사</p>
				<p>대표 : 김나현</p>
				<p>사업자 번호 : 000-00-00000</p>
				<p>주소 : 나현시 나현구 나현대로 301 나현빌딩 100층 (주)나현주식회사</p>
				<p>고객센터 : 00-0000-0000(평일 10:00 ~ 18:00 주말 및 공휴일 휴무</p>
				<p>팩스 : 00-000-0000 허위매물 신고 : heowe@hommie.com</p>
			</div>
			<div class="right-bottom d-none d-lg-block">
				<ul>
					<li><a href="#"><i class="fa fa-instagram fa-3x"
							aria-hidden="true"></i></a></li>
					<li><a href="#"><i class="fa fa-facebook-official fa-3x"
							aria-hidden="true"></i></a></li>
					<li><a href="#"><i class="fa fa-twitter fa-3x"
							aria-hidden="true"></i></a></li>
				</ul>
			</div>
		</footer>

		<!-- 퀵메뉴 -->
		<span class="quick_menu d-none d-lg-block">
			<ul class="quick_list">
				<li><a href="findF">방찾기</a></li>
				<li><a href="dipsF">관심목록</a></li>
			</ul> <a href="#" class="to_top">TOP ▲</a>
		</span>
		<div class="d-block d-lg-none mobile_top">
			<a href="#">▲<br>TOP
			</a>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
</body>

</html>