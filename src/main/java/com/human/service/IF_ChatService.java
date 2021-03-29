package com.human.service;

import java.util.List;

import org.json.simple.JSONObject;

import com.human.DTO.ChatDTO;

public interface IF_ChatService {

	public Integer roomExist(ChatDTO c);

	public void createChatRoom(ChatDTO c);

	public List<ChatDTO> myChatList(String logID);

	public int saveChat(JSONObject jObj);

	public List<ChatDTO> getAllMsg(Integer roomNum);

}
