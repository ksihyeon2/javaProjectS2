package com.spring.javaProjectS2.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS2.dao.ProductDAO;
import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDAO productDAO;

	@Override
	public List<ProductVO> getHealthproduct(int startIndexNo, int pageSize) {
		return productDAO.getHealthproduct(startIndexNo,pageSize);
	}

	@Override
	public List<HealthVO> getHealthHName() {
		return productDAO.getHealthHName();
	}

	@Override
	public ProductVO getProductSearch(String productName) {
		return productDAO.getProductSearch(productName);
	}

	@Override
	public HealthVO getHealthIdx(String hName) {
		return productDAO.getHealthIdx(hName);
	}

	@Override
	public void imgCheck(String content) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 33;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		
		boolean sw = true;
	  while(sw) {
	  	String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
	  	
	  	String origFilePath = realPath + "ckeditor/" + imgFile;
	  	String copyFilePath = realPath + "product/" + imgFile;
	  	
	  	fileCopyCheck(origFilePath,copyFilePath);
	  	
	  	if(nextImg.indexOf("src=\"/") == -1) {
	  		sw = false;
	  	} else {
	  		nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
	  	}
	  }
	}

	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes,0,cnt);
			}
			
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public int setProductInput(MultipartFile fName, ProductVO vo) {
		int res = 0;
		
	// 파일 이름 중복 처리
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = vo.getProductName() + "_" + uid + "_" + oFileName;
		
		// 파일 복사처리(서버 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장시킨다.)
		if(!oFileName.equals("")) {
			try {
				writeFile(fName,sFileName);
				res = 1;
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			res = 1;
		}
		
		if(res != 0) {
			vo.setProductPhoto(sFileName);
			productDAO.setProductInput(vo);
		}
		return res;
	}

	private void writeFile(MultipartFile fName, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/product/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}
}
