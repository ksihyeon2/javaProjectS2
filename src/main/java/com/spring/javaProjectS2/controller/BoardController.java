package com.spring.javaProjectS2.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.BoardService;
import com.spring.javaProjectS2.service.MemberService;
import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.MemberVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	// 게시물 리스트 창 띄우기
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"board","","");
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos",vos);
		
		return "board/boardList";
	}
	
	// 선택 게시물 창 띄우기
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContent(int idx, Model model,HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		String ContentIdx = (String)session.getAttribute("sContent"+idx);
		if(ContentIdx == null) {
			// 조회수 증가 불허를 위한 세션 저장
			session.setAttribute("sContent"+idx, "OK");
			boardService.setReadNumPlus(idx);
		} 
		
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 이전/다음 글 가져오기
		BoardVO preVO = boardService.getPreNextSearch(idx,"preVO");
		BoardVO nextVO = boardService.getPreNextSearch(idx,"nextVO");
		
		model.addAttribute("vo",vo);
		model.addAttribute("preVO",preVO);
		model.addAttribute("nextVO",nextVO);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		
		return "board/boardContent";
	}
	
	// 게시물 작성 창 띄우기
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	// 게시물 작성하기
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardinputPost(BoardVO vo) {
		if(vo.getPart() == "") {
			vo.setPart("기타");
		}
		
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
	
	// 게시물 신고하기
	@ResponseBody
	@RequestMapping(value = "/boardComplaint", method = RequestMethod.POST)
	public String boardComplaintPost(int idx, ComplaintVO vo) {
		
		ComplaintVO complaintVO = boardService.getBoardComplanit(vo.getComplaintMid(), idx);
		
		int res = 0;
		if(complaintVO == null) {
			vo.setComplaintidx(idx);
			boardService.setBoardComplaint(vo);
			res = 1;
		} else {
			res = 2;
		}
		
		return res + "";
	}
	
	// 게시물 삭제
	@ResponseBody
	@RequestMapping(value = "/boardContentDel", method = RequestMethod.POST)
	public String boardContentDelPost(String pwd, String mid, int idx) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		int res = 0;
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			res = boardService.setBoardContentDel(mid,idx);
		}
		
		return res + "";
	}
	
	// 공감 버튼
	@RequestMapping(value = "/boardContentGoodCheck", method = RequestMethod.POST)
	public String boardContentGoodCheckPost(int idx, String goodCheck, HttpSession session) {
		String good = (String)session.getAttribute("sGoodCheck"+idx);
		
		int res = 0;
		if(good == null) {
			session.setAttribute("sGoodCheck"+idx, "OK");
			boardService.setBoardContentGoodCheck(idx,goodCheck);
			res = 1;
		} else if(good != null && goodCheck.equals("NO")) {
			session.removeAttribute("sGoodCheck"+idx);
			boardService.setBoardContentGoodCheck(idx,goodCheck);
			res = 1;
		}
		return res + "";
	}
}
