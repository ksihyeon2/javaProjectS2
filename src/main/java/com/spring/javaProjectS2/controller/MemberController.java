package com.spring.javaProjectS2.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS2.service.MemberService;
import com.spring.javaProjectS2.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	// 로그인 폼 띄우기
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	// 로그인
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required = false) String idSave) {
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())){
			// 세션 처리
			String strLevel = "";
			if(vo.getLevel() == 0) {
				strLevel = "관리자";
			} else if(vo.getLevel() == 1) {
				strLevel = "우수회원";
			} else if(vo.getLevel() == 2) {
				strLevel = "정회원";
			} else if(vo.getLevel() == 3) {
				strLevel = "준회원";
			}
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			// 쿠키저장/삭제
			
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				//cookieMid.setPath("/");
				cookieMid.setMaxAge(60*60*24*7);
				response.addCookie(cookieMid);
			}	else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			model.addAttribute("nickName", vo.getNickName());
			return "redirect:/message/memberLoginOk";
		} else {
			return "redirect:/message/memberLoginNo";
		}
		
	}
	
	// 로그아웃
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session, Model model) {
		String nickName = (String) session.getAttribute("sNickName");
		session.invalidate();
		
		model.addAttribute("nickName", nickName);
		
		return "redirect:/message/memberLogout";
	}
	
	// 회원가입 폼 띄우기
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	// 회원가입 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		int res;
		if(vo != null) {
			res = 1;  // 아이디 중복
		} else {
			res = 0;  // 아이디 가능
		}
		return res + "";
	}
	
	// 회원가입 닉네임 중복 체크
	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		MemberVO vo = memberService.getMemberNickCheck(nickName);
		int res;
		if(vo != null) {
			res = 1;  // 닉네임 중복
		} else {
			res = 0;  // 닉네임 가능
		}
		return res + "";
	}
	
	// 회원가입
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemberInput(vo);
		
		if(res != 0) {
			return "redirect:/message/memberInputOk";
		} else {
			return "redirect:/message/memberInputNo";
		}
	}
	
	// 아이디, 비밀번호 찾기 폼
	@RequestMapping(value = "/memberFind", method = RequestMethod.GET)
	public String memberFindGet() {
		return "/member/memberFind";
	}
	
	// 마이페이지
	@RequestMapping(value = "/memberPage", method = RequestMethod.GET)
	public String memberPageGet() {
		return "member/memberPage";
	}
	
}
