package com.spring.javaProjectS2.service;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberInput(MemberVO vo);

	public void setMemberUpdate(MemberVO vo);

	public MemberVO memberMidSearch(String name);

	public void setMemberImsiPwd(String mid, String pwd);

	public int setMemberModify(MemberVO vo);

	public void setMemberPwdChangeOk(String mid, String pwd);

	public int setFileUpload(MultipartFile fName, String mid);

	public int setMemberDelOk(String mid);

}
