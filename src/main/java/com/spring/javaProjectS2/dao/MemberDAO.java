package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.HealthWriteVO;
import com.spring.javaProjectS2.vo.InquiryVO;
import com.spring.javaProjectS2.vo.MemberVO;
import com.spring.javaProjectS2.vo.ModifyVO;

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

	public int setMemberinquiryInput(@Param("vo") InquiryVO vo);

	public int getinquiryTotRecCnt();

	public List<InquiryVO> getMemberInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public InquiryVO getMemberinquiryContent(@Param("idx") int idx);

	public int setmemberinquiryDel(@Param("idx") int idx);

	public ModifyVO getHealthModify(@Param("hName") String hName, @Param("requestMid") String requestMid, @Param("modifyPart") String modifyPart);

	public int setHealthModify(@Param("vo") ModifyVO vo);

	public List<HealthWriteVO> getHealthWriteList(@Param("mid") String mid);

	public int setHealthWrite(@Param("vo") HealthWriteVO vo);

	public List<HealthWriteVO> getHealthWriteSearchList(@Param("mid") String mid);

}
