package com.human.hommie;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.DTO.ChatDTO;
import com.human.service.IF_ChatService;

@Controller
public class ChatController {
	@Inject
	private IF_ChatService cservice;

	// 방 주인과 채팅
	@SuppressWarnings("unused")
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String chat(Model m, HttpServletRequest h, @RequestParam("other") String other) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");

		ChatDTO c = new ChatDTO();
		c.setSender(logID);
		c.setReceiver(other);
		// logID와 other 의 채팅방이 DB에 있는지 확인
		Integer roomNum = cservice.roomExist(c);

		if (roomNum != null) {
			c.setRoomNum(roomNum);
			// 방 존재하면 모델에 대화기록 보내줌
			List<ChatDTO> msgList = cservice.getAllMsg(roomNum);
			m.addAttribute("msgList", msgList);
		} else {
			// 채팅방 생성
			cservice.createChatRoom(c);
		}

		m.addAttribute("chatInfo", c);
		return "chat/chat";
	}

	// 채팅 리스트
	@RequestMapping(value = "/chatList", method = RequestMethod.GET)
	public String chatList(Model m, HttpServletRequest h) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");

		List<ChatDTO> cList = cservice.myChatList(logID);
		if (cList != null) {
			m.addAttribute("cList", cList);
		}
		m.addAttribute("logID", logID);
		return "chat/chatList";
	}

	// DB에 메시지 저장
	@ResponseBody
	@RequestMapping(value = "/saveChat", method = RequestMethod.POST)
	public int saveChat(@RequestBody JSONObject jObj) {
		int suc = cservice.saveChat(jObj);
		return suc;
	}

}
