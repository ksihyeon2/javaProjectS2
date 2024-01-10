package com.spring.javaProjectS2.service;

import java.util.List;

import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;

public interface BoardService {

	public void imgCheck(String content);

	public int setBoardInput(BoardVO vo);

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize);

	public void setReadNumPlus(int idx);

	public BoardVO getBoardContent(int idx);

	public BoardVO getPreNextSearch(int idx, String str);

	public int setBoardComplaint(ComplaintVO vo);

	public ComplaintVO getBoardComplanit(String complaintMid, int idx);

	public int setBoardContentDel(String mid, int idx);

	public void setBoardContentGoodCheck(int idx,String goodCheck);

}
