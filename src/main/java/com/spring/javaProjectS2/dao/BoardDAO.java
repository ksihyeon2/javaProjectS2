package com.spring.javaProjectS2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.GoodcheckVO;
import com.spring.javaProjectS2.vo.ReplyVO;

public interface BoardDAO {

	public int setBoardInput(@Param("vo") BoardVO vo);

	public int getTotRecCnt();

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public void setReadNumPlus(@Param("idx") int idx);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public BoardVO getPreNextSearch(@Param("idx") int idx, @Param("str") String str);

	public int setBoardComplaint(@Param("vo") ComplaintVO vo);

	public ComplaintVO getBoardComplanit(@Param("complaintMid") String complaintMid, @Param("idx") int idx);

	//public int setBoardContentDel(@Param("mid") String mid, @Param("idx") int idx);

	public GoodcheckVO getBoardGoodCheck(@Param("idx") int idx, @Param("nickName") String nickName);

	public void setBoardContentGoodCheck(@Param("idx") int idx, @Param("goodCheck") String goodCheck);

	public void setContentGoodCheck(@Param("idx") int idx, @Param("nickName") String nickName);

	public void setContentGoodCheckDel(@Param("idx") int idx,  @Param("nickName") String nickName);

	public ReplyVO getBoardParentReplyCheck(@Param("boardIdx") int boardIdx);

	public int setBoardReplyInput(@Param("replyVO") ReplyVO replyVO);

	public List<ReplyVO> getBoardReplyList(@Param("idx") int idx);

	public void setReplyOrderUpdate(@Param("boardIdx") int boardIdx, @Param("re_order") int re_order);

	public int getBoardReplyDelete(@Param("idx") int idx, @Param("nickName") String nickName);

	public List<BoardVO> getboardDelBox(@Param("nickName") String nickName);

	//public int setBoardMyContentDel(@Param("mid") String mid, @Param("delidx") String delidx);

	public List<BoardVO> getboardMyList(@Param("mid") String mid);

	public int getBoardCnt(@Param("mid") String mid);

	public int complaintContentDel(@Param("idx") int idx);

	public List<BoardVO> getBoardSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int getTotRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public List<BoardVO> getNoticeList();

	public int setBoardContentDel(@Param("mid") String mid, @Param("idx") int idx);

	public int setBoardOpenSwChange(@Param("idx") int idx, @Param("openSw") String openSw);

	public int setBoardContentPermanentDel(@Param("mid") String mid, @Param("idx") int idx);

	public int setBoardContentDelNo(@Param("idx") int idx);


}
