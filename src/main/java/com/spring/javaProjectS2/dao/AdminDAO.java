package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.InquiryVO;
import com.spring.javaProjectS2.vo.VisitVO;

public interface AdminDAO {

	public List<VisitVO> getTodayVisit();

	public void setToday();

	public void setTodayVisitCntPlus(@Param("today") String today, @Param("str") String str);

	public void setTodayMember();

	public List<ComplaintVO> getComplaintList();

	public int getTotRecCnt();

	public int setComplaintStateUpdate(@Param("idx") int idx, @Param("str") String str);

	public List<BoardVO> getBoardList();

	public List<InquiryVO> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setAdmininquiryContent(@Param("vo") InquiryVO vo);

	public List<InquiryVO> getInquiryStandby();

	public ComplaintVO getComplaintText(@Param("idx") int idx);

}