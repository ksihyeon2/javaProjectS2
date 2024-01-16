package com.spring.javaProjectS2.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.GymService;
import com.spring.javaProjectS2.vo.GymVO;

@Controller
@RequestMapping("/gym")
public class GymController {
	
	@Autowired
	GymService gymService;
	
	@Autowired
	PageProcess pageProcess;
	
//전체 지점 폼 띄우기
	@RequestMapping(value = "/gymList", method = RequestMethod.GET)
	public String gymListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "gym", "", "");
		
		List<GymVO> vos = gymService.getGymList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		
		return "gym/gymList";
	}
	
	// 지점 검색 후 정보 모달로 띄우기
	@ResponseBody
	@RequestMapping(value = "/gmySearchList", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String gmySearchListPost(String area, String gymName) {
		List<GymVO> vos = gymService.getGymSearchList(area, gymName);
		
		if(vos == null) {
			return "";
		} else {
			return vos.toString();
		}
	}
	
	// 선택 지점 폼 띄우기
	@RequestMapping(value = "/gyminfor", method = RequestMethod.GET)
	public String gyminforGet(int idx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		GymVO vo = gymService.getGyminfor(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "gym/gyminfor";
	}
	
	@RequestMapping(value = "/gymInput", method = RequestMethod.GET)
	public String gymInputGet() {
		return "gym/gymInput";
	}
}
