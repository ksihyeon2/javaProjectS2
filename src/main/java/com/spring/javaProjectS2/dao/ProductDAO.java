package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.ProductVO;

public interface ProductDAO {

	public int getTotRecCnt();

	public List<ProductVO> getHealthproduct(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public List<HealthVO> getHealthHName();

	public ProductVO getProductSearch(@Param("productName") String productName);

	public HealthVO getHealthIdx(@Param("hName") String hName);

	public void setProductInput(@Param("vo") ProductVO vo);

}
