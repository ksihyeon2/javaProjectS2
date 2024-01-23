package com.spring.javaProjectS2.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.service.HealthService;

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
		String level = "";
		
		if(healthLevel == 0) {
			level = "입문";
		} else if (healthLevel == 1) {
			level = "초급";
		} else if(healthLevel == 2) {
			level = "중급";
		} else if(healthLevel == 3) {
			level = "고급";
		} else if (healthLevel == 4) {
			level = "전문가";
		}
		session.setAttribute("sStep", 60);
		session.setAttribute("healthLevel", level);
	}
	
	// 맟줌 춘동 step 4
	@ResponseBody
	@RequestMapping(value = "/healthorderStep4", method = RequestMethod.POST)
	public void healthorderStep4Post(HttpSession session, int weight) {
		session.setAttribute("sStep", 80);
		session.setAttribute("weight", weight);
	}
	
	// 맟줌 춘동 step 5
	@ResponseBody
	@RequestMapping(value = "/healthorderStep5", method = RequestMethod.POST)
	public void healthorderStep5Post(HttpSession session, String part) {
		
	}
	
	// 운동 목록 폼 띄우기
	@RequestMapping(value = "/healthList", method = RequestMethod.GET)
	public String healthListGet(HttpSession session, Model model) {
		return "health/healthList";
	}
	
	// 운동 추가 폼 띄우기
	@RequestMapping(value = "/healthInput", method = RequestMethod.GET)
	public String healthInputGet() {
		return "health/healthInput";
	}
}
