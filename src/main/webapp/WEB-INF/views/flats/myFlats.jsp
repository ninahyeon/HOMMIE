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
<title>Hommie-방내놓기</title>
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
							<li class="nav-item"><a class="nav-link big-item" href="#">방내놓기</a>
							</li>
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
			<form action="#" method="POST">
				<div class="uploadF">
					<h2>방 내놓기</h2>
					<div class="flatDo">
						<ul class="titUL">
							<li onclick="location.href = 'uploadFlat'"
								style="border-bottom: 3px solid #d1d1d1;"><a
								class="flatupload" style="color: #d1d1d1;"> 방 내놓기 </a></li>
							<li style="border-bottom: 3px solid #222;"><a class="myflat"
								style="color: #222;"> 내 방 관리 </a></li>
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
							<li>
								<p>ㆍ광고중 : 내가 등록한 매물이 공개중인 상태</p>
							</li>
							<li>
								<p>ㆍ거래완료 : 등록한 매물이 거래완료된 상태</p>
							</li>
							<li>
								<p>ㆍ검수반려 : 운영원칙 위배 또는 신고로 비공개된 상태</p>
							</li>
						</ul>
					</div>
					<div class="myF">
						<div class="myFList">
							<c:choose>
								<c:when test="${myFList==null }">
									<p class="noF">등록된 매물이 없습니다.</p>
								</c:when>
								<c:otherwise>
									<ul class="keysch myFlats">
										<c:forEach items="${myFList }" var="m">
											<li onclick="moveToViewF(${m.flatID})"><c:if
													test="${m.done=='Y' }">
													<div class="soldOut">거래완료</div>
												</c:if>
												<div class="imgWrapper_m">
													<img
														src="${pageContext.request.contextPath}/download?filename=${m.fileName}"
														alt="myFlats" class="keyword">
												</div>
												<p class="myFtitle">${m.title }</p>
												<p>${m.rentType}&nbsp;${m.deposit }&nbsp;/&nbsp;${m.rent }</p>
												<p class="uploadD">등록일 : ${m.uploadDate }</p></li>
										</c:forEach>
									</ul>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="spacie"></div>
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
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
</body>

</html>