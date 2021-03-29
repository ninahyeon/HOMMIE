<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hommie - ChatList</title>
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
<script type="text/javascript">
	function chatOpen(other) {
		window.open("chat?other=" + other, "chat",
				"width=400, height=600, left=700, top=100");
	}
</script>
</head>
<body>
	<input type="hidden" id="roomNum" value="${chatInfo.roomNum }">
	<input type="hidden" id="otherID" value="${otherID }">
	<input type="hidden" id="myID" value="${logID }">
	<div class="chat_wrap">
		<div class="header">
			<img src="${pageContext.request.contextPath}/resources/img/logo.png"
				alt="">
		</div>
		<div class="chatList">
			<ul>
				<c:forEach items="${cList }" var="c">
					<c:choose>
						<c:when test="${c.sender==logID }">
							<li onclick="chatOpen('${c.receiver}')">
								<p class="other">${c.receiver }</p>
								<p class="msg">${c.msg }</p>
							</li>
						</c:when>
						<c:otherwise>
							<li onclick="chatOpen('${c.sender}')">
								<p class="other">${c.sender}</p>
								<p class="msg">${c.msg }</p>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>