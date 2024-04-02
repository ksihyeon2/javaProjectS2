package com.spring.javaProjectS2.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaProjectS2.dao.BoardDAO;
import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.GoodcheckVO;
import com.spring.javaProjectS2.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	@Override
	public void imgCheck(String content) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 33;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		
		boolean sw = true;
	  while(sw) {
	  	String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
	  	
	  	String origFilePath = realPath + "ckeditor/" + imgFile;
	  	String copyFilePath = realPath + "board/" + imgFile;
	  	
	  	fileCopyCheck(origFilePath,copyFilePath);
	  	
	  	if(nextImg.indexOf("src=\"/") == -1) {
	  		sw = false;
	  	} else {
	  		nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
	  	}
	  }
	}

	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes,0,cnt);
			}
			
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, String part) {
		return boardDAO.getBoardList(startIndexNo,pageSize,part);
	}

	@Override
	public void setReadNumPlus(int idx) {
		boardDAO.setReadNumPlus(idx);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public BoardVO getPreNextSearch(int idx, String str) {
		return boardDAO.getPreNextSearch(idx,str);
	}

	@Override
	public int setBoardComplaint(ComplaintVO vo) {
		return boardDAO.setBoardComplaint(vo);
	}

	@Override
	public ComplaintVO getBoardComplanit(String complaintMid, int idx) {
		return boardDAO.getBoardComplanit(complaintMid,idx);
	}
//
//	@Override
//	public int setBoardContentDel(String mid, int idx) {
//		return boardDAO.setBoardContentDel(mid,idx);
//	}

	@Override
	public GoodcheckVO getBoardGoodCheck(int idx, String nickName) {
		return boardDAO.getBoardGoodCheck(idx,nickName);
	}

	@Override
	public void setBoardContentGoodCheck(int idx, String goodCheck) {
		boardDAO.setBoardContentGoodCheck(idx,goodCheck);
	}

	@Override
	public void setContentGoodCheck(int idx, String nickName) {
		boardDAO.setContentGoodCheck(idx,nickName);
	}

	@Override
	public void setContentGoodCheckDel(int idx, String nickName) {
		boardDAO.setContentGoodCheckDel(idx,nickName);
	}

	@Override
	public ReplyVO getBoardParentReplyCheck(int boardIdx) {
		return boardDAO.getBoardParentReplyCheck(boardIdx);
	}

	@Override
	public int setBoardReplyInput(ReplyVO replyVO) {
		return boardDAO.setBoardReplyInput(replyVO);
	}

	@Override
	public List<ReplyVO> getBoardReplyList(int idx) {
		return boardDAO.getBoardReplyList(idx);
	}

	@Override
	public void setReplyOrderUpdate(int boardIdx, int re_order) {
		boardDAO.setReplyOrderUpdate(boardIdx,re_order);
	}

	@Override
	public int getBoardReplyDelete(int idx, String nickName) {
		return boardDAO.getBoardReplyDelete(idx,nickName);
	}

	@Override
	public List<BoardVO> getboardDelBox(String nickName) {
		return boardDAO.getboardDelBox(nickName);
	}

//	@Override
//	public int setBoardMyContentDel(String mid, String delidx) {
//		return boardDAO.setBoardMyContentDel(mid,delidx);
//	}

	@Override
	public List<BoardVO> getboardMyList(String mid) {
		return boardDAO.getboardMyList(mid);
	}

	@Override
	public int getBoardCnt(String mid) {
		return boardDAO.getBoardCnt(mid);
	}

	@Override
	public int complaintContentDel(int idx) {
		return boardDAO.complaintContentDel(idx);
	}

	@Override
	public List<BoardVO> getBoardSearchList(int startIndexNo, int pageSize, String search, String searchString) {
		return boardDAO.getBoardSearchList(startIndexNo,pageSize,search,searchString);
	}

	@Override
	public List<BoardVO> getNoticeList() {
		return boardDAO.getNoticeList();
	}

	@Override
	public int setBoardContentDel(String mid, int idx) {
		return boardDAO.setBoardContentDel(mid,idx);
	}

	@Override
	public int setBoardOpenSwChange(int idx, String openSw) {
		return boardDAO.setBoardOpenSwChange(idx,openSw);
	}

	@Override
	public int setBoardContentPermanentDel(String mid, int idx) {
		return boardDAO.setBoardContentPermanentDel(mid,idx);
	}

	@Override
	public int setBoardContentDelNo(int idx) {
		return boardDAO.setBoardContentDelNo(idx);
	}


}
