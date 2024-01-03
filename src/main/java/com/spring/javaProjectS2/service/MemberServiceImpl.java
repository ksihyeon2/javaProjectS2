package com.spring.javaProjectS2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS2.dao.MemberDAO;
import com.spring.javaProjectS2.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickCheck(String nickName) {
		return memberDAO.getMemberNickCheck(nickName);
	}

	@Override
	public int setMemberInput(MemberVO vo) {
		return memberDAO.setMemberInput(vo);
	}

	@Override
	public void setMemberUpdate(MemberVO vo) {
		memberDAO.setMemberUpdate(vo);
	}

	@Override
	public MemberVO memberMidSearch(String email) {
		return memberDAO.memberMidSearch(email);
	}

	@Override
	public void setMemberImsiPwd(String mid, String pwd) {
		memberDAO.setMemberImsiPwd(mid,pwd);
	}
}
