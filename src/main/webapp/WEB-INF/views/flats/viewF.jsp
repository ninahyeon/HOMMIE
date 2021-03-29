<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">

<head>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${fdto.jibunAdrs }</title>
<LINK REL="SHORTCUT ICON"
	HREF="${pageContext.request.contextPath}/resources/img/favicon.ico" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myCSS.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/viewF.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>

<!-- 슬라이드 -->
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/ThumbSlide.css">
<script>
	function midNavMove(num){
		if(num==0){
			document.getElementById("priceInfo").scrollIntoView();
		}else if(num==1){
			document.getElementById("optionInfo").scrollIntoView();
		}else if(num==2){
			document.getElementById("locationInfo").scrollIntoView();
		}else if(num==3){
			document.getElementById("moreInfo").scrollIntoView();
		}
	}
	
	$(document).on("click", "#sh-link", function(e) { // 링크복사 시 화면 크기 고정
		$('html').find('meta[name=viewport]').attr('content', 'width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no');
	var html = "<input id='clip_target' type='text' value='' style='position:absolute;top:-9999em;'/>"; 
	$(this).append(html);
	var input_clip = document.getElementById("clip_target"); //현재 url 가져오기
		var _url = $(location).attr('href'); $("#clip_target").val(_url); 
		if (navigator.userAgent.match(/(iPod|iPhone|iPad)/)) { 
			var editable = input_clip.contentEditable; 
			var readOnly = input_clip.readOnly; 
			input_clip.contentEditable = true; 
			input_clip.readOnly = false; 
			var range = document.createRange(); 
			range.selectNodeContents(input_clip); 
			var selection = window.getSelection(); 
			selection.removeAllRanges(); 
			selection.addRange(range); 
			input_clip.setSelectionRange(0, 999999); 
			input_clip.contentEditable = editable; 
			input_clip.readOnly = readOnly; 
			} else { 
				input_clip.select(); 
				} try { 
					var successful = document.execCommand('copy'); 
					input_clip.blur(); 
					if (successful) { 
						alert("URL이 복사 되었습니다. 원하시는 곳에 붙여넣기 해 주세요."); // 링크복사 시 화면 크기 고정
		$('html').find('meta[name=viewport]').attr('content', 'width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=yes'); 
						} else { 
							alert('이 브라우저는 지원하지 않습니다.');
							} 
					} catch (err) { 
						alert('이 브라우저는 지원하지 않습니다.');
						} 
					}); //클립보드 복사
					
function soldOutChk(){
	var done = "";
	if($("input:checkbox[id='soldChk']").is(":checked")){
		done="Y";
	}else{
		done="N";
	}
	var dobj={
		"done":done,
		"flatID":${fdto.flatID}
	};
	$.ajax({
		url : "doneUpdate",
		data : JSON.stringify(dobj),
		dataType : "json",
		contentType : "application/json; charset=UTF-8",
		type : "POST",
		success : function(data){
			console.log(done);
		},
		error : function(request, status, error) {
			console.log("AJAX_ERROR");
		}
	});
}
function delFlat(){
	if(confirm("정말 삭제하시겠습니까?")){
		var fNum = $("#fIDInput").val();
		$.ajax({
			url:"delOneFlat",
			data:fNum,
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			type:"POST",
			success:function(data){
				//최근 본 목록에서도 삭제
				delFlatAfter(fNum);
				location.href="myFlats";
			},
			error : function(request, status, error) {
				console.log("AJAX_ERROR");
			}
		});
	}
}

