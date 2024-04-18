package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.InquiryVO;
import com.spring.javaProjectS2.vo.InterestVO;
import com.spring.javaProjectS2.vo.MemberVO;
import com.spring.javaProjectS2.vo.ModifyVO;
import com.spring.javaProjectS2.vo.VisitVO;

public interface AdminDAO {

	public List<VisitVO> getTodayVisit();

	public void setToday();

	public void setTodayVisitCntPlus(@Param("today") String today, @Param("str") String str);

	public void setTodayMember();

	public List<ComplaintVO> getComplaintList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int getTotRecCnt();

	public int setComplaintStateUpdate(@Param("idx") int idx, @Param("str") String str);

	public List<BoardVO> getBoardList();

	public List<InquiryVO> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setAdmininquiryContent(@Param("vo") InquiryVO vo);

	public int getInquiryStandby();

	public ComplaintVO getComplaintText(@Param("idx") int idx);

	public List<HealthVO> getHealthInterestList();

	public int getModifyTotRecCnt();

	public List<ModifyVO> getHealthModifyList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int getComplaintSize();

	public int getModifySize();

	public int getSearchTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);

	public List<MemberVO> getMemberSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int getDelCheckTotRecCnt(@Param("delCheck") String delCheck);

	public List<MemberVO> getDelCheckSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("delCheck") String delCheck);

	public List<ComplaintVO> getComplaintPartList(@Param("part") String part);

	public List<ComplaintVO> getComplaintTypeList(@Param("type") String type);

	public List<ComplaintVO> getComplaintStateList(@Param("state") String state);

	public List<ComplaintVO> getComplaintSearchList(@Param("search") String search, @Param("searchString") String searchString);

	public int getModifyStateTotRecCnt(@Param("state") String state);

	public List<ModifyVO> getHealthModifyStateList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("state") String state);

	public int getBoardImportant();

	public int getNoticeTotRecCnt();

	public List<BoardVO> getNoticeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setNoticeStateChange(@Param("state") String state, @Param("idx") int idx);

	public List<BoardVO> getNoticeStateList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("state") String state);

	public List<BoardVO> getSearchNoticeList(@Param("search") String search, @Param("searchString") String searchString);

	public List<BoardVO> getNoticeMainList();

	public List<ModifyVO> getHealthModifyMainList();

	public List<ComplaintVO> getComplaintMainList();

	public List<InquiryVO> getInquiryMianList();

}
