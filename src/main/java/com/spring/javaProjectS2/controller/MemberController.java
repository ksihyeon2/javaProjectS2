package com.spring.javaProjectS2.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
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
	public String memberLoginGet() {
		return "member/memberLogin";
	}
	
	// 로그인
	@RequestMapping(value = "/memberLoing", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required = false) String idSave) {
		return "member/memberMain";
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
		System.out.println("vo : " + vo);
		int res = memberService.setMemberInput(vo);
		System.out.println("res : " + res);
		if(res != 0) {
			return "redirect:/message/memberInputOk";
		} else {
			return "redirect:/message/memberInputNo";
		}
	}
}
