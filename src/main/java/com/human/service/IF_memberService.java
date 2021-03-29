package com.human.service;

import com.human.DTO.MemberDTO;

public interface IF_memberService {

	public int loginChk(MemberDTO m);

	public int dupChk(String id);

	public int signUp(MemberDTO tempM);

	public MemberDTO getContacts(String sellID);

}
