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
<title>Hommie-매물 수정</title>
<LINK REL="SHORTCUT ICON"
	HREF="${pageContext.request.contextPath}/resources/img/favicon.ico" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myCSS.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/uploadF.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>

<!-- DatePicker -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/uploadFlat.js"></script>

<script type="text/javascript">
	window.onload=function(){
	/* 해당 매물 사진 전체 가져오기 */
	var fNum = $("#fIDHidden").val();
		$.ajax({
			url : "myfphotos",
			data : fNum,
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			type : "POST",
			success : function(data) {
				if(data.length>0){
					var html="";
					var cnt=0;
					for(var i in data){
						html+="<div id=\"oldImg_" 
						+ data[i].fileID +
						"\" class=\"cropping\"><a value=\"17\"class=\"dark-img\""
						+" href=\"javascript:void(0);\" onclick=\"deleteOldImg('"
						+ data[i].fileID
						+"')\"><i class=\"fa fa-window-close imgDel\" aria-hidden=\"true\"></i><img id=\"crop_img\""
						+"src=\"${pageContext.request.contextPath}/download?filename="
						+ data[i].fileName + "\" class='selProductFile' title='클릭해서 삭제하기'></a></div>";
						cnt++;
					}
					$("#howManyP").val(cnt);
					$("#imgimg").html(html);
				}
			},
			error : function(request, status, error) {
				console.log("AJAX_ERROR");
			}
		});
	}

	/* 사진 한 장 삭제 */
	function deleteOldImg(pNum){
		$.ajax({
			url : "delPhoto",
			data : pNum,
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			type : "POST",
			success : function() {
				var old_id = "#oldImg_"+pNum;
				$(old_id).remove();
				var total = $("#howmanyP").val();
				total--;
				$("#howManyP").val(total);
			},
			error : function(request, status, error) {
				console.log("AJAX_ERROR");
			}
		});
	}
	function chatListOpen() {
		window.open("chatList", "chatting",
				"width=400, height=600, left=700, top=100");
	}
</script>
</head>

