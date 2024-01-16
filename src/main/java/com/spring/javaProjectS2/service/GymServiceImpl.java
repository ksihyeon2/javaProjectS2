package com.spring.javaProjectS2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS2.dao.GymDAO;
import com.spring.javaProjectS2.vo.GymVO;

@Service
public class GymServiceImpl implements GymService {

	@Autowired
	GymDAO gymDAO;

	@Override
	public List<GymVO> getGymList(int startIndexNo, int pageSize) {
		return gymDAO.getGymList(startIndexNo,pageSize);
	}

	@Override
	public List<GymVO> getGymSearchList(String area, String gymName) {
		return gymDAO.getGymSearchList(area,gymName);
	}

	@Override
	public GymVO getGyminfor(int idx) {
		return gymDAO.getGyminfor(idx);
	}
}
