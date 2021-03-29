package com.human.service;

import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.human.DAOIF.IF_ChatDAO;
import com.human.DTO.ChatDTO;

@Service
public class ChatServiceImpl implements IF_ChatService {
	@Inject
	private IF_ChatDAO cdao;

	@Override
	public Integer roomExist(ChatDTO c) {
		return cdao.roomExist(c);
	}

	@Override
	public void createChatRoom(ChatDTO c) {
		cdao.createChatRoom(c);
	}

	@Override
	public List<ChatDTO> myChatList(String logID) {
		return cdao.myChatList(logID);
	}

	@Override
	public int saveChat(JSONObject jObj) {
		return cdao.saveChat(jObj);
	}

	@Override
	public List<ChatDTO> getAllMsg(Integer roomNum) {
		return cdao.getAllMsg(roomNum);
	}

}
