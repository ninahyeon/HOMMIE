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

<title>Login</title>
<LINK REL="SHORTCUT ICON"
	HREF="${pageContext.request.contextPath}/resources/img/favicon.ico" />
<style>
.warnings {
	color: red;
}
</style>
<script type="text/javascript">
	function checkValue() {
		var memberid = $("#id").val();
		var memberpw = $("#password").val();
		$("#id_box").empty();
		$("#pw_box").empty();
		if (!memberid) {
			var html = "";
			html += "아이디를 입력하세요!"
			$("#id_box").html(html);
			return false;
		}
		if (!memberpw) {
			var html = "";
			html += "비밀번호를 입력하세요!"
			$("#pw_box").html(html);
			return false;
		}
		var form = {
			"id" : memberid,
			"pw" : memberpw
		};
		var rtn = true;
		$.ajax({
			async : false,
			type : "POST",
			url : "/hommie/login_chk",
			data : JSON.stringify(form),
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			success : function(num) {
				if (num <= 0) {
					var html = "";
					html += "가입하지 않은 아이디, 혹은 틀린 비밀번호 입니다!";
					$("#pw_box").html(html);
					rtn = false;
				}
			},
			error : function(error) {
				alert("DB접근 실패");
			}
		});
		return rtn;
	}
	function signup() {
		document.location = "signup";
	}
</script>
</head>

<body>
	<div class="d-md-flex half">
		<div class="bg"
			style="background-image: url('${pageContext.request.contextPath}/resources/img/login.jpg');"></div>
		<div class="contents">

			<div class="container">
				<div class="row align-items-center justify-content-center">
					<div class="col-md-12">
						<div class="form-block mx-auto">
							<div class="text-center mb-5">

								<h3 class="text-uppercase">
									<img onclick="javascript:location.href='home';" class="logo"
										style="max-width: 50%; cursor: pointer;"
										src="${pageContext.request.contextPath}/resources/img/logo.png"
										alt=""> 로그인
								</h3>
							</div>
							<form action="submit_login" method="get"
								onsubmit="return checkValue();" name="login">
								<div class="form-group first">
									<label for="id">ID</label> <input type="text"
										class="form-control" placeholder="아이디" id="id" name="id">
									<p class="warnings" id="id_box"></p>
								</div>
								<div class="form-group last mb-3">
									<label for="password">비밀번호</label> <input type="password"
										class="form-control" placeholder="비밀번호" id="password"
										name="pw">
									<p class="warnings" id="pw_box"></p>

								</div>

								<!-- <div class="d-sm-flex mb-5 align-items-center">
									<div class="control__indicator"></div>
									</label> <span class="ml-auto"><a href="#" class="forgot-pass">Forgot
											Password</a></span>
								</div> -->
								<div style="height: 50px;"></div>
								<div class="signBtn">
									<input type="submit" value="로그인"
										class="btn btn-block py-2 btn-primary login">
									<button type="button" onclick="signup()"
										class="btn btn-block py-2 signup">회원가입</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>


	</div>

	<script
		src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>

</html>