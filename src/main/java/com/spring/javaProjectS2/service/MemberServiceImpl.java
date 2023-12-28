package com.spring.javaProjectS2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS2.dao.MemberDAO;
import com.spring.javaProjectS2.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDao;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDao.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickCheck(String nickName) {
		return memberDao.getMemberNickCheck(nickName);
	}

	@Override
	public int setMemberInput(MemberVO vo) {
		return memberDao.setMemberInput(vo);
	}
}
