package com.human.DAOIF;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.DTO.MemberDTO;

@Repository
public class MemberDAOImpl implements IF_memberDAO {
	private static String mapperQuery = "com.human.DAOIF.IF_memberDAO";

	@Inject
	private SqlSession sqlSession;

	@Override
	public int loginChk(MemberDTO m) {
		return sqlSession.selectOne(mapperQuery + ".loginChk", m);
	}

	@Override
	public int dupChk(String id) {
		return sqlSession.selectOne(mapperQuery + ".dupChk", id);
	}

	@Override
	public int signUp(MemberDTO tempM) {
		return sqlSession.insert(mapperQuery + ".signUp", tempM);
	}

	@Override
	public MemberDTO getContacts(String sellID) {
		return sqlSession.selectOne(mapperQuery + ".getContacts", sellID);
	}

}
