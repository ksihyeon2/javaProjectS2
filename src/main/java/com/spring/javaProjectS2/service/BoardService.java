package com.spring.javaProjectS2.service;

import java.util.List;

import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.GoodcheckVO;
import com.spring.javaProjectS2.vo.ReplyVO;

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

	public GoodcheckVO getBoardGoodCheck(int idx, String nickName);

	public void setBoardContentGoodCheck(int idx, String goodCheck);

	public void setContentGoodCheck(int idx, String nickName);

	public void setContentGoodCheckDel(int idx, String nickName);

	public ReplyVO getBoardParentReplyCheck(int boardIdx);

	public int setBoardReplyInput(ReplyVO replyVO);

	public List<ReplyVO> getBoardReplyList(int idx);

	public void setReplyOrderUpdate(int boardIdx, int re_order);

	public int getBoardReplyDelete(int idx, String nickName);

	public List<BoardVO> getBoardMyList(String mid);

}
