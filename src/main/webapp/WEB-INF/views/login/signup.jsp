<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap"
	rel="stylesheet">

<!-- Icon -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

<!-- Style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login.css">

<title>Hommie-회원가입</title>
<LINK REL="SHORTCUT ICON"
	HREF="${pageContext.request.contextPath}/resources/img/favicon.ico" />
<style>
.demended {
	color: red;
}

.warnings {
	color: red;
}

.great {
	color: blue;
}
</style>
<script type="text/javascript">
	function login() {
		document.location = "login";
	}
	function checkValue() {
		if ($("#id_warn").val() != "사용 가능한 아이디입니다.") {
			var element = document.getElementById("id_warn");
			element.classList.remove("great");
			element.classList.add("warnings");
			$("#id_warn").empty();
		}
		$("#pw_warn").empty();
		$("#pw_chk_warn").empty();
		$("#name_warn").empty();
		$("#email_warn").empty();
		$("#tel_warn").empty();
		var mid = $("#id").val();
		var mpw = $("#password").val();
		var mpw_chk = $("#password_chk").val();
		var name = $("#name").val();
		var email = $("#email").val();
		var tel = $("#tel").val();

		// 아이디가 적합한지 검사할 정규식
		var re = /^[a-zA-Z0-9]{4,15}$/;
		// 비밀번호가 적합한지 검사하라 정규식
		var re1 = /^[a-zA-Z0-9]{6,20}$/;
		// 이메일 검사 정규식
		var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if (!$("input:checked[id='chk_box']").is(":checked")) {
			alert("이용약관에 동의해주세요.");
			$("#chk_box").focus();
			return false;
		}
		if (!mid) {
			var html = "";
			html += "아이디를 입력해주세요.";
			$("#id_warn").html(html);
			$("#id").focus();
			return false;
		}
		if (!check(re, $("#id"), $("#id_warn"), "4~15자의 영문 대소문자와 숫자만 입력")) {
			return false;
		}
		if ($("#idun").val() != "idCheck") {
			alert("아이디 중복체크를 해주세요!")
			return false;
		}
		if (!mpw) {
			var html = "";
			html += "비밀번호를 입력해주세요.";
			$("#pw_warn").html(html);
			$("#password").focus();
			return false;
		}
		if (!check(re1, $("#password"), $("#pw_warn"), "6~20자의 영문 대소문자와 숫자만 입력")) {
			$("#password_chk").val("");
			return false;
		}
		if (!mpw_chk) {
			var html = "";
			html += "비밀번호 확인을 입력해주세요.";
			$("#pw_chk_warn").html(html);
			$("#password_chk").focus();
			return false;
		}
		if (mpw != mpw_chk) {
			alert("비밀번호가 일치하지 않습니다!");
			return false;
		}
		if (!name) {
			var html = "";
			html += "이름을 입력해주세요.";
			$("#name_warn").html(html);
			$("#name").focus();
			return false;
		}
		if (!email) {
			var html = "";
			html += "이메일을 입력해주세요.";
			$("#email_warn").html(html);
			$("#email").focus();
			return false;
		}
		if (!check(re2, $("#email"), $("#email_warn"), "이메일 형식이 올바르지 않습니다.")) {
			return false;
		}
		if (!tel) {
			var html = "";
			html += "전화번호를 입력해주세요.";
			$("#tel_warn").html(html);
			$("#tel").focus();
			return false;
		}
		if (isNaN(tel)) {
			var html = "";
			html += "전화번호는 숫자만 입력해주세요.";
			$("#tel_warn").html(html);
			$("#tel").focus();
			return false;
		}

	}
	function check(re, what, warn, message) {
		if (re.test(what.val())) {
			return true;
		}
		warn.html(message);
		what.val("");
		what.focus();
	}
	function inputIdChk() {
		document.join.idDuplication.value = "idUncheck";
	}
	function idCheck() {
		var memberid = $("#id").val();
		if (memberid.search(/\s/) != -1) {
			alert("아이디에는 공백이 들어갈 수 없습니다!")
		} else {
			if (memberid.trim().length != 0) {
				$.ajax({
					async : true, //비동기방식 사용하겠다
					type : 'POST', //post방식으로
					data : memberid, //memberid라는 데이터를 보낸다.
					url : "/hommie/signup_dupChk", //컨트롤러의 signup_dupChk를 사용할 것임.
					dataType : "json", //json 형태의 데이터를 보낸다.
					contentType : "application/json; charset=UTF-8", //json형태로 보낼 때는 application/json을 붙여줌.
					success : function(count) { //통신 성공했을 때 내용. ()에는 데이터 보낸 곳의 리턴값이 들어온다.
						var html = "";
						if (count > 0) {
							html += "이미 존재하는 아이디입니다.";
							$("#id_warn").html(html);
						} else {
							var element = document.getElementById("id_warn");
							element.classList.remove("warnings");
							element.classList.add("great");
							html += "사용 가능한 아이디입니다.";
							$("#id_warn").html(html);
							$("#idun").val("idCheck");
						}
					},
					error : function(error) { //통신 실패 시 보여줄 내용.
						alert("중복체크 실패");
					}
				});
			} else {
				alert("중복체크 실패");
			}
		}
	}