function dipsChk(){
	var nowLog =$("#nowLog").val();
	var ttDips = Number($("#ttDips").val());
	if(nowLog){
		var fNum = $("#fIDInput").val();
		var dips = "";
		if($("input:checkbox[id='dipsChk']").is(":checked")){
			dips="Y";
			$("#sprImg").css({
				"object-position":"-6px -45px"
			});
		}else{
			dips="N";
			$("#sprImg").css({
				"object-position":"-6px -6px"
			});
		}
		var dobj = {
				"fNum":fNum,
				"dips":dips,
				"logID":nowLog
		};
		$.ajax({
			url : "dipsChange",
			data : JSON.stringify(dobj),
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			type:"POST",
			success:function(data){
				console.log("DIPS_SUCCESS");
				$("#ttDNum").html(data);
			},
			error:function(request, status, error){
				console.log("AJAX_ERROR");
			}
		});
	}else{
		if(confirm("로그인이 필요한 서비스 입니다!")){
			location.href="login";
		}
	}
}
function contact(){
	/* var sellerID = $("#upID").val();
	$.ajax({
		url:"getContacts",
		data:sellerID,
		dataType:"json",
		contentType:"application/json; charset=UTF-8",
		type:"POST",
		success:function(data){
			var html="";
			html+="<p>"+data.id+"님의 연락처</p>";
			html+="<p><i class=\"fa fa-phone\" aria-hidden=\"true\"></i> "+data.tel+"</p>";
			html+="<p><i class=\"fa fa-envelope\" aria-hidden=\"true\"></i> "+data.email+"</p>";
			$("#modalMsg").html(html);
		},
		error:function(request,status, error){
			console.log("AJAX_ERROR");
		}
	}); */
	if(!$("#nowLog").val()){
		alert("로그인이 필요한 서비스입니다!");
		return false;
	}else{
	var other = $("#upID").val();
	window.open("chat?other="+other, "chatting", "width=400, height=600, left=700, top=100");
	}
}

function chatListOpen() {
	window.open("chatList", "chatting",
			"width=400, height=600, left=700, top=100");
}
</script>

<!-- 모달 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

