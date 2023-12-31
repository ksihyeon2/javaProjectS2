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
		}	else if(msgFlag.equals("memberPwdChange")) {
			model.addAttribute("msg", nickName + "님 비밀번호를 변경해 주세요.");
			model.addAttribute("url", "member/memberPwdChange?sw=1"); // 비밀번호 변경창으로 이동 수정
		} else if(msgFlag.equals("memberModifyPwdNo")) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "member/memberPage"); 
		}	else if(msgFlag.equals("memberModifyOk")) {
			model.addAttribute("msg", "회원 정보를 수정하셨습니다.");
			model.addAttribute("url", "member/memberPage"); 
		}	else if(msgFlag.equals("memberModifyNo")) {
			model.addAttribute("msg", "회원 정보 수정에 실패하셨습니다.");
			model.addAttribute("url", "member/memberModify"); 
		} else if(msgFlag.equals("memberPwdChangeOk")) {
			model.addAttribute("msg", "비밀번호가 변경되었습니다.");
			model.addAttribute("url", "member/memberPage"); 
		} else if(msgFlag.equals("memberPwdChangeNo")) {
			model.addAttribute("msg", "비밀번호 변경에 실패하셨습니다.");
			model.addAttribute("url", "member/memberpwdChange"); 
		}	else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "프로필 사진을 변경하였습니다.");
			model.addAttribute("url", "member/memberModify"); 
		} else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "프로필 사진 변경에 실패하였습니다.");
			model.addAttribute("url", "member/memberModify"); 
		} else if(msgFlag.equals("memberDel")) {
			model.addAttribute("msg", "");
			model.addAttribute("url", "/"); 
		} else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시물이 작성되었습니다.");
			model.addAttribute("url", "board/boardList"); 
		} else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시물 작성에 실패하셨습니다. \n다시 시도해 주세요.");
			model.addAttribute("url", "board/boardInput"); 
		}
		return "include/message";
	}
}
