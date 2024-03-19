package com.spring.javaProjectS2.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS2.dao.AdminDAO;
import com.spring.javaProjectS2.dao.BoardDAO;
import com.spring.javaProjectS2.dao.GymDAO;
import com.spring.javaProjectS2.dao.HealthDAO;
import com.spring.javaProjectS2.dao.MemberDAO;
import com.spring.javaProjectS2.dao.ProductDAO;

@Service
public class PageProcess {

		@Autowired
		BoardDAO boardDAO;
		
		@Autowired
		MemberDAO memberDAO;
		
		@Autowired
		AdminDAO adminDAO;
		
		@Autowired
		HealthDAO healthDAO;
		
		@Autowired
		GymDAO gymDAO;
		
		@Autowired
		ProductDAO productDAO;
		
		
//		board인지 guest인지 pds인지 등을 구분하기 위해 String section으로 받아와 DAO처리
//		board 안에서의 구분 (이름인지 제목인지 등)을 위해 part로 받아옴
		public PageVO totRecCnt(int pag, int pageSize, String section, String search, String searchString, String str) {
			PageVO pageVO = new PageVO();
			
			int totRecCnt = 0;
			
//			section으로 받아온 값으로 해당 카운트 구하기
			if(section.equals("board")) {
				totRecCnt = boardDAO.getTotRecCnt();
			} else if(section.equals("admin")){
				if(searchString.equals("") && str.equals("")) {
					totRecCnt = adminDAO.getTotRecCnt();
				} else if(search.equals("") && !searchString.equals("") || !search.equals("")){
					totRecCnt = adminDAO.getSearchTotRecCnt(search,searchString);
				} else if(!str.equals("")) {
					totRecCnt = adminDAO.getDelCheckTotRecCnt(str);
				}
			} else if(section.equals("complaint")) {
				totRecCnt = adminDAO.getTotRecCnt();
			} else if(search.equals("gym")) {
				if(search.equals("")) {
					totRecCnt = gymDAO.getTotRecCnt();
				}
			} else if(section.equals("inquiry")) {
				totRecCnt = memberDAO.getinquiryTotRecCnt();
			} else if(section.equals("health")) {
				totRecCnt = healthDAO.getTotRecCnt();
			} else if(section.equals("product")) {
				totRecCnt = productDAO.getTotRecCnt();
			} else if(section.equals("modify")) {
				totRecCnt = adminDAO.getModifyTotRecCnt();
			} else if(section.equals("modifyState")) {
				System.out.println("str : " + str);
				totRecCnt = adminDAO.getModifyStateTotRecCnt(str);
			} else if(section.equals("notice")) {
				totRecCnt = adminDAO.getNoticeTotRecCnt();
			}
			
			int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1 ;
			int startIndexNo = (pag - 1) * pageSize;
			int curScrStartNo = totRecCnt - startIndexNo;
			
			int blockSize = 3;
			int curBlock = (pag - 1) / blockSize;
			int lastBlock = (totPage - 1) / blockSize;
			
			pageVO.setPag(pag);
			pageVO.setPageSize(pageSize);
			pageVO.setTotRecCnt(totRecCnt);
			pageVO.setTotPage(totPage);
			pageVO.setStartIndexNo(startIndexNo);
			pageVO.setCurScrStartNo(curScrStartNo);
			pageVO.setBlockSize(blockSize);
			pageVO.setCurBlock(curBlock);
			pageVO.setLastBlock(lastBlock);
			pageVO.setPart(search);
			
			return pageVO;
		}
}
