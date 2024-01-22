package com.spring.javaProjectS2.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.vo.GymVO;
import com.spring.javaProjectS2.vo.InterestVO;

public interface GymService {

	public List<GymVO> getGymList(int startIndexNo, int pageSize);

	public List<GymVO> getGymSearchList(String area, String gymName);

	public GymVO getGyminfor(int idx);

	public int setGymInput(MultipartFile fName, GymVO vo);

	public GymVO getGymSearch(GymVO vo);

	public int setGymInterest(InterestVO vo);

	public int setGymInterestDel(InterestVO vo);

	public InterestVO getGymInterest(String mid, int idx);

	public List<InterestVO> getGymInterestList(String mid);


}
