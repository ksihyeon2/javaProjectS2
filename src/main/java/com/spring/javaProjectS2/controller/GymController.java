package com.spring.javaProjectS2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.service.GymService;

@Controller
@RequestMapping("/gym")
public class GymController {
	
	@Autowired
	GymService gymService;
	
	@Autowired
	PageProcess pageProcess;
}
