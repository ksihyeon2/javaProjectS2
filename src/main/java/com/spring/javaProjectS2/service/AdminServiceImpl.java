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
	public List<ComplaintVO> getComplaintList(int startIndexNo, int pageSize) {
		return adminDAO.getComplaintList(startIndexNo,pageSize);
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
	public int getInquiryStandby() {
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

	@Override
	public List<ComplaintVO> getComplaintPartList(String part) {
		return adminDAO.getComplaintPartList(part);
	}

	@Override
	public List<ComplaintVO> getComplaintTypeList(String type) {
		return adminDAO.getComplaintTypeList(type);
	}

	@Override
	public List<ComplaintVO> getComplaintStateList(String state) {
		return adminDAO.getComplaintStateList(state);
	}

	@Override
	public List<ComplaintVO> getComplaintSearchList(String search, String searchString) {
		return adminDAO.getComplaintSearchList(search,searchString);
	}

	@Override
	public List<ModifyVO> getHealthModifyStateList(int startIndexNo, int pageSize, String state) {
		return adminDAO.getHealthModifyStateList(startIndexNo,pageSize,state);
	}

	@Override
	public int getBoardImportant() {
		return adminDAO.getBoardImportant();
	}

	@Override
	public List<BoardVO> getNoticeList(int startIndexNo, int pageSize) {
		return adminDAO.getNoticeList(startIndexNo,pageSize);
	}

	@Override
	public int setNoticeStateChange(String state, int idx) {
		return adminDAO.setNoticeStateChange(state,idx);
	}

	@Override
	public List<BoardVO> getNoticeStateList(int startIndexNo, int pageSize, String state) {
		return adminDAO.getNoticeStateList(startIndexNo,pageSize,state);
	}

	@Override
	public List<BoardVO> getSearchNoticeList(String search, String searchString) {
		return adminDAO.getSearchNoticeList(search,searchString);
	}

	@Override
	public List<BoardVO> getNoticeMainList() {
		return adminDAO.getNoticeMainList();
	}

	@Override
	public List<ModifyVO> getHealthModifyMainList() {
		return adminDAO.getHealthModifyMainList();
	}

	@Override
	public List<ComplaintVO> getComplaintMainList() {
		return adminDAO.getComplaintMainList();
	}

	@Override
	public List<InquiryVO> getInquiryMianList() {
		return adminDAO.getInquiryMianList();
	}

}
