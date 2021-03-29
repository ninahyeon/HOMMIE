<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hommie - Chatting</title>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chat.css">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script>
	const Chat = (function() {
		let sock = new SockJS("${pageContext.request.contextPath}/echo/");
		sock.onopen = register;
		sock.onmessage = resive;
		sock.onclose = onClose;

		// init 함수
		function init() {
			// enter 키 이벤트
			$(document).on('keydown', 'div.input-div textarea', function(e) {
				if (e.keyCode == 13 && !e.shiftKey) {
					e.preventDefault();
					const message = $(this).val();

					// 메시지 전송
					sendMessage(message);
					// 입력창 clear
					clearTextarea();
				}
			});
		}

		function register() {
			const myName = $("#myID").val();
			const otherName = $("#otherID").val();
			const roomNum = $("#roomNum").val();
			const data = {
				roomNumber : roomNum,
				senderName : myName,
				getterName : otherName,
			};
			sock.send(JSON.stringify(data));

			// 스크롤바 아래 고정
			var end = document.body.scrollHeight;
			window.scrollTo(0, end);
		}

		// 메세지 태그 생성
		function createMessageTag(LR_className, senderName, message) {
			// 형식 가져오기
			let chatLi = $('div.chat.format ul li').clone();

			// 값 채우기
			chatLi.addClass(LR_className);
			chatLi.find('.sender span').text(senderName);
			chatLi.find('.message span').text(message);

			return chatLi;
		}

		// 메세지 태그 append
		function appendMessageTag(LR_className, senderName, message) {
			const chatLi = createMessageTag(LR_className, senderName, message);

			$('div.chat:not(.format) ul').append(chatLi);

			// 스크롤바 아래 고정
			var end = document.body.scrollHeight;
			window.scrollTo(0, end);
		}

		// 메세지 전송
		function sendMessage(message) {
			const myName = $("#myID").val();
			const otherName = $("#otherID").val();
			const roomNum = $("#roomNum").val();
			const data = {
				roomNumber : roomNum,
				senderName : myName,
				getterName : otherName,
				message : message
			};
			savethisMsg(data);

			sock.send(JSON.stringify(data));
		}

		//DB에 지금 전송하는 메시지 저장
		function savethisMsg(data) {
			$.ajax({
				url : "saveChat",
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				type : "POST",
				data : JSON.stringify(data),
				success : function(data) {
					console.log("성공");
				},
				error : function(request, status, error) {
					console.log("AJAX_ERROR");
				}
			});

		}

		// 메세지 입력박스 내용 지우기
		function clearTextarea() {
			$('div.input-div textarea').val('');
		}

		// 메세지 수신
		function resive(data) {
			const myName = $("#myID").val();
			var msg = data.data;
			if (msg != null && msg.trim() != "") {
				var d = JSON.parse(msg);
				if (d.message.trim() != "") {
					const LR = (d.senderName != myName) ? "left" : "right";
					appendMessageTag(LR, d.senderName, d.message);
				}
			}
		}

		//연결 끝
		function onClose(evt) {
			alert("끝");
		}

		return {
			'init' : init
		};
	})();

	$(function() {
		Chat.init();
	});
</script>
</head>
<body>
	<input type="hidden" id="roomNum" value="${chatInfo.roomNum }">
	<input type="hidden" id="otherID" value="${chatInfo.receiver }">
	<input type="hidden" id="myID" value="${chatInfo.sender }">
	<div class="chat_wrap">
		<div class="header">
			<img src="${pageContext.request.contextPath}/resources/img/logo.png"
				alt="">
		</div>
		<div class="chat">
			<ul>
				<c:forEach items="${msgList }" var="msg">
					<c:choose>
						<c:when test="${msg.sender==chatInfo.sender }">
							<li class="right">
								<div class="sender">
									<span>${chatInfo.sender }</span>
								</div>
								<div class="message">
									<span>${msg.msg }</span>
								</div>
							</li>
						</c:when>
						<c:otherwise>
							<li class="left">
								<div class="sender">
									<span>${msg.sender }</span>
								</div>
								<div class="message">
									<span>${msg.msg }</span>
								</div>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<!-- 동적 생성 -->

			</ul>
		</div>
		<div class="input-div">
			<textarea placeholder="엔터키를 누르면 전송됩니다."></textarea>
		</div>

		<!-- format -->

		<div class="chat format">
			<ul>
				<li>
					<div class="sender">
						<span></span>
					</div>
					<div class="message">
						<span></span>
					</div>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>