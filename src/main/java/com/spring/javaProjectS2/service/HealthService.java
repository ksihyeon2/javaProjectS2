package com.spring.javaProjectS2.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.InterestVO;

public interface HealthService {

	public HealthVO getHealthSearch(String hName);

	public int setHealthInput(MultipartFile fName, HealthVO vo);

	public List<HealthVO> getHealthList(String part);

	public int setHealthInterest(int idx, String mid);

	public int setHealthInterestDel(int idx, String mid);

	public List<InterestVO> getHealthInterestList(String mid);

	public HealthVO getHealthInterestSearch(int partIdx);

	public InterestVO getHealthInterest(String mid, int idx);

}
