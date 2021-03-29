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
<title>Hommie-찜한목록</title>
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
									<li><a class="dropdown-item" href="#">찜한 목록</a></li>
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
		<!-- 관심목록 -->
		<section class="FWrap">
			<form action="#" method="POST">
				<div class="uploadF">
					<h2>관심목록</h2>
					<div class="flatDo">
						<ul class="titUL">
							<li style="border-bottom: 3px solid #222;"><a href="#"
								class="flatupload" style="color: #222;"> 찜한 목록 </a></li>
							<li onclick="" style="border-bottom: 3px solid #d1d1d1;"><a
								href="recentViews" class="myflat" style="color: #d1d1d1;">
									최근 본 방 </a></li>
						</ul>
					</div>
					<div class="dipsF">
						<ul>
							<c:forEach items="${dipsList }" var="d">
								<li
									onclick="javascript:moveItemViewPage('${logID}', '${d.rentType }', '${d.deposit }', '${d.rent }', '${d.title }', '${d.flatID }', '${pageContext.request.contextPath}/download?filename=${d.fileName }'); return false;">
									<img class="dipsImg"
									src="${pageContext.request.contextPath}/download?filename=${d.fileName }"
									alt="">
									<p class="moneyInfo">${d.rentType }&nbsp;${d.room }&nbsp;${d.deposit }/${d.rent }</p>
									<p class="locationInfo">${d.roadAdrs }</p>
									<p class="titleInfo">${d.title }</p>
								</li>
								<hr class="gububu">
							</c:forEach>
						</ul>
					</div>
					<div class="spacie"></div>
				</div>
			</form>
			<div
				style="float: left; height: 100px; width: 100%; margin: 0 auto; text-align: center;">
				<ul class="pagination"
					style="display: table; margin: auto; padding: 0;">
					<c:if test="${pageMaker.prev>0 }">
						<li class="page-item"
							style="float: left; text-align: center; display: inline-block;"><a
							class="page-link" href='dipsF?page=${pageMaker.prev}'
							tabindex="-1">Previous</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.start }" end="${pageMaker.end }"
						var="idx">
						<c:choose>
							<c:when test="${pageMaker.page eq idx }">
								<li class="page-item active" aria-current="page"
									style="float: left; text-align: center; display: inline-block;"><a
									class="page-link" href='dipsF?page=${idx}'>${idx }</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"
									style="float: left; text-align: center; display: inline-block;"><a
									class="page-link" href='dipsF?page=${idx}'>${idx }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageMaker.next>0 }">
						<li class="page-item"
							style="float: left; text-align: center; display: inline-block;"><a
							class="page-link" href='dipsF?page=${pageMaker.next}'>Next</a></li>
					</c:if>
				</ul>
			</div>
		</section>
		<div class="spacie"></div>
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
				<li><a href="#">관심목록</a></li>
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