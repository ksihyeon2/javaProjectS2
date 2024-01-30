package com.spring.javaProjectS2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS2.dao.AdminDAO;
import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.InquiryVO;
import com.spring.javaProjectS2.vo.InterestVO;
import com.spring.javaProjectS2.vo.MemberVO;
import com.spring.javaProjectS2.vo.ModifyVO;
import com.spring.javaProjectS2.vo.VisitVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public List<VisitVO> getTodayVisit() {
		return adminDAO.getTodayVisit();
	}

	@Override
	public void setToday() {
		adminDAO.setToday();
	}

	@Override
	public void setTodayVisitCntPlus(String today, String str) {
		adminDAO.setTodayVisitCntPlus(today,str);
	}

	@Override
	public void setTodayMember() {
		adminDAO.setTodayMember();
	}

	@Override
	public List<ComplaintVO> getComplaintList() {
		return adminDAO.getComplaintList();
	}

	@Override
	public int setComplaintStateUpdate(int idx, String str) {
		return adminDAO.setComplaintStateUpdate(idx, str);
	}

	@Override
	public List<BoardVO> getBoardList() {
		return adminDAO.getBoardList();
	}

	@Override
	public List<InquiryVO> getInquiryList(int startIndexNo, int pageSize) {
		return adminDAO.getInquiryList(startIndexNo,pageSize);
	}

	@Override
	public void setAdmininquiryContent(InquiryVO vo) {
		adminDAO.setAdmininquiryContent(vo);
	}

	@Override
	public List<InquiryVO> getInquiryStandby() {
		return adminDAO.getInquiryStandby();
	}

	@Override
	public ComplaintVO getComplaintText(int idx) {
		return adminDAO.getComplaintText(idx);
	}

	@Override
	public List<HealthVO> getHealthInterestList() {
		return adminDAO.getHealthInterestList();
	}

	@Override
	public List<ModifyVO> getHealthModifyList(int startIndexNo, int pageSize) {
		return adminDAO.getHealthModifyList(startIndexNo,pageSize);
	}

	@Override
	public int getComplaintSize() {
		return adminDAO.getComplaintSize();
	}

	@Override
	public int getModifySize() {
		return adminDAO.getModifySize();
	}

	@Override
	public List<MemberVO> getMemberSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return adminDAO.getMemberSearch(startIndexNo,pageSize,search,searchString);
	}

	@Override
	public List<MemberVO> getDelCheckSearch(int startIndexNo, int pageSize, String delCheck) {
		return adminDAO.getDelCheckSearch(startIndexNo,pageSize,delCheck);
	}

}
