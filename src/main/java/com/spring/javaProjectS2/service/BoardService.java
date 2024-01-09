package com.spring.javaProjectS2.service;

import java.util.List;

import com.spring.javaProjectS2.vo.BoardVO;

public interface BoardService {

	public void imgCheck(String content);

	public int setBoardInput(BoardVO vo);

	public List<BoardVO> getBoardList();
	
}
