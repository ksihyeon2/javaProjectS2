package com.spring.javaProjectS2.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.BoardService;
import com.spring.javaProjectS2.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 게시물 리스트 창 띄우기
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		//PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"board","","");
		
		List<BoardVO> vos = boardService.getBoardList();
		
		model.addAttribute("vos",vos);
		return "board/boardList";
	}
	
	// 게시물 작성 창 띄우기
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	// 게시물 작성하기
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardinputPost(BoardVO vo) {
		if(vo.getContent().indexOf("src=\"/") != -1) {
			boardService.imgCheck(vo.getContent());
		}
		
		vo.setContent(vo.getContent().replace("/data/ckeditor", "/data/board/"));
		
		int res = boardService.setBoardInput(vo);
		
		if(res != 0) {
			return "redirect:/message/boardInputOk";
		} else {
			return "redirect:/message/boardInputNo";
		}
	}
}
