package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.GymVO;

public interface GymDAO {

	public List<GymVO> getGymList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public List<GymVO> getGymSearchList(@Param("area") String area, @Param("gymName") String gymName);

	public GymVO getGyminfor(@Param("idx") int idx);

}
