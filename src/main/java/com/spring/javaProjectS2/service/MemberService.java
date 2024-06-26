package com.spring.javaProjectS2.service;

import java.util.List;

import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.HealthWriteVO;
import com.spring.javaProjectS2.vo.InquiryVO;
import com.spring.javaProjectS2.vo.MemberVO;
import com.spring.javaProjectS2.vo.ModifyVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberInput(MemberVO vo);

	public void setMemberUpdate(MemberVO vo);

	public MemberVO memberMidSearch(String name);

	public void setMemberImsiPwd(String mid, String pwd);

	public int setMemberModify(MemberVO vo);

	public void setMemberPwdChangeOk(String mid, String pwd);

	public int setMemberDelOk(String mid);

	public MemberVO getMemberKaKaoCheck(String nickName, String email);

	public void setKakaoMemberInput(String mid, String pwd, String nickName, String email);

	public void imgCheck(String photo);

	public List<MemberVO> getMemberList(int startIndexNo, int pageSize);

	public List<MemberVO> getmemberDelList();

	public void setMemberDel(MemberVO vo);

	public int setMemberinquiryInput(InquiryVO vo);

	public List<InquiryVO> getMemberInquiryList(int startIndexNo, int pageSize, String mid);

	public InquiryVO getMemberinquiryContent(int idx);

	public int setmemberinquiryDel(int idx);

	public ModifyVO getHealthModify(String hName, String requestMid, String modifyPart);

	public int setHealthModify(ModifyVO vo);

	public List<HealthWriteVO> getHealthWriteList(String mid);

	public int setHealthWrite(HealthWriteVO vo);

	public List<HealthWriteVO> getHealthWriteSearchList(String mid);

	public int setHealthModifyChange(String modifyText, String modifyMid);

	public List<BoardVO> getMyBoardList(String nickName);

	public void setBoardDel(int idx);

	public List<ComplaintVO> getComplaintList(String mid);


}
