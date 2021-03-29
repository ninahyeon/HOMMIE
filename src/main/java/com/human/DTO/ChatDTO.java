package com.human.DTO;

import oracle.sql.TIMESTAMP;

public class ChatDTO {
	int msgNum;
	int roomNum;
	String sender;
	String receiver;
	String msg;
	TIMESTAMP sendTime;

	public int getMsgNum() {
		return msgNum;
	}

	public void setMsgNum(int msgNum) {
		this.msgNum = msgNum;
	}

	public int getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public TIMESTAMP getSendTime() {
		return sendTime;
	}

	public void setSendTime(TIMESTAMP sendTime) {
		this.sendTime = sendTime;
	}

}
