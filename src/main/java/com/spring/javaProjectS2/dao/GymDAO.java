package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.GymVO;
import com.spring.javaProjectS2.vo.InterestVO;

public interface GymDAO {

	public List<GymVO> getGymList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public List<GymVO> getGymSearchList(@Param("area") String area, @Param("gymName") String gymName);

	public GymVO getGyminfor(@Param("idx") int idx);

	public void setGymInput(@Param("vo") GymVO vo);

	public GymVO getGymSearch(@Param("vo") GymVO vo);

	public int setGymInterest(@Param("vo") InterestVO vo);

	public int setGymInterestDel(@Param("vo") InterestVO vo);

	public InterestVO getGymInterest(@Param("mid") String mid, @Param("idx") int idx);

	public int getTotRecCnt();

	public List<InterestVO> gymInterestList(@Param("mid") String mid);

}
