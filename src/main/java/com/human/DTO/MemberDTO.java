package com.human.DTO;

import oracle.sql.DATE;

public class MemberDTO {
	String id;
	String pw;
	String name;
	String email;
	String tel;
	DATE joinDate;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public DATE getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(DATE joinDate) {
		this.joinDate = joinDate;
	}

}
