package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	public int setMemberInput(@Param("vo") MemberVO vo);

	public void setMemberUpdate(@Param("vo") MemberVO vo);

	public MemberVO memberMidSearch(@Param("email") String email);

	public void setMemberImsiPwd(@Param("mid")String mid, @Param("pwd") String pwd);

	public int setMemberModify(@Param("vo") MemberVO vo);

	public void setMemberPwdChangeOk(@Param("mid") String mid, @Param("pwd") String pwd);

	public int setMemberDelOk(@Param("mid") String mid);

	public MemberVO getMemberKaKaoCheck(@Param("nickName") String nickName, @Param("email") String email);

	public void setKakaoMemberInput(@Param("mid") String mid, @Param("pwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);

	public List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public List<MemberVO> getmemberDelList();

	public int getTotRecCnt();

	public void setMemberDel(@Param("vo") MemberVO vo);

}
