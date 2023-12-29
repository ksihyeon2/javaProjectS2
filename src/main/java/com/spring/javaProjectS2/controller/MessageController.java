package com.spring.javaProjectS2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {

	@RequestMapping(value="/message/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model, String nickName) {
		
		if(msgFlag.equals("memberInputOk")) {
			model.addAttribute("msg", "회원가입에 성공하셨습니다.");
			model.addAttribute("url", "member/memberLogin");
		}	else if(msgFlag.equals("memberInputNo")) {
			model.addAttribute("msg", "회원가입에 실패하셨습니다.");
			model.addAttribute("url", "member/memberJoin");
		} else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", nickName + "님 환영합니다.");
			model.addAttribute("url", "/");
		} else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패. 다시 확인 후 로그인해 주세요.");
			model.addAttribute("url", "member/memberLogin");
		} else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", nickName + "님 로그아웃 되셨습니다.");
			model.addAttribute("url", "/");
		}
		return "include/message";
	}
}
