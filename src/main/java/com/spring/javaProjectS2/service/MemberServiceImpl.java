package com.spring.javaProjectS2.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.filefilter.CanWriteFileFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

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

	@Override
	public int setMemberModify(MemberVO vo) {
		return memberDAO.setMemberModify(vo);
	}

	@Override
	public void setMemberPwdChangeOk(String mid, String pwd) {
		memberDAO.setMemberPwdChangeOk(mid,pwd);
	}

	@Override
	public int setFileUpload(MultipartFile fName, String mid) {
		int res = 0;
		// 파일 이름에 대한 중복 처리(랜덤으로 문자 발생시킨 후 file 이름에 붙여서 중복 불허 처리하기)
		UUID uid = UUID.randomUUID();
		String oFilename = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid + "_" + oFilename;
		
		try {
			writeFile(fName, sFileName);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return 0;
	}

	private void writeFile(MultipartFile fName, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/member/");
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if((fName.getBytes().length) != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	@Override
	public int setMemberDelOk(String mid) {
		return memberDAO.setMemberDelOk(mid);
	}
}
