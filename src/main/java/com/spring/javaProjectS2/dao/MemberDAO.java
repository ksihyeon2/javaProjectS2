package com.spring.javaProjectS2.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdCheck(@Param("mid") String mid);

	MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	int setMemberInput(@Param("vo") MemberVO vo);

}