<body>
	<div class="container">
		<input id="fIDHidden" type="hidden" value=${fdto.flatID }> <input
			id="howManyP" type="hidden" value=0>
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
		<!-- 방내놓기 -->
		<section class="FWrap">
			<form name="uploadFlat" action="modifyF_submit" method="POST"
				onsubmit="return submitChk();" enctype="multipart/form-data"
				accept-charset="UTF-8">
				<input type="hidden" name="memberID" value="${logID }"> <input
					type="hidden" name="flatID" value="${fdto.flatID }">
				<div class="uploadF">
					<h2>내 방 수정하기</h2>
					<div class="flatDo">
						<ul class="titUL">
							<li><a class="#"> 내 방 수정하기 </a></li>
							<li onclick="location.href = 'myFlats'"><a class="myflat">
									내 방 관리 </a></li>
						</ul>
					</div>
					<div class="rullF">
						<ul>
							<li>
								<p>ㆍ전/월세 매물만 등록할 수 있습니다.</p>
							</li>
							<li>
								<p>ㆍ등록한 매물은 30일 간 노출됩니다.</p>
							</li>
						</ul>
					</div>
					<div class="infoF whatFlat">
						<h5>매물 종류</h5>
						<table>
							<tr>
								<th class="bLine">종류 선택</th>
								<td class="bLine">
									<div class="switch-field">
										<input type="radio" id="flatType1" name="room" value="원룸"
											<c:if test="${fdto.room=='원룸' }">checked</c:if>> <label
											for="flatType1">원룸</label> <input type="radio" id="flatType2"
											name="room" value="투룸"
											<c:if test="${fdto.room=='투룸' }">checked</c:if>> <label
											for="flatType2">투룸</label> <input type="radio" id="flatType3"
											name="room" value="쓰리룸"
											<c:if test="${fdto.room=='쓰리룸' }">checked</c:if>> <label
											for="flatType3">쓰리룸</label>
									</div>
								</td>
							</tr>
							<tr>
								<th>거래 종류</th>
								<td>
									<div class="switch-field">
										<input type="radio" id="deal1" name="rentType" value="월세"
											<c:if test="${fdto.rentType=='월세' }">checked</c:if>>
										<label id="deal1La" for="deal1" onclick="onChk('M', 'onChk')">월세</label>
										<input type="radio" id="deal2" name="rentType" value="전세"
											<c:if test="${fdto.rentType=='전세' }">checked</c:if>>
										<label id="deal2La" for="deal2" onclick="onChk('R', 'onChk')">전세</label>
									</div>
									<div id="onChk" style="display: none;">
										<p>
											<i class="fa fa-exclamation-circle" aria-hidden="true"></i>숫자만
											입력해주세요.
										</p>
										<div id="moneyy">
											<input class="input_box" type="text" placeholder="보증금"
												id="depo" name="deposit" value="${fdto.deposit }"> <span>만원
												/</span> <input class="input_box" type="text"
												placeholder="월세(관리비 포함)" id="mon" name="rent"
												value="${fdto.rent }"> <span>만원</span>
										</div>
									</div> <script>
										if($("input:checked[id='deal1']").is(":checked")){
											$("#deal1La").trigger("click");
										}else if($("input:checked[id='deal2']").is(":checked")){
											$("#deal2La").trigger("click");
										}
									</script>
								</td>
							</tr>
						</table>
					</div>
					<div class="infoF whereF">
						<h5>위치 정보</h5>
						<table>
							<tr>
								<th class="bLine">주소</th>
								<td class="bLine">
									<div class="inputAddress">
										<p>
											<i class="fa fa-exclamation-circle" aria-hidden="true"></i>
											도로명, 건물명, 지번으로 통합검색이 가능합니다.
										</p>
										<input type="text" id="adrsSch" name="adrsSch" class="adrsSch"
											placeholder="예)봉정로 231 / 서북구 성정동" onclick="daumPostcode()"
											readonly> <input class="adrsBtn btn btn-secondary"
											type="button" onclick="daumPostcode()" value="주소검색">
										<div id="showAdrs" class="showAdrs">
											<p class="adrsDT">
												도로명 : ${fdto.roadAdrs } <br>지번 : ${fdto.jibunAdrs }
											</p>
										</div>
										<input name="deArds" id="detailedAdr" class="detailedAdr"
											type="text" placeholder="상세주소" value="${fdto.deArds }">
										<input type="hidden" id="lat" name="lat" value="${fdto.lat }">
										<input type="hidden" id="lng" name="lng" value="${fdto.lng }">
										<input type="hidden" id="roadAdrs" name="roadAdrs"
											value="${fdto.roadAdrs }"> <input type="hidden"
											id="jibunAdrs" name="jibunAdrs" value="${fdto.jibunAdrs }">
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="kakaoMap">
										<div id="map" style="height: 300px"></div>
									</div>
								</td>
							</tr>
						</table>
						<script
							src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
						<script
							src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08492f1f66baf843bb674685c1c67160&libraries=services"></script>
						<script>
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div
							mapOption = {
								center : new daum.maps.LatLng(${fdto.lat},
										${fdto.lng}), // 지도의 중심좌표
								level : 5
							// 지도의 확대 레벨
							};

							//지도를 미리 생성
							var map = new daum.maps.Map(mapContainer, mapOption);
							//주소-좌표 변환 객체를 생성
							var geocoder = new daum.maps.services.Geocoder();
							//마커를 미리 생성
							var marker = new daum.maps.Marker({
								position : new daum.maps.LatLng(${fdto.lat},
										${fdto.lng}),
								map : map
							});

							function daumPostcode() {
								new daum.Postcode(
										{
											oncomplete : function(data) {
												var addr = data.address; // 최종 주소 변수

												// 주소 정보를 해당 필드에 넣는다.
												document
														.getElementById("adrsSch").value = data.query;
												var html = "<p class=\"adrsDT\">도로명 : "
														+ data.roadAddress
														+ "<br>지번 : "
														+ data.jibunAddress
														+ "</p>";
												$("#showAdrs").html(html);
												// 주소로 상세 정보를 검색
												geocoder
														.addressSearch(
																data.address,
																function(
																		results,
																		status) {
																	// 정상적으로 검색이 완료됐으면
																	if (status === daum.maps.services.Status.OK) {

																		var result = results[0]; //첫번째 결과의 값을 활용

																		// 해당 주소에 대한 좌표를 받아서
																		var coords = new daum.maps.LatLng(
																				result.y,
																				result.x);
																		// 지도를 보여준다.
																		$(
																				'#lat')
																				.val(
																						result.y);
																		$(
																				'#lng')
																				.val(
																						result.x);
																		$(
																				'#roadAdrs')
																				.val(
																						data.roadAddress);
																		$(
																				'#jibunAdrs')
																				.val(
																						data.jibunAddress);
																		document
																				.getElementById("noticeL").style.display = "none";
																		mapContainer.style.display = "block";
																		map
																				.relayout();
																		// 지도 중심을 변경한다.
																		map
																				.setCenter(coords);
																		// 마커를 결과값으로 받은 위치로 옮긴다.
																		marker
																				.setPosition(coords)
																	}
																});
											}
										}).open();
							}
						</script>
					</div>
					<div class="infoF basicInfo">
						<h5>기본 정보</h5>
						<table>
							<tr>
								<th class="bLine">평수</th>
								<td class="bLine">
									<p>
										<i class="fa fa-exclamation-circle" aria-hidden="true"></i>
										숫자만 입력해주세요.
									</p> <input class="input_box" type="text" placeholder="평수"
									id="pyeong" name="pyeong" value="${fdto.pyeong }"> 평
								</td>
							</tr>
							<tr>
								<th class="bLine">층수</th>
								<td class="bLine">
									<p>
										<i class="fa fa-exclamation-circle" aria-hidden="true"></i>
										숫자만 입력해주세요.
									</p> <input class="input_box" type="text" placeholder="층수"
									id="floor" name="floor" value="${fdto.floor }"> 층
								</td>
							</tr>
							<tr>
								<th>입주가능일</th>
								<td>
									<div class="switch-field">
										<input type="radio" id="moveDate1" name="mDate"> <label
											for="moveDate1" onclick="todayD()">즉시 입주</label> <input
											type="radio" id="moveDate2" name="mDate"> <label
											for="moveDate2" onclick="">날짜 선택</label>
										<!-- 달력에서 날짜 선택하면 아래 거 뜨게 -->
										<span class="selMoveD" id="selMoveD">${fdto.moveDate }</span>
										<input type="hidden" name="moveDate" id="moveDate">
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="infoF addInfo">
						<h5>추가 정보</h5>
						<table>
							<tr>
								<th class="bLine">주차여부</th>
								<td class="bLine">
									<div class="switch-field">
										<input type="radio" id="park1" name="park" value="Y"
											<c:if test="${fdto.park=='Y' }">checked</c:if>> <label
											for="park1">가능</label> <input type="radio" id="park2"
											name="park" value="N"
											<c:if test="${fdto.park=='N' }">checked</c:if>> <label
											for="park2">불가능</label>
									</div>
								</td>
								<th class="bLine">반려동물</th>
								<td class="bLine">
									<div class="switch-field">
										<input type="radio" id="pet1" name="pet" value="Y"
											<c:if test="${fdto.pet=='Y' }">checked</c:if>> <label
											for="pet1">가능</label> <input type="radio" id="pet2"
											name="pet" value="N"
											<c:if test="${fdto.pet=='N' }">checked</c:if>> <label
											for="pet2">불가능</label>
									</div>
								</td>
							</tr>
							<tr>
								<th>인터넷</th>
								<td>
									<div class="switch-field">
										<input type="radio" id="internet1" name="internet" value="Y"
											<c:if test="${fdto.internet=='Y' }">checked</c:if>> <label
											for="internet1">설치</label> <input type="radio" id="internet2"
											name="internet" value="N"
											<c:if test="${fdto.internet=='N' }">checked</c:if>> <label
											for="internet2">미설치</label>
									</div>
								</td>
								<th>가구</th>
								<td>
									<div class="switch-field">
										<input type="radio" id="furniture1" name="furniture" value="Y"
											<c:if test="${fdto.furniture=='Y' }">checked</c:if>>
										<label for="furniture1">있음</label> <input type="radio"
											id="furniture2" name="furniture" value="N"
											<c:if test="${fdto.furniture=='N' }">checked</c:if>>
										<label for="furniture2">없음</label>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="infoF infoDetail">
						<h5>상세 설명</h5>
						<table>
							<tr>
								<th class="bLine">제목</th>
								<td class="bLine"><input id="detTitle"
									class="inputDsc titleDsc" type="text"
									placeholder="예)신세계 도보 10분거리, 혼자 살기 좋은 방 입니다." name="title"
									value="${fdto.title }"></td>
							</tr>
							<tr>
								<th>상세 설명</th>
								<td><textarea class="inputDsc detailedDsc" name="detail"
										id="detail" rows="10"
										placeholder="상세설명 작성 주의사항&#13;&#10;&#13;&#10;- 방 정보와 관련없는 홍보성 정보는 입력하실 수 없습니다.&#13;&#10;- 중개수수료를 언급한 내용은 입력할 수 없습니다. (중개수수료 무료, 꽁짜, 반값 등)&#13;&#10;&#13;&#10;* 주의사항 위반 시 허위매물로 간주되어 매물 삭제 및 이용의 제한이 있을 수 있습니다."
										name="detail">${fdto.detail }</textarea></td>
							</tr>
						</table>
					</div>
					<div class="infoF uploadPhoto">
						<h5>사진 등록</h5>
						<table>
							<tr>
								<td class="indicatePho">
									<div class="phoRull">
										<p>- 사진은 가로로 찍은 사진을 권장합니다. (가로 사이즈 최소 800px)</p>
										<p>- 사진 용량은 사진 한 장당 10MB까지 등록이 가능합니다.</p>
										<p>- 사진은 최소 3장 이상 등록해야하며, 최대 15장까지 권장합니다. 그 이상 등록할 경우 업로드
											시간이 다소 지연될 수 있습니다.</p>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="photo_box">
										<div class="imgs_wrap">
											<input id="input_imgs" type="file" class="addFile" multiple
												style="display: none;" name="file">
											<div class="fileBtn cropping" onclick="addFile()">사진
												추가하기</div>
											<div id="imgimg">
												<img id="img" />
											</div>
										</div>
									</div>
									<p class="phoRull2">
										<i class="fa fa-exclamation-circle" aria-hidden="true"></i> 허위
										매물을 등록할 경우 계정 및 매물이 전체 삭제 처리 됩니다. <a href="#">허위매물 제재 정책
											확인하기</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<div class="allDone">
						<div>
							<input id="ok" type="checkbox"> <label for="ok">
								매물관리규정을 확인하였으며,입력한정보는 실제 매물과 다름이 없습니다.</label>
						</div>
						<div>
							<input class="btn btn-outline-secondary" type="button" value="취소"
								onclick="location.href = 'myFlats'"> <input
								class="btn btn-primary" type="submit" value="매물수정">
						</div>
					</div>

				</div>
			</form>
		</section>
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

		<!-- 경고 -->
		<div id="myAlert"
			class="myAlert alert alert-danger alert-dismissible fade show"
			role="alert" style="display: none;">
			<strong id="msgAl"></strong>
			<button type="button" class="btn-close" onclick="closeAl()"
				aria-label="Close"></button>
		</div>
	</div>

</body>

</html>