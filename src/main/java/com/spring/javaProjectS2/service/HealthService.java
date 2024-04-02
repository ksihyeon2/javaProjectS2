package com.spring.javaProjectS2.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.InterestVO;
import com.spring.javaProjectS2.vo.ModifyVO;

public interface HealthService {

	public HealthVO getHealthSearch(String hName);

	public int setHealthInput(MultipartFile fName, HealthVO vo);

	public List<HealthVO> getHealthList(String part);

	public int setHealthInterest(int idx, String mid);

	public int setHealthInterestDel(int idx, String mid);

	public List<InterestVO> getHealthInterestList(String mid);

	public HealthVO getHealthInterestSearch(int partIdx);

	public InterestVO getHealthInterest(String mid, int idx);

	public int setHealthInputChange(MultipartFile fName, HealthVO vo);

	public int setHealthInterestPlus(int idx);

	public int setHealthInterestMinus(int idx);

	public List<HealthVO> getHealthOrder(int level, String part);

	public List<HealthVO> getHealthSearchList(String searchString);

	public List<ModifyVO> getHealthMyModifyList(String mid);

	public ModifyVO gethealthModifyContent(String hName);

	public int setModifyDel(int idx);


}
