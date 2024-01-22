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

import com.spring.javaProjectS2.dao.GymDAO;
import com.spring.javaProjectS2.vo.GymVO;
import com.spring.javaProjectS2.vo.InterestVO;

@Service
public class GymServiceImpl implements GymService {

	@Autowired
	GymDAO gymDAO;

	@Override
	public List<GymVO> getGymList(int startIndexNo, int pageSize) {
		return gymDAO.getGymList(startIndexNo,pageSize);
	}

	@Override
	public List<GymVO> getGymSearchList(String area, String gymName) {
		return gymDAO.getGymSearchList(area,gymName);
	}

	@Override
	public GymVO getGyminfor(int idx) {
		return gymDAO.getGyminfor(idx);
	}

	@Override
	public int setGymInput(MultipartFile fName, GymVO vo) {
		int res = 0;
		// 파일 이름 중복 처리
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = vo.getGymName() + "_" + uid + "_" + oFileName;
		// 파일복사처리(서버 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장시킨다.)
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
			vo.setPhoto(sFileName);
			gymDAO.setGymInput(vo);
		}
		
		return res;
	}

	private void writeFile(MultipartFile fName, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/gym/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	@Override
	public GymVO getGymSearch(GymVO vo) {
		return gymDAO.getGymSearch(vo);
	}

	@Override
	public int setGymInterest(InterestVO vo) {
		return gymDAO.setGymInterest(vo);
	}

	@Override
	public int setGymInterestDel(InterestVO vo) {
		return gymDAO.setGymInterestDel(vo);
	}

	@Override
	public InterestVO getGymInterest(String mid, int idx) {
		return gymDAO.getGymInterest(mid,idx);
	}

	@Override
	public List<InterestVO> getGymInterestList(String mid) {
		return gymDAO.gymInterestList(mid);
	}

}
