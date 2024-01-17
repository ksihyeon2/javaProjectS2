package com.spring.javaProjectS2.service;

import java.util.List;

import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.VisitVO;

public interface AdminService {

	public List<VisitVO> getTodayVisit();

	public void setToday();

	public void setTodayVisitCntPlus(String today, String str);

	public void setTodayMember();

	public List<ComplaintVO> getComplaintList();

	public int setComplaintStateUpdate(int idx, String str);

	public List<BoardVO> getBoardList();

}
