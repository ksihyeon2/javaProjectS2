package com.spring.javaProjectS2.service;

import java.util.List;

import com.spring.javaProjectS2.vo.GymVO;

public interface GymService {

	public List<GymVO> getGymList(int startIndexNo, int pageSize);

	public List<GymVO> getGymSearchList(String area, String gymName);

	public GymVO getGyminfor(int idx);

}
