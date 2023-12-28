package com.spring.javaProjectS2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {

	@RequestMapping(value="/message/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model) {
		
		if(msgFlag.equals("memberInputOk")) {
			model.addAttribute("msg", "회원가입에 성공하셨습니다.");
			model.addAttribute("url", "member/memberLogin");
		}	else if(msgFlag.equals("memberInputNo")) {
			model.addAttribute("msg", "회원가입에 실패하셨습니다.");
			model.addAttribute("url", "member/memberJoin");
		}
		return "include/message";
	}
}
