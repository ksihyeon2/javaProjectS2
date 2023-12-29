package com.spring.javaProjectS2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS2.dao.GymDAO;

@Service
public class GymServiceImpl implements GymService {

	@Autowired
	GymDAO gymDAO;
}
