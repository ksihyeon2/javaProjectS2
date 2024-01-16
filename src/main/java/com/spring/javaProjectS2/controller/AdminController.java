package com.spring.javaProjectS2.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.AdminService;
import com.spring.javaProjectS2.service.MemberService;
import com.spring.javaProjectS2.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/adminPage", method = RequestMethod.GET)
	public String adminPageGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		return "/admin/adminPage";
	}
	
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", "", "");
		
		List<MemberVO> vos = memberService.getMemberList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos", vos);
		return "/admin/memberList";
	}
	
	@RequestMapping(value = "/memberDelList", method = RequestMethod.GET)
	public String memberDelListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", "", "");
		
		List<MemberVO> vos = memberService.getmemberDelList();
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos", vos);
		return "/admin/memberDelList";
	}
}
