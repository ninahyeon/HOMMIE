package com.human.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.human.DAOIF.IF_memberDAO;
import com.human.DTO.MemberDTO;

@Service
public class MemberServiceImpl implements IF_memberService {
	@Inject
	private IF_memberDAO mdao;

	@Override
	public int loginChk(MemberDTO m) {
		return mdao.loginChk(m);
	}

	@Override
	public int dupChk(String id) {
		return mdao.dupChk(id);
	}

	@Override
	public int signUp(MemberDTO tempM) {
		return mdao.signUp(tempM);
	}

	@Override
	public MemberDTO getContacts(String sellID) {
		return mdao.getContacts(sellID);
	}

}
