package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;

public interface BoardDAO {

	public int setBoardInput(@Param("vo") BoardVO vo);

	public int getTotRecCnt();

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setReadNumPlus(@Param("idx") int idx);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public BoardVO getPreNextSearch(@Param("idx") int idx, @Param("str") String str);

	public int setBoardComplaint(@Param("vo") ComplaintVO vo);

	public ComplaintVO getBoardComplanit(@Param("complaintMid") String complaintMid, @Param("idx") int idx);

	public int setBoardContentDel(@Param("mid") String mid, @Param("idx") int idx);

	public void setBoardContentGoodCheck(@Param("idx") int idx, @Param("goodCheck") String goodCheck);
	
}
