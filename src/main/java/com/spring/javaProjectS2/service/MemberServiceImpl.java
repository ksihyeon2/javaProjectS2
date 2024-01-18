package com.spring.javaProjectS2.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaProjectS2.dao.MemberDAO;
import com.spring.javaProjectS2.vo.InquiryVO;
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

	@Override
	public int setMemberModify(MemberVO vo) {
		return memberDAO.setMemberModify(vo);
	}

	@Override
	public void setMemberPwdChangeOk(String mid, String pwd) {
		memberDAO.setMemberPwdChangeOk(mid,pwd);
	}

	@Override
	public int setMemberDelOk(String mid) {
		return memberDAO.setMemberDelOk(mid);
	}

	@Override
	public MemberVO getMemberKaKaoCheck(String nickName, String email) {
		return memberDAO.getMemberKaKaoCheck(nickName,email);
	}

	@Override
	public void setKakaoMemberInput(String mid, String pwd, String nickName, String email) {
		memberDAO.setKakaoMemberInput(mid,pwd,nickName,email);
	}

	@Override
	public void imgCheck(String photo) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/member");
		// 수정
	}

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize) {
		return memberDAO.getMemberList(startIndexNo,pageSize);
	}

	@Override
	public List<MemberVO> getmemberDelList() {
		return memberDAO.getmemberDelList();
	}

	@Override
	public void setMemberDel(MemberVO vo) {
		memberDAO.setMemberDel(vo);
	}

	@Override
	public int setMemberinquiryInput(InquiryVO vo) {
		return memberDAO.setMemberinquiryInput(vo);
	}

	@Override
	public List<InquiryVO> getMemberInquiryList(int startIndexNo, int pageSize, String mid) {
		return memberDAO.getMemberInquiryList(startIndexNo,pageSize,mid);
	}

	@Override
	public InquiryVO getMemberinquiryContent(int idx) {
		return memberDAO.getMemberinquiryContent(idx);
	}

	@Override
	public int setmemberinquiryDel(int idx) {
		return memberDAO.setmemberinquiryDel(idx);
	}

}
