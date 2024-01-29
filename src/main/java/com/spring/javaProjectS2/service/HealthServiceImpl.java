package com.spring.javaProjectS2.service;

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

import com.spring.javaProjectS2.dao.HealthDAO;
import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.InterestVO;

@Service
public class HealthServiceImpl implements HealthService {

	@Autowired
	HealthDAO healthDAO;

	@Override
	public HealthVO getHealthSearch(String hName) {
		return healthDAO.getHealthSearch(hName);
	}

	@Override
	public int setHealthInput(MultipartFile fName, HealthVO vo) {
		int res = 0;
		
		// 파일 이름 중복 처리
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = vo.getHName() + "_" + uid + "_" + oFileName;
		
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
			if(oFileName.equals("")) {
				vo.setPhoto("");
			} else {
				vo.setPhoto(sFileName);
			}
			healthDAO.setHealthInput(vo);
		}
		return res;
	}

	private void writeFile(MultipartFile fName, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/health/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	@Override
	public List<HealthVO> getHealthList(String part) {
		return healthDAO.getHealthList(part);
	}

	@Override
	public int setHealthInterest(int idx, String mid) {
		return healthDAO.setHealthInterest(idx,mid);
	}

	@Override
	public int setHealthInterestDel(int idx, String mid) {
		return healthDAO.setHealthInterestDel(idx,mid);
	}

	@Override
	public List<InterestVO> getHealthInterestList(String mid) {
		return healthDAO.getHealthInterestList(mid);
	}

	@Override
	public HealthVO getHealthInterestSearch(int partIdx) {
		return healthDAO.getHealthInterestSearch(partIdx);
	}

	@Override
	public InterestVO getHealthInterest(String mid, int idx) {
		return healthDAO.getHealthInterest(mid,idx);
	}

	@Override
	public int setHealthInputChange(MultipartFile fName, HealthVO vo) {
		int res = 0;
		
		// 파일 이름 중복 처리
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = vo.getHName() + "_" + uid + "_" + oFileName;
		
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
			if(oFileName.equals("")) {
				vo.setPhoto("");
			} else {
				vo.setPhoto(sFileName);
			}
			healthDAO.setHealthInput(vo);
		}
		return res;
	}

	@Override
	public int setHealthInterestPlus(int idx) {
		return healthDAO.setHealthInterestPlus(idx);
	}

	@Override
	public int setHealthInterestMinus(int idx) {
		return healthDAO.setHealthInterestMinus(idx);
	}

	@Override
	public List<HealthVO> getHealthOrder(int level, String part) {
		return healthDAO.getHealthOrder(level,part);
	}
}
