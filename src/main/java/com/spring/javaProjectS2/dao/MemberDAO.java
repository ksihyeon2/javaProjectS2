package com.spring.javaProjectS2.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdCheck(@Param("mid") String mid);

	MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	int setMemberInput(@Param("vo") MemberVO vo);

	void setMemberUpdate(@Param("vo") MemberVO vo);

	MemberVO memberMidSearch(@Param("email") String email);

	void setMemberImsiPwd(@Param("mid")String mid, @Param("pwd") String pwd);

	int setMemberModify(@Param("vo") MemberVO vo);

	void setMemberPwdChangeOk(@Param("mid") String mid, @Param("pwd") String pwd);

	int setMemberDelOk(@Param("mid") String mid);

}
