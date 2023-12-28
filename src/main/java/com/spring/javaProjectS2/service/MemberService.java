package com.spring.javaProjectS2.service;

import com.spring.javaProjectS2.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberInput(MemberVO vo);

}
