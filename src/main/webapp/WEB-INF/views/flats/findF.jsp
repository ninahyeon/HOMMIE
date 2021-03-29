<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hommie-방찾기</title>
<LINK REL="SHORTCUT ICON"
	HREF="${pageContext.request.contextPath}/resources/img/favicon.ico" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myCSS.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/findF.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/findF.js"></script>

<script>
	function chatListOpen() {
		window.open("chatList", "chatting",
				"width=400, height=600, left=700, top=100");
	}
</script>
</head>

<body>
	<div class="container firstDiv">
		<!-- 로고 및 네비 -->
		<header>
			<nav
				class="navbar navbar-expand-lg navbar-light Fbtn bg-light Fbtn nav justify-content-end">
				<div class="container-fluid">
					<a href="home"><img class="me-auto logo"
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
								aria-current="page" href="#">방찾기</a></li>
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

		<!-- 중간네비 -->
		<nav class="navbar navbar-expand-sm navbar-light bg-light">
			<div class="container-fluid">
				<div class="midNLeft">
					<input id="schInput" class="schInput" type="text" placeholder="불당동"
						autocomplete="off"
						<c:if test="${schWord!=null }">value="${schWord }"</c:if>>
					<i id="schSubmit" class="fa fa-search schBtn"
						onclick="schLocation()" aria-hidden="true"></i>
					<script>
						//검색창에 엔터치면 검색되기
						$("#schInput").keypress(function(event) {
							if (event.which == 13) {
								$("#schSubmit").click();
								return false;
							}
						});
					</script>
				</div>
				<button class="navbar-toggler ntgg" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNavDarkDropdown"
					aria-controls="navbarNavDarkDropdown" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon2">필터</span>
				</button>


				<button class="btn d-block d-lg-none" onclick="refreshOpt()">
					<i class="fa fa-refresh" aria-hidden="true"></i>
				</button>

				<div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
					<ul class="navbar-nav">
						<!-- 방종류 -->
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarDarkDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> 방 종류 </a>
							<div class="dropdown-menu">
								<form id="roomChk" class="px-4 py-3">
									<div class="mb-3">
										<label for="one" class="form-label"
											onchange="moreThanOne('one', 'room')"> <input
											type="checkbox" name="room" id="one" value="원룸" checked>
											원룸
										</label>
									</div>
									<div class="mb-3">
										<label for="two" class="form-label"
											onchange="moreThanOne('two', 'room')"> <input
											type="checkbox" name="room" id="two" value="투룸" checked>
											투룸
										</label>
									</div>
									<div class="mb-3">
										<label for="three" class="form-label"
											onchange="moreThanOne('three', 'room')"> <input
											type="checkbox" name="room" id="three" value="쓰리룸" checked>
											쓰리룸
										</label>
									</div>
								</form>
							</div></li>
						<!-- 매물종류 -->
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarDarkDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> 매물 종류 </a>
							<div class="dropdown-menu">
								<form id="rType" class="px-4 py-3">
									<div class="mb-3">
										<label for="monthly" class="form-label"
											onchange="moreThanOne('monthly', 'rentType')"> <input
											type="checkbox" name="rentType" id="monthly" value="월세"
											checked> 월세
										</label>
									</div>
									<div class="mb-3">
										<label for="reserve" class="form-label"
											onchange="moreThanOne('reserve', 'rentType')"> <input
											type="checkbox" name="rentType" id="reserve" value="전세"
											checked> 전세
										</label>
									</div>
								</form>
							</div></li>
						<!-- 가격대 -->
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarDarkDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> 가격대 </a>
							<div class="dropdown-menu">
								<form onsubmit="addExtraOpt(); return false;" action="#"
									id="priceRange" class="px-4 py-3">
									<div class="mb-3">
										<h5>보증금/전세금</h5>
										<input type="text" autocomplete="off" class="price p-min"
											id="depositMin" placeholder="0"><span class="won">만원</span>
										~ <input placeholder="99999" type="text" autocomplete="off"
											class="price p-max" id="depositMax"><span class="won">만원</span>
									</div>
									<hr class="pLine">
									<div class="mb-3">
										<h5>월세/관리비</h5>
										<input placeholder="0" type="text" autocomplete="off"
											class="price p-min" id="rentMin"><span class="won">만원</span>
										~ <input type="text" placeholder="99999" autocomplete="off"
											class="price p-max" id="rentMax"><span class="won">만원</span>
									</div>
									<hr class="pLine">
									<button id="realBtn" class="btn btn-primary prbtn">적용</button>
								</form>
							</div></li>
						<!-- 추가옵션 -->
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							id="navbarDarkDropdownMenuLink" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> 추가옵션 </a>
							<div class="dropdown-menu">
								<form id="extraOpt" class="px-4 py-3">
									<div class="mb-3">
										<label for="internet" class="form-label"
											onchange="addExtraOpt()"> <input type="checkbox"
											name="extra" id="internet"> 인터넷
										</label>
									</div>
									<div class="mb-3">
										<label for="furniture" class="form-label"
											onchange="addExtraOpt()"> <input type="checkbox"
											name="extra" id="furniture"> 가구
										</label>
									</div>
									<div class="mb-3">
										<label for="pet" class="form-label" onchange="addExtraOpt()">
											<input type="checkbox" name="extra" id="pet"> 반려동물
										</label>
									</div>
									<div class="mb-3">
										<label for="park" class="form-label" onchange="addExtraOpt()">
											<input type="checkbox" name="extra" id="park"> 주차공간
										</label>
									</div>
								</form>
							</div></li>
						<!-- 필터초기화 -->
						<li class="nav-item d-none d-lg-block">
							<button class="btn" onclick="refreshOpt()">
								<i class="fa fa-refresh" aria-hidden="true"></i>
							</button>
						</li>

					</ul>
				</div>
			</div>
		</nav>
		<!-- 지도와 목록 -->
		<div class="contentDiv">

			<!-- 지도기준 매물목록 -->
			<div class="fListLeft">

				<!-- Gallery of grid-cards -->
				<section id="filter-wrap" class="filter-wrap"></section>
			</div>
			<input id="logID" type="hidden" value="${logID }">

			<!-- 지도 -->
			<div id="map" class="map"></div>
			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08492f1f66baf843bb674685c1c67160&libraries=clusterer,services"></script>
			<script>
				function getContextPath() {
					var hostIndex = location.href.indexOf(location.host)
							+ location.host.length;
					var contextPath = location.href.substring(hostIndex,
							location.href.indexOf('/', hostIndex + 1));
					return contextPath;
				}
				// 지역 검색함!!
				function schLocation() {
					var schInput = $("#schInput").val();
					if (schInput != "") {
						// 장소 검색 객체를 생성합니다
						var ps = new kakao.maps.services.Places();

						// 키워드로 장소를 검색합니다
						ps.keywordSearch(schInput, placesSearchCB);

						// 키워드 검색 완료 시 호출되는 콜백함수 입니다
						function placesSearchCB(data, status) {
							if (status === kakao.maps.services.Status.OK) {//검색결과 있음
								// 검색된 장소 위치를 기준으로 지도 범위를 재설정해줌
								var bounds = new kakao.maps.LatLngBounds();
								for (var i = 0; i < data.length; i++) {
									bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
								}
								map.setBounds(bounds);
							}
						}
					}
				}
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(37.4729045674501,
							126.950918062755), // 지도의 중심좌표
					level : 7, // 지도의 확대 레벨
					mapTypeId : kakao.maps.MapTypeId.ROADMAP
				// 지도종류
				};

				// 지도를 생성한다 
				var map = new kakao.maps.Map(mapContainer, mapOption);

				// 지도에 확대 축소 컨트롤을 생성한다
				var zoomControl = new kakao.maps.ZoomControl();

				// 지도의 우측에 확대 축소 컨트롤을 추가한다
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

				//딱 이 페이지 들어왔을 때 이벤트
				$(document).ready(function() {
					schLocation();
					addExtraOpt();
				});

				/// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
				if (navigator.geolocation) {

					// GeoLocation을 이용해서 접속 위치를 얻어옵니다
					navigator.geolocation.getCurrentPosition(function(position) {

								var lat = position.coords.latitude, // 위도
								lon = position.coords.longitude; // 경도

								var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

								// 지도 중심좌표를 접속위치로 변경합니다
								map.setCenter(locPosition);
							});

				} else {
					// HTML5의 GeoLocation을 사용할 수 없을때 기본 좌표 설정.
					var locPosition = new kakao.maps.LatLng(37.4729045674501, 126.950918062755);

					// 지도 중심좌표를 접속위치로 변경합니다
					map.setCenter(locPosition);
				}

				//지도에 드래그엔드 이벤트 등록
				kakao.maps.event.addListener(map, 'bounds_changed', function() {
					addExtraOpt();
				});
				
				//조건 검색 함수!
				var logID = $("#logID").val();
				var one = "";
				var two = "";
				var three = "";
				var monthly = "";
				var reserve = "";
				var deMin = 0;
				var deMax = 99999;
				var reMin = 0;
				var reMax = 99999;
				var internet = "N";
				var furniture = "N";
				var pet = "N";
				var park = "N";
				function addExtraOpt() {
					if (document.getElementById("one").checked == true) {
						one = "원룸";
					} else {
						one = "";
					}
					if (document.getElementById("two").checked == true) {
						two = "투룸";
					} else {
						two = "";
					}
					if (document.getElementById("three").checked == true) {
						three = "쓰리룸";
					} else {
						three = "";
					}

					if (document.getElementById("monthly").checked == true) {
						monthly = "월세";
					} else {
						monthly = "";
					}
					if (document.getElementById("reserve").checked == true) {
						reserve = "전세";
					} else {
						reserve = "";
					}

					if (isNaN($("#depositMin").val())
							|| isNaN($("#depositMax").val())
							|| isNaN($("#rentMin").val())
							|| isNaN($("#rentMax").val())) {
						alert("숫자만 입력 가능!");
						return false;
					} else {
						if (!$("#depositMin").val()) {
							deMin = 0;
						} else {
							deMin = $("#depositMin").val();
						}
						if (!$("#depositMax").val()) {
							deMax = 99999;
						} else {
							deMax = $("#depositMax").val();
						}
						if (!$("#rentMin").val()) {
							reMin = 0;
						} else {
							reMin = $("#rentMin").val();
						}
						if (!$("#rentMax").val()) {
							reMax = 99999;
						} else {
							reMax = $("#rentMax").val();
						}
					}

					if (document.getElementById("internet").checked == true) {
						internet = "Y";
					} else {
						internet = "N";
					}
					if (document.getElementById("furniture").checked == true) {
						furniture = "Y";
					} else {
						furniture = "N";
					}
					if (document.getElementById("pet").checked == true) {
						pet = "Y";
					} else {
						pet = "N";
					}
					if (document.getElementById("park").checked == true) {
						park = "Y";
					} else {
						park = "N";
					}

					var bound = map.getBounds();
					//ajax로 보낼 오브젝트 생성
					var jObj = {
						"swLat" : bound.getSouthWest().getLat(),
						"swLng" : bound.getSouthWest().getLng(),
						"neLat" : bound.getNorthEast().getLat(),
						"neLng" : bound.getNorthEast().getLng(),
						"one" : one,
						"two" : two,
						"three" : three,
						"monthly" : monthly,
						"reserve" : reserve,
						"deMin" : deMin,
						"deMax" : deMax,
						"reMin" : reMin,
						"reMax" : reMax,
						"internet" : internet,
						"furniture" : furniture,
						"pet" : pet,
						"park" : park
					};
					$.ajax({
						url : "addExtra",
						dataType : "json",
						contentType : "application/json; charset=UTF-8",
						type : "POST",
						data : JSON.stringify(jObj),
						success : function(data) {
							if (data.length > 0) {
								var html = "";
								for ( var i = 0 in data) {
									html += "<div class='filter-item venomous common durban'>";
									html += "<div class='img-container'>";
									html += "<a href='#' onclick='javascript:moveItemViewPage(\""
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
											+ "\"); return false;' target=\"_blank\">";
									html += "<img class='hover-center' src='${pageContext.request.contextPath}/download?filename="
											+ data[i].fileName + "'>";
									html += "</a></div>"
									html += "<div class='grid-card-text'>"
									html += "<h1 class='scientific-name'>"
											+ data[i].rentType
											+ " "
											+ data[i].room
											+ " "
											+ data[i].deposit
											+ " "
											+ data[i].rent + "</h1>";
									html += "<p class='common-name testEll'>"
											+ data[i].title + "</p>";
									html += "</div><div class='filter-mask'></div></div>";
								}
								$("#filter-wrap").html(html);
							} else {
								$("#filter-wrap").html("<p class='noResult'>결과가 없습니다!</p>");
								}
							}, error : function(request, status, error) {
								console.log("AJAX_ERROR");
								}
							});

				}

				// 마커 클러스터러를 생성합니다
				var clusterer = new kakao.maps.MarkerClusterer({
					map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
					averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
					minLevel : 5, // 클러스터 할 최소 지도 레벨
					disableClickZoom : false;	//클러스터러 클릭 시 확대
				});

				$.ajax({
					async : true,
					url : "clusterer",
					type : 'POST',
					data : "",
					dataType : "json",
					contentType : "application/json; charset=UTF-8",
					success : function(data) {
						//요청에 성공하면 DB에서 꺼낸 데이터를 json 형식으로 응답 받는다.
						//마커들을 저장할 변수
						var markers = $(data).map(function(i, position) {
							//마커를 하나 새로 만드는데, 위치값을 지정하고 클릭이 가능하게 설정함.
							var marker = new daum.maps.Marker({
								position : new daum.maps.LatLng(position.LAT, position.LNG), title : position.FLATID, clickable : true});
							// 마커에 클릭이벤트를 등록합니다
							daum.maps.event.addListener(marker, 'click', function() {
								var fNum = marker.getTitle();
								$.ajax({
									url : "markerInfo",
									data : fNum,
									dataType : "json",
									contentType : "application/json; charset=UTF-8",
									type : "POST",
									success : function(data) {
										var ctp = getContextPath();
										var fileName = ctp
											+ "/download?filename="
											+ data.fileName;
										moveItemViewPage(logID, data.rentType, data.deposit, data.rent, data.title, data.flatID, fileName);
										}, error : function(request, status, error) {
											console.log("AJAX_ERROR");
											}
										});
								});

								//생성된 마커를 반환합니다.
								return marker;
								});

								// 마커 클러스터러에 클릭이벤트를 등록합니다
								// 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
								// 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
								daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
									var mArr = cluster.getMarkers();
									var flatIDArr = []; //flatID 넣을 배열 생성
									for ( var i in mArr) {
										flatIDArr.push(mArr[i].getTitle());
										}
									$.ajax({
										url : "clusterInside",
										dataType : "json",
										contentType : "application/json; charset=UTF-8",
										type : "post",
										data : JSON.stringify(flatIDArr),
										success : function(data) {
											var html = "";
											for ( var i = 0 in data) {
												html += "<div class='filter-item venomous common durban'>";
												html += "<div class='img-container'>";
												html += "<a href='#' onclick='javascript:moveItemViewPage(\""
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
												+ "\"); return false;' target=\"_blank\">";
												html += "<img class='hover-center' src='${pageContext.request.contextPath}/download?filename="
												+ data[i].fileName
												+ "'>";
												html += "</a></div>"
												html += "<div class='grid-card-text'>"
												html += "<h1 class='scientific-name'>"
												+ data[i].rentType
												+ " "
												+ data[i].room
												+ " "
												+ data[i].deposit
												+ " "
												+ data[i].rent
												+ "</h1>";
												html += "<p class='common-name testEll'>"
												+ data[i].title
												+ "</p>";
												html += "</div><div class='filter-mask'></div></div>";
												}
											$("#filter-wrap").html(html);
											}, error : function(request, status, error) {
												console.log("AJAX_ERROR");
												}
											});
									});

								//클러스터에 마커들을 저장합니다.
								clusterer.addMarkers(markers);

							},
							error : function(xhr, status, error) {
								//요청에 실패하면 에러코드 출력  
								alert("에러코드 : " + xhr.status);
							}

						});
			</script>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
</body>

</html>