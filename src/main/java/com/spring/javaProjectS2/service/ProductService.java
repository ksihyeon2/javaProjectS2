package com.spring.javaProjectS2.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.ProductVO;

public interface ProductService {

	public List<ProductVO> getHealthproduct(int startIndexNo, int pageSize);

	public List<HealthVO> getHealthHName();

	public ProductVO getProductSearch(String productName);

	public HealthVO getHealthIdx(String hName);

	public void imgCheck(String content);

	public int setProductInput(MultipartFile fName, ProductVO vo);

}
