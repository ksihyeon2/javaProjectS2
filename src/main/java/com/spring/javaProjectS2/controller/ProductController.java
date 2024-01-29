package com.spring.javaProjectS2.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.ProductService;
import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.ProductVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	ProductService productService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 상품 리스트 폼 띄우기
	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public String productListGet(Model model,
		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
		@RequestParam(name="part", defaultValue = "", required = false) String part,
		@RequestParam(name="search", defaultValue = "", required = false) String search,
		@RequestParam(name="searchString", defaultValue = "", required = false) String searchString) {
			
		PageVO pageVO = new PageVO();
		List<ProductVO> vos = new ArrayList<ProductVO>();
		pageVO = pageProcess.totRecCnt(pag, pageSize, "product", "", "");
		vos = productService.getHealthproduct(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		
		return "product/productList";
	}
	
	// 상품 추가 폼 띄우기
	@RequestMapping(value = "/productInput", method = RequestMethod.GET)
	public String productInputGet() {
		return "product/productInput";
	}
	
	// 상품 추가하기
	@RequestMapping(value = "productInput", method = RequestMethod.POST)
	public String productInputPost(MultipartFile fName, ProductVO vo) {
		// 중복 체크
		ProductVO productVO = productService.getProductSearch(vo.getProductName());
		
		int res = 0;
		if(productVO == null) {
			if(vo.getContent().indexOf("src=\"/") != -1) {
				productService.imgCheck(vo.getContent());
			}
			
			vo.setContent(vo.getContent().replace("/data/ckeditor", "/data/product/"));
			
			res = productService.setProductInput(fName,vo);
		}
		
		if(res != 0) {
			return "redirect:/message/productInputOK";
		} else {
			return "redirect:/message/productInputNO";
		}
	}
	
	// 멤버 선택 상품 폼 띄우기 
	@RequestMapping(value = "/healthproduct", method = RequestMethod.GET)
	public String healthproductGet(String hName) {
		 
		return "product/healthproduct";
	}
}
