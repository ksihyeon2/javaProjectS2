package com.spring.javaProjectS2.controller;

import java.util.ArrayList;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.GymService;
import com.spring.javaProjectS2.vo.GymVO;
import com.spring.javaProjectS2.vo.InterestVO;

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
	public String gyminforGet(int idx, Model model,HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		GymVO vo = gymService.getGyminfor(idx);
		
		String mid = (String)session.getAttribute("sMid");
		InterestVO interestVO = gymService.getGymInterest(mid,idx);
		
		model.addAttribute("interestVO", interestVO);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "gym/gyminfor";
	}
	
	// 신규 지점 등록 폼 띄우기
	@RequestMapping(value = "/gymInput", method = RequestMethod.GET)
	public String gymInputGet() {
		return "gym/gymInput";
	}
	
	// 신규 지점 등록하기
	@RequestMapping(value = "/gymInput", method = RequestMethod.POST)
	public String gymInputPost(MultipartFile fName, GymVO vo) {
		// 중복 확인
		GymVO gymVO = gymService.getGymSearch(vo);
		if(gymVO == null) {
			if(vo.getHomePage().equals("https://")) {
				vo.setHomePage("");
			}
			
			int res = gymService.setGymInput(fName,vo);
			
			if(res != 0) {
				return "redirect:/message/gymInputOK";
			} else {
				return "redirect:/message/gymInputNO";
			}
		}	else {
			return "redirect:/message/gymYes";
		}
	}
	
	// 관심 체크
	@ResponseBody
	@RequestMapping(value = "/gymInterest", method = RequestMethod.POST)
	public String gymInterestPost(HttpSession session, int idx, String interest) {
		String mid = (String)session.getAttribute("sMid");
		
		InterestVO vo = new InterestVO();
		vo.setPartIdx(idx);
		vo.setMid(mid);
		vo.setPart("gym");
		
		int res = 0;
		
		if(interest.equals("OK")){
			res = gymService.setGymInterest(vo);
		} else if (interest.equals("NO")) {
			res = gymService.setGymInterestDel(vo);
		}
		
		return res + "";
	}
	
	// 관심 목록 확인하기
	@RequestMapping(value = "/gymInterestList", method = RequestMethod.GET)
	public String gymInterestListGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		List<InterestVO> vos = gymService.getGymInterestList(mid); 
		List<GymVO> gymVOS = new ArrayList<GymVO>();
		
		for(InterestVO v : vos) {
			GymVO vo = gymService.getGyminfor(v.getPartIdx());
			gymVOS.add(vo);
		}
		
		model.addAttribute("gymVOS",gymVOS);
		
		return "gym/gymInterestList";
	}
	
	// 맞춤 운동 폼 띄우기
	@RequestMapping(value = "/gymorder", method = RequestMethod.GET)
	public String gymorderGet(HttpSession session) {
		if(session.getAttribute("sStep") == null) {
			session.setAttribute("sStep", 0);
		}
		return "gym/gymorder";
	}
	
	// 맟줌 춘동 step 1
	@ResponseBody
	@RequestMapping(value = "/gymorderStep1", method = RequestMethod.POST)
	public void gymorderStep1Post(HttpSession session) {
		session.setAttribute("sStep", 20);
	}
	
	// 맟줌 춘동 step 2
	@ResponseBody
	@RequestMapping(value = "/gymorderStep2", method = RequestMethod.POST)
	public void gymorderStep2Post(HttpSession session, String gender) {
		session.setAttribute("sStep", 40);
		
		String strGender = "";
		if(gender.equals("male")) {
			strGender = "남자";
		} else if(gender.equals("female")) {
			strGender = "여자";
		} else {
			strGender = "기타";
		}
		session.setAttribute("strGender", strGender);
	}
	
	// 맟줌 춘동 step 3
	@ResponseBody
	@RequestMapping(value = "/gymorderStep3", method = RequestMethod.POST)
	public void gymorderStep3Post(HttpSession session, int gymLevel) {
		String level = "";
		
		if(gymLevel == 0) {
			level = "입문";
		} else if (gymLevel == 1) {
			level = "초급";
		} else if(gymLevel == 2) {
			level = "중급";
		} else if(gymLevel == 3) {
			level = "고급";
		} else if (gymLevel == 4) {
			level = "전문가";
		}
		session.setAttribute("sStep", 60);
		session.setAttribute("gymLevel", level);
	}
	
	// 맟줌 춘동 step 3
	@ResponseBody
	@RequestMapping(value = "/gymorderStep4", method = RequestMethod.POST)
	public void gymorderStep4Post(HttpSession session, int weight) {
		session.setAttribute("sStep", 80);
		session.setAttribute("weight", weight);
	}
	
}
