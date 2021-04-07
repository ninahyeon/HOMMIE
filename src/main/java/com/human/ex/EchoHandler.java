package com.human.ex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {

	List<HashMap<String, Object>> rls = new ArrayList<>();

	// 클라이언트가 연결 되었을 때 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 소켓 연결
		super.afterConnectionEstablished(session);
	}

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 메시지 발송
		String msg = message.getPayload();
		JSONObject obj = jsonToObjectParser(msg);

		String rN = (String) obj.get("roomNumber");
		// 방번호 등록
		boolean flag = false; // 방의 존재여부 확인할 변수
		int idx = 0; // 찾은 방의 인덱스를 넣을 변수
		String dataType = (String) obj.get("dataType");
		if (dataType.equals("register")) {
			if (rls.size() > 0) {
				// 리스트에서 방찾기
				for (int i = 0; i < rls.size(); i++) {
					String arrRN = (String) rls.get(i).get("roomNumber");
					if (arrRN.equals(rN)) {
						flag = true;
						idx = i;
						break;
					}
				}
			}

			if (flag) {
				// 방 존재함 - 세션만 추가
				HashMap<String, Object> map = rls.get(idx);
				map.put(session.getId(), session);
			} else {
				// 방 최초 생성 - 방번호와 세션 추가
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("roomNumber", rN);
				map.put(session.getId(), session);
				rls.add(map);
			}
		} else {
			// 진짜 메시지
			HashMap<String, Object> temp = new HashMap<String, Object>();
			if (rls.size() > 0) {
				for (int i = 0; i < rls.size(); i++) {
					// 세션 리스트에 저장된 방 번호 가져옴
					String roomNumber = (String) rls.get(i).get("roomNumber");
					if (roomNumber.equals(rN)) {
						// 같은 번호 방 존재한다면
						temp = rls.get(i);
						break;
					}
				}
				// 해당 방의 세션들만 찾아서 메시지 발송
				for (String k : temp.keySet()) {
					if (k.equals("roomNumber")) {
						continue;
					}
					WebSocketSession wss = (WebSocketSession) temp.get(k);
					if (wss != null) {
						wss.sendMessage(new TextMessage(obj.toJSONString()));
					}
				}
			}
		}

	}

	// 클라이언트 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 소켓 종료
		if (rls.size() > 0) {
			for (int i = 0; i < rls.size(); i++) {
				rls.get(i).remove(session.getId());
			}
		}
		super.afterConnectionClosed(session, status);
	}

	private static JSONObject jsonToObjectParser(String jsonStr) throws ParseException {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		obj = (JSONObject) parser.parse(jsonStr);
		return obj;
	}
}