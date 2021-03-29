package com.human.DAOIF;

import com.human.DTO.MemberDTO;

public interface IF_memberDAO {

	public int loginChk(MemberDTO m);

	public int dupChk(String id);

	public int signUp(MemberDTO tempM);

	public MemberDTO getContacts(String sellID);

}
