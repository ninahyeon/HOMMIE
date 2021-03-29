package com.human.DAOIF;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import com.human.DTO.ChatDTO;

@Repository
public class ChatDAOImpl implements IF_ChatDAO {
	private static String mapperQuery = "com.human.DAOIF.IF_ChatDAO";

	@Inject
	private SqlSession sqlSession;

	@Override
	public Integer roomExist(ChatDTO c) {
		return sqlSession.selectOne(mapperQuery + ".roomExist", c);
	}

	@Override
	public void createChatRoom(ChatDTO c) {
		sqlSession.insert(mapperQuery + ".createChatRoom", c);
	}

	@Override
	public List<ChatDTO> myChatList(String logID) {
		return sqlSession.selectList(mapperQuery + ".myChatList", logID);
	}

	@Override
	public int saveChat(JSONObject jObj) {
		return sqlSession.insert(mapperQuery + ".saveChat", jObj);
	}

	@Override
	public List<ChatDTO> getAllMsg(Integer roomNum) {
		return sqlSession.selectList(mapperQuery + ".getAllMsg", roomNum);
	}

}
