package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.InterestVO;
import com.spring.javaProjectS2.vo.ModifyVO;

public interface HealthDAO {

	public HealthVO getHealthSearch(@Param("hName") String hName);

	public void setHealthInput(@Param("vo") HealthVO vo);

	public int getTotRecCnt();

	public List<HealthVO> getHealthList(@Param("part") String part);

	public int setHealthInterest(@Param("idx") int idx, @Param("mid") String mid);

	public int setHealthInterestDel(@Param("idx") int idx, @Param("mid") String mid);

	public List<InterestVO> getHealthInterestList(@Param("mid") String mid);

	public HealthVO getHealthInterestSearch(@Param("partIdx") int partIdx);

	public InterestVO getHealthInterest(@Param("mid") String mid, @Param("idx") int idx);

	public int setHealthInterestPlus(@Param("idx") int idx);

	public int setHealthInterestMinus(@Param("idx") int idx);

	public List<HealthVO> getHealthOrder(@Param("level") int level, @Param("part") String part);

	public List<HealthVO> getHealthSearchList(@Param("searchString") String searchString);

	public List<ModifyVO> getHealthMyModifyList(@Param("mid") String mid);

	public ModifyVO gethealthModifyContent(@Param("hName") String hName);

	public int setModifyDel(@Param("idx") int idx);


}