<body>
	<input type="hidden" id="ttDips" value="${totalDips }">
	<input type="hidden" id="nowLog"
		<c:if test="${logID!=null }">value="${logID }"</c:if>>
	<input type="hidden" id="fIDInput" value="${fdto.flatID }">
	<input type="hidden" id="upID" value="${fdto.memberID }">
	<div class="container">
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
		<!-- 매물 자세히 보기 -->
		<section class="FWrap2">
			<!-- 맨상단정보 -->
			<div class="view_header">
				<div class="vhLeft">
					<ul>
						<li>
							<p>${fdto.room }</p>
							<h1>
								<span class="bigTxt">${fdto.rentType } ${fdto.deposit }</span> <span
									class="smlTxt">만원</span>
							</h1>
						</li>
						<li>
							<p>평수</p>
							<h1>
								<span class="bigTxt">${fdto.pyeong }</span> <span class="smlTxt">평</span>
							</h1>
						</li>
						<li>
							<p class="blueTxt">한달 예상 주거비</p>
							<h1>
								<span class="bigTxt blueTxt">${fdto.rent }</span><span
									class="bigTxt blueTxt">만원 </span>
							</h1>
						</li>
					</ul>
				</div>
				<div class="vhRight">
					<p class="middleman">
						<i class="fa fa-user-circle-o" aria-hidden="true"></i>
						${fdto.memberID } <span class="whosF">님의 방</span>
					</p>
					<c:choose>
						<c:when test="${fdto.memberID!=logID }">
							<c:choose>
								<c:when test="${fdto.done=='N' }">
									<!-- Button trigger modal -->
									<button type="button"
										class="btn btn-outline-secondary contactM" onclick="contact()">방주인에게
										연락하기</button>
								</c:when>
								<c:otherwise>
									<button class="btn btn-outline-danger contactM"
										style="color: red;">거래완료</button>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div>
								<button onclick="location.href='modifyF?flatID=${fdto.flatID}'"
									class="btn btn-outline-warning myFRight" type="button">수정</button>
								<button onclick="delFlat()"
									class="btn btn-outline-danger myFRight myFDel" type="button">삭제</button>
							</div>
							<div class="myFsold">
								<label onchange="soldOutChk()" class="soChk" for="soldChk">거래완료&nbsp;<input
									type="checkbox" name="done" id="soldChk"
									<c:if test="${fdto.done=='Y' }">checked</c:if>></label>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<!-- 좋아요, 링크, 신고 -->
			<div class="smallBtns">
				<ul>
					<li><a class="spriteContainer" href="#"> <label
							for="dipsChk" onchange="dipsChk()"><input id="dipsChk"
								type="checkbox" <c:if test="${myDip>0 }">checked</c:if>>
								<img id="sprImg" class="spriteImg"
								src="${pageContext.request.contextPath}/resources/img/spritesheet.png"
								alt="dips"
								<c:if test="${myDip!=null && myDip>0 }">style="object-position:-6px -45px"</c:if>>
								찜 <span id="ttDNum">${totalDips }</span> 개</label>
					</a></li>
					<li><a id="sh-link" href="#"> <i class="fa fa-link"
							aria-hidden="true"></i> <span>링크복사</span>
					</a></li>
				</ul>
			</div>
			<!-- 매물 정보 -->
			<div class="infoF">
				<table>
					<tr>
						<th>ㆍ매물 등록일</th>
						<td>${fdto.uploadDate }</td>
						<th>ㆍ입주 가능일</th>
						<td>${fdto.moveDate }</td>
						<th>ㆍ층 수</th>
						<td>${fdto.floor }층</td>
					</tr>
				</table>
			</div>
			<!-- 매물 사진 -->
			<div class="viewImgs">

				<!-- 이미지 썸네일 슬라이드!!! -->
				<div id="simpleModal" class="modal">
					<div class="modal-content">
						<span class="closeBtn">&times;</span>
						<!-- Swiper modal -->
						<div id="swiper-container-modal" class="swiper-container-modal">
							<div class="swiper-wrapper">
								<c:forEach items="${pList }" var="p">
									<div class="swiper-slide swiper-slide-modal">
										<div class="swiper-zoom-container"
											style="background-color: #222;">
											<img class="swiper-lazy swiper-lazy-modal"
												data-src="${pageContext.request.contextPath}/download?filename=${p.fileName }">
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- Add Pagination -->
							<div id="swiper-pagination-modal" class="swiper-pagination"></div>
							<!-- Add Pagination -->
							<div id="swiper-button-next-modal" class="swiper-button-next"></div>
							<div id="swiper-button-prev-modal" class="swiper-button-prev"></div>
						</div>
					</div>
				</div>

				<!-- Swiper -->
				<div class="swiper-container swiper-container-main">
					<span class="maeNum">매물번호 ${fdto.flatID }</span>
					<div class="swiper-wrapper">
						<c:forEach items="${pList }" var="p">
							<div class="swiper-slide minimum-height">
								<img class="swiper-slide-img"
									src="${pageContext.request.contextPath}/download?filename=${p.fileName }">
							</div>
						</c:forEach>
					</div>
					<!-- Add Pagination -->
					<div class="swiper-pagination"></div>
					<!-- Add Pagination -->
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>

				<!-- Swiper thumbnails -->
				<div class="swiper-container gallery-thumbs">
					<div class="swiper-wrapper">
						<c:forEach items="${pList }" var="p">
							<div class="swiper-slide swiper-slide-thumbs">
								<img
									src="${pageContext.request.contextPath}/download?filename=${p.fileName }">
							</div>
						</c:forEach>
					</div>

					<!-- Swiper JS -->
					<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/resources/js/thumbSlide.js"></script>


				</div>
			</div>
			<!-- 상세설명 -->
			<div class="details">
				<div class="deTitle">
					<p>${fdto.title }</p>
				</div>
				<div class="deDet">
					<textarea rows="15"
						style="width: 100%; resize: none; overflow: auto; border: 0;">${fdto.detail }</textarea>
				</div>
			</div>
			<!-- 중간네비 -->
			<nav class="midNav">
				<ul>
					<li onclick="midNavMove(0);">가격정보</li>
					<li onclick="midNavMove(1);">옵션</li>
					<li onclick="midNavMove(2);">위치 및 주변 시설</li>
					<li onclick="midNavMove(3);">근처의 다른 방</li>
				</ul>
			</nav>
			<!-- 가격정보 -->
			<div id="priceInfo" class="priceF">
				<h1>가격정보</h1>
				<div class="blueBox">
					<p class="prLeft">${fdto.rentType }&nbsp;${fdto.deposit }만원</p>
					<div class="prRight">
						<p class="prRTop">한 달 주거비용</p>
						<p class="prRBottom">${fdto.rent }만원</p>
					</div>
				</div>
			</div>
			<!-- 옵션 -->
			<div id="optionInfo" class="options">
				<h1>옵션</h1>
				<c:if test="${fdto.park =='Y' }">
					<span class="opt"> <i class="fa fa-car fa-3x"
						aria-hidden="true"></i> <span>주차 가능</span>
					</span>
				</c:if>
				<c:if test="${fdto.pet =='Y' }">
					<span class="opt"> <i class="fa fa-paw fa-3x"
						aria-hidden="true"></i> <span>반려동물 가능</span>
					</span>
				</c:if>
				<c:if test="${fdto.furniture =='Y' }">
					<span class="opt"> <i class="fa fa-bed fa-3x"
						aria-hidden="true"></i> <span>가구 있음</span>
					</span>
				</c:if>
				<c:if test="${fdto.internet =='Y' }">
					<span class="opt"> <i class="fa fa-wifi fa-3x"
						aria-hidden="true"></i> <span>인터넷 설치됨</span>
					</span>
				</c:if>
			</div>
			<!-- 위치 및 주변 시설 -->
			<div id="locationInfo" class="addrCircle">
				<h1>위치 및 주변 시설</h1>
				<p style="text-align: center;">${fdto.roadAdrs }</p>
				<div id="map" class="kakaoM"></div>
				<div id="category" class="switch-field">
					<input type="radio" id="CS2" name="ctg" value="CS2" data-order="0">
					<label for="CS2">편의점</label> <input type="radio" id="SW8"
						name="ctg" value="SW8" data-order="1"> <label for="SW8">지하철</label>
					<input type="radio" id="BK9" name="ctg" value="BK9" data-order="2">
					<label for="BK9">은행</label> <input type="radio" id="PO3" name="ctg"
						value="PO3" data-order="3"> <label for="PO3">공공기관</label>
					<input type="radio" id="CE7" name="ctg" value="CE7" data-order="4">
					<label for="CE7">카페</label>
				</div>
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08492f1f66baf843bb674685c1c67160&libraries=services"></script>
				<script>
				var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
			    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
			    markers = [], // 마커를 담을 배열입니다
			    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
				
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new kakao.maps.LatLng(${fdto.lat}, ${fdto.lng}), // 지도의 중심좌표
						level : 3
					// 지도의 확대 레벨
					};

					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
					
					
					// 장소 검색 객체를 생성합니다
					var ps = new kakao.maps.services.Places(map); 
					// 지도에 idle 이벤트를 등록합니다
					kakao.maps.event.addListener(map, 'idle', searchPlaces);

					// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
					contentNode.className = 'placeinfo_wrap';

					// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
					// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
					addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
					addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

					// 커스텀 오버레이 컨텐츠를 설정합니다
					placeOverlay.setContent(contentNode);  

					// 각 카테고리에 클릭 이벤트를 등록합니다
					addCategoryClickEvent();

					// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
					function addEventHandle(target, type, callback) {
					    if (target.addEventListener) {
					        target.addEventListener(type, callback);
					    } else {
					        target.attachEvent('on' + type, callback);
					    }
					}

					// 카테고리 검색을 요청하는 함수입니다
					function searchPlaces() {
					    if (!currCategory) {
					        return;
					    }
					    
					    // 커스텀 오버레이를 숨깁니다 
					    placeOverlay.setMap(null);

					    // 지도에 표시되고 있는 마커를 제거합니다
					    removeMarker();
					    
					    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
					}

					// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
					function placesSearchCB(data, status, pagination) {
					    if (status === kakao.maps.services.Status.OK) {

					        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
					        displayPlaces(data);
					    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
					        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

					    } else if (status === kakao.maps.services.Status.ERROR) {
					        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
					        
					    }
					}

					// 지도에 마커를 표출하는 함수입니다
					function displayPlaces(places) {

					    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
					    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
					    var order = document.getElementById(currCategory).getAttribute('data-order');

					    

					    for ( var i=0; i<places.length; i++ ) {

					            // 마커를 생성하고 지도에 표시합니다
					            var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

					            // 마커와 검색결과 항목을 클릭 했을 때
					            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
					            (function(marker, place) {
					                kakao.maps.event.addListener(marker, 'click', function() {
					                    displayPlaceInfo(place);
					                });
					            })(marker, places[i]);
					    }
					}

					// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
					function addMarker(position, order) {
					    var imageSrc = '${pageContext.request.contextPath}/resources/img/locationPicto (2).png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
					        imageSize = new kakao.maps.Size(28, 28),  // 마커 이미지의 크기
					        imgOptions =  {
					            spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
					            spriteOrigin : new kakao.maps.Point(43, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
					            offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
					        },
					        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
					            marker = new kakao.maps.Marker({
					            position: position, // 마커의 위치
					            image: markerImage 
					        });

					    marker.setMap(map); // 지도 위에 마커를 표출합니다
					    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

					    return marker;
					}

					// 지도 위에 표시되고 있는 마커를 모두 제거합니다
					function removeMarker() {
					    for ( var i = 0; i < markers.length; i++ ) {
					        markers[i].setMap(null);
					    }   
					    markers = [];
					}

					// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
					function displayPlaceInfo (place) {
					    var content = '<div class="placeinfo">' +
					                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

					    if (place.road_address_name) {
					        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
					                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
					    }  else {
					        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
					    }                
					   
					    content += '    <span class="tel">' + place.phone + '</span>' + 
					                '</div>' + 
					                '<div class="after"></div>';

					    contentNode.innerHTML = content;
					    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
					    placeOverlay.setMap(map);  
					}


					// 각 카테고리에 클릭 이벤트를 등록합니다
					function addCategoryClickEvent() {
					    var category = document.getElementById('category'),
					        children = category.children;

					    for (var i=0; i<children.length; i++) {
					        children[i].onclick = onClickCategory;
					    }
					}

					// 카테고리를 클릭했을 때 호출되는 함수입니다
					function onClickCategory() {
					    var id = this.id,
					        className = this.className;

					    placeOverlay.setMap(null);

					    if (className === 'on') {
					        currCategory = '';
					        changeCategoryClass();
					        removeMarker();
					    } else {
					        currCategory = id;
					        changeCategoryClass(this);
					        searchPlaces();
					    }
					}

					// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
					function changeCategoryClass(el) {
					    var category = document.getElementById('category'),
					        children = category.children,
					        i;

					    for ( i=0; i<children.length; i++ ) {
					        children[i].className = '';
					    }

					    if (el) {
					        el.className = 'on';
					    } 
					} 
					
					

					// 지도에 표시할 원을 생성합니다
					var circle = new kakao.maps.Circle({
						center : new kakao.maps.LatLng(${fdto.lat}, ${fdto.lng}), // 원의 중심좌표 입니다 
						radius : 100, // 미터 단위의 원의 반지름입니다 
						strokeWeight : 5, // 선의 두께입니다 
						strokeColor : '#75B8FA', // 선의 색깔입니다
						strokeOpacity : 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						strokeStyle : 'dashed', // 선의 스타일 입니다
						fillColor : '#CFE7FF', // 채우기 색깔입니다
						fillOpacity : 0.5
					// 채우기 불투명도 입니다   
					});

					// 지도에 원을 표시합니다 
					circle.setMap(map);
				</script>
			</div>
			<!-- 근처의 다른 방 -->
			<div id="moreInfo" class="otherFTS">
				<h1>
					<span class="whereIs">${where }</span>의다른 방
				</h1>
				<ul>
					<c:choose>
						<c:when test="${fn:length(otherList)>1}">
							<c:forEach items="${otherList }" var="o">
								<c:if test="${o.flatID != fdto.flatID  }">
									<li class="FTSBox"
										onclick="javascript:moveItemViewPage('${logID}','${o.rentType }','${o.deposit }','${o.rent }','${o.title }','${o.flatID }','${pageContext.request.contextPath}/download?filename=${o.fileName }'); return false;"><img
										class="FTSImg"
										src="${pageContext.request.contextPath}/download?filename=${o.fileName }"
										alt="">
										<p>${o.room }</p>
										<p>${o.rentType }${o.deposit }/${o.rent }</p>
										<p class="targetTxt">${o.title }<br> ${o.detail }
										</p></li>
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<p class="noOtherF">근처에 다른 방이 없습니다!</p>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</section>
		<!--푸터 -->
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
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
</body>

</html>