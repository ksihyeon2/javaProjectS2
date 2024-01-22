package com.spring.javaProjectS2.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.service.AdminService;
import com.spring.javaProjectS2.service.MemberService;
import com.spring.javaProjectS2.vo.MemberVO;
import com.spring.javaProjectS2.vo.VisitVO;

@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession session) {
		
		List<MemberVO> vos = memberService.getmemberDelList();
		
		// 탈퇴신청 후 30일 지나면 자동 삭제처리
		for(MemberVO vo : vos) {
			if(vo.getDate_diff() >= -30) {
				memberService.setMemberDel(vo);
			}
		}
		
		// visit table에 오늘 날짜 DB 저장하기
		int cnt = 0;
		VisitVO v = new VisitVO();
		List<VisitVO> visitVOS = adminService.getTodayVisit();
		for(VisitVO visitVO : visitVOS) {
			if(visitVO.getDate_diff() == 0) {
				cnt = 1;
				v.setToday(visitVO.getToday());
			}
		}
		
		if(cnt != 1) {
			adminService.setToday();
		} else {
			adminService.setTodayVisitCntPlus(v.getToday().substring(0,19),"비회원");
		}
		
		if(session.getAttribute("sStep") != null) {
			session.removeAttribute("sStep");
		}
		
		return "home";
	}
	
	@RequestMapping(value="/imageUpload")
	public void imageUploadGet(MultipartFile upload,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath+oFileName));
		fos.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		fos.close();
	}
}
