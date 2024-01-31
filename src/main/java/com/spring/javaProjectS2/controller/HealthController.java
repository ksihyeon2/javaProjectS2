package com.spring.javaProjectS2.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.HealthService;
import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.InterestVO;

@Controller
@RequestMapping("/health")
public class HealthController {

	@Autowired
  HealthService healthService;

	@Autowired
	PageProcess pageProcess;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	// 맞춤 운동 폼 띄우기
	@RequestMapping(value = "/healthOrder", method = RequestMethod.GET)
	public String healthorderGet(HttpSession session) {
		if(session.getAttribute("sStep") == null) {
			session.setAttribute("sStep", 0);
		}
		return "health/healthOrder";
	}
	
	// 맟줌 춘동 step 1
	@ResponseBody
	@RequestMapping(value = "/healthorderStep1", method = RequestMethod.POST)
	public void healthorderStep1Post(HttpSession session) {
		session.setAttribute("sStep", 20);
	}
	
	// 맟줌 춘동 step 2
	@ResponseBody
	@RequestMapping(value = "/healthorderStep2", method = RequestMethod.POST)
	public void healthorderStep2Post(HttpSession session, String gender) {
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
	@RequestMapping(value = "/healthorderStep3", method = RequestMethod.POST)
	public void healthorderStep3Post(HttpSession session, int healthLevel) {
		int level = 0;
		String HealthStrLevel = "";
		if(healthLevel == 0 || healthLevel == 1) {
			level = 1;
		} else if(healthLevel == 2 || healthLevel == 3) {
			level = 2;
		} else if(healthLevel == 4) {
			level = 2;
			HealthStrLevel = "전문가";
		}
		session.setAttribute("sStep", 60);
		session.setAttribute("healthLevel", level);
		session.setAttribute("HealthStrLevel", HealthStrLevel);
	}
	
	// 맟줌 춘동 step 4
	@ResponseBody
	@RequestMapping(value = "/healthorderStep4", method = RequestMethod.POST)
	public void healthorderStep4Post(HttpSession session, int weight) {
		session.setAttribute("sStep", 80);
		session.setAttribute("weight", weight);
	}
	
	// 맟줌 춘동 step 5
	@RequestMapping(value = "/healthorderStep5", method = RequestMethod.GET)
	public String healthorderStep5Get(HttpSession session, String part, Model model) {
		int level = (int)session.getAttribute("healthLevel");
		
		String[] parts = part.split("/");
		List<HealthVO> vos = new ArrayList<HealthVO>();
		for(int i=0; i<parts.length; i++) {
			for(int j=0; j<1; j++) {
				List<HealthVO> healthVOS = healthService.getHealthOrder(level,parts[i]);
				for(HealthVO vo : healthVOS) {
					vos.add(vo);
				}
			}
		}
		
		model.addAttribute("vos", vos);
		return "health/healthOrderList";
	}
	
	// 운동 목록 폼 띄우기
	@RequestMapping(value = "/healthList", method = RequestMethod.GET)
	public String healthListGet(HttpSession session, Model model,
			@RequestParam(name="part", defaultValue = "", required = false) String part,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString) {
		List<HealthVO> vos = new ArrayList<HealthVO>();
		
		if(searchString.equals("")) {
			String mid = (String)session.getAttribute("sMid");
			List<InterestVO> interestVOS = healthService.getHealthInterestList(mid);
			if(part.equals("")) {
				for(InterestVO v : interestVOS) {
					HealthVO vo = healthService.getHealthInterestSearch(v.getPartIdx());
					vos.add(vo);
				}
			} else {
				vos = healthService.getHealthList(part);
			}
			model.addAttribute("interestVOS",interestVOS);
		} else {
			vos = healthService.getHealthSearchList(searchString);
			model.addAttribute("searchString", searchString);
		}
		
		model.addAttribute("vos",vos);
		model.addAttribute("part",part);
		
		return "health/healthList";
	}
	
	// 운동 추가 폼 띄우기
	@RequestMapping(value = "/healthInput", method = RequestMethod.GET)
	public String healthInputGet() {
		return "health/healthInput";
	}
	
	// 운동 추가하기
	@RequestMapping(value = "/healthInput", method = RequestMethod.POST)
	public String healthInputPost(MultipartFile fName, HealthVO vo) {
		// 중복 확인
		HealthVO healthVO = healthService.getHealthSearch(vo.getHName());
		if(healthVO == null) {
			int res = healthService.setHealthInput(fName,vo);
			
			if(res != 0) {
				return "redirect://message/healthInputOK";
			} else {
				return "redirect://message/healthInputNO";
			}
		}
		return "redirect://message/healthSearch";
	}
	
	// 선택 운동 content 폼 띄우기
	@RequestMapping(value = "/healthContent", method = RequestMethod.GET)
	public String healthContentGet(Model model, String hName, String part,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		HealthVO vo = healthService.getHealthSearch(hName);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("part",part);
		return "health/healthContent";
	}
	
	// 관심 운동 설정하기
	@ResponseBody
	@RequestMapping(value = "/healthInterest", method = RequestMethod.POST)
	public String healthInterestPost(int idx,  HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		InterestVO vo = healthService.getHealthInterest(mid,idx);
		int res = 0;
		if(vo == null) {
			res = healthService.setHealthInterest(idx,mid);
			if(res != 0) {
				res = healthService.setHealthInterestPlus(idx);
			}
		} else if (vo != null) {
			res = healthService.setHealthInterestDel(idx,mid);
			if(res != 0) {
				res = healthService.setHealthInterestMinus(idx);
			}
		}
		
		return res + "";
	}
	
	// 운동 수정 폼 띄우기
	@RequestMapping(value = "/healthInputChange", method = RequestMethod.GET)
	public String healthInputChangeGet(String hName, int pag, int pageSize, String part, Model model) {
		HealthVO vo = healthService.getHealthSearch(hName);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("part",part);
		return "health/healthInputChange";
	}
	
}