</script>
</head>

<body>
	<div class="d-md-flex half">
		<div class="bg"
			style="background-image: url('${pageContext.request.contextPath}/resources/img/login.jpg');"></div>
		<div class="contents">

			<div class="container">
				<div class="row align-items-center justify-content-center"
					style="overflow: auto;">
					<div class="col-md-12">
						<div class="form-block mx-auto">
							<div class="text-center mb-5">
								<div id="goBack" onclick="login()">
									<button class="btn">
										<i class="fa fa-arrow-left fa-2x" aria-hidden="true"></i>
										<p>로그인</p>
									</button>
								</div>
								<div class="signup_title">
									<img onclick="javascript:location.href='home';" class="logo"
										style="max-width: 50%; cursor: pointer;"
										src="${pageContext.request.contextPath}/resources/img/logo.png"
										alt="">
									<h3 class="text-uppercase">회원가입</h3>
								</div>
							</div>
							<form action="signup_submit" method="get"
								onsubmit="return checkValue();" name="join">
								<div class="signup_clause">
									<label> <input type="checkbox" id="chk_box">
										Hommie 이용약관 동의<span class="demended">*</span>
									</label>
									<div
										style="overflow: scroll; width: 100%; height: 150px; border: 1px solid gray;">
										<p>지방의회의 조직·권한·의원선거와 지방자치단체의 장의 선임방법 기타 지방자치단체의 조직과 운영에 관한
											사항은 법률로 정한다. 대통령은 전시·사변 또는 이에 준하는 국가비상사태에 있어서 병력으로써 군사상의 필요에
											응하거나 공공의 안녕질서를 유지할 필요가 있을 때에는 법률이 정하는 바에 의하여 계엄을 선포할 수 있다.
											재판의 심리와 판결은 공개한다. 다만, 심리는 국가의 안전보장 또는 안녕질서를 방해하거나 선량한 풍속을 해할
											염려가 있을 때에는 법원의 결정으로 공개하지 아니할 수 있다. 국회는 헌법 또는 법률에 특별한 규정이 없는 한
											재적의원 과반수의 출석과 출석의원 과반수의 찬성으로 의결한다. 가부동수인 때에는 부결된 것으로 본다.</p>

										<p>모든 국민은 종교의 자유를 가진다. 모든 국민은 법률이 정하는 바에 의하여 국가기관에 문서로 청원할
											권리를 가진다. 대통령후보자가 1인일 때에는 그 득표수가 선거권자 총수의 3분의 1 이상이 아니면 대통령으로
											당선될 수 없다. 국회나 그 위원회의 요구가 있을 때에는 국무총리·국무위원 또는 정부위원은 출석·답변하여야
											하며, 국무총리 또는 국무위원이 출석요구를 받은 때에는 국무위원 또는 정부위원으로 하여금 출석·답변하게 할 수
											있다. 국회의원의 선거구와 비례대표제 기타 선거에 관한 사항은 법률로 정한다. 국회의 정기회는 법률이 정하는
											바에 의하여 매년 1회 집회되며, 국회의 임시회는 대통령 또는 국회재적의원 4분의 1 이상의 요구에 의하여
											집회된다.</p>


									</div>
								</div>
								<div class="form-group last mb-3" style="margin-top: 10px;">
									<label for="id">아이디<span class="demended">*</span></label> <input
										type="text" class="form-control" id="id"
										onkeydown="inputIdChk()" name="id">
									<p class="warnings" id="id_warn"></p>
									<button
										style="float: right; background-color: #2222; margin-top: 5px;"
										class="btn" type="button" onclick="idCheck()">중복확인</button>
									<input type="hidden" name="idDuplication" value="idUncheck"
										id="idun">
								</div>
								<div style="clear: both;" class="form-group last mb-3">
									<label for="password">비밀번호<span class="demended">*</span></label>
									<input type="password" class="form-control" id="password"
										name="pw">
									<p class="warnings" id="pw_warn"></p>
								</div>
								<div class="form-group last mb-3">
									<label for="password_chk">비밀번호 확인<span class="demended">*</span></label>
									<input type="password" class="form-control" id="password_chk">
									<p class="warnings" id="pw_chk_warn"></p>
								</div>
								<div class="form-group last mb-3">
									<label for="name">이름<span class="demended">*</span></label> <input
										type="text" class="form-control" id="name" name="name">
									<p class="warnings" id="name_warn"></p>
								</div>
								<div class="form-group last mb-3">
									<label for="email">이메일<span class="demended">*</span></label> <input
										type="text" class="form-control" id="email" name="email">
									<p class="warnings" id="email_warn"></p>
								</div>
								<div class="form-group last mb-3">
									<label for="tel">전화번호<span class="demended">*</span></label> <input
										type="tel" class="form-control" id="tel" name="tel">
									<p class="warnings" id="tel_warn"></p>
								</div>
								<div class="signBtn">
									<input type="submit" value="회원가입"
										class="btn btn-block py-2 btn-primary signup_only">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="../js/bootstrap.min.js"></script>
</body>

</html>