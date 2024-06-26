package com.spring.javaProjectS2.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import com.spring.javaProjectS2.vo.GoodcheckVO;
import com.spring.javaProjectS2.vo.MemberVO;
import com.spring.javaProjectS2.vo.ReplyVO;

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
		  @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
		  @RequestParam(name="part", defaultValue = "", required = false) String part,
		  @RequestParam(name="search", defaultValue = "", required = false) String search,
		  @RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
		  @RequestParam(name="user", defaultValue = "", required = false) String user) { 
	  	PageVO pageVO = new PageVO();
	  	List<BoardVO> vos = new ArrayList<BoardVO>();
	  	if(search.equals("") && searchString.equals("")) {
	  		pageVO = pageProcess.totRecCnt(pag,pageSize,"board","","","");
	  		vos =  boardService.getBoardList(pageVO.getStartIndexNo(),pageSize,part);
	  		model.addAttribute("part",part);
	  	} else {
	  		pageVO = pageProcess.totRecCnt(pag, pageSize, "board", search, searchString,"");
	  		vos = boardService.getBoardSearchList(pageVO.getStartIndexNo(), pageSize, search, searchString);
	  		model.addAttribute("search",search);
	  		model.addAttribute("searchString",searchString);
	  	}
	  	
	 // 공지사항
	 		List<BoardVO> noticeVOS = boardService.getNoticeList();
	 		
	 		model.addAttribute("noticeVOS", noticeVOS);
	  	
		  model.addAttribute("pageVO", pageVO);
		  model.addAttribute("vos",vos);
		  model.addAttribute("user",user);
		  
		  return "board/boardList";
	}
	
  // 게시물 전체 리스트 창 띄우기 (검색기)
  @RequestMapping(value = "/boardAllList", method = RequestMethod.GET)
  String boardAllListGet(Model model, HttpSession session,
	  @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
	  @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
	  @RequestParam(name="part", defaultValue = "", required = false) String part,
	  @RequestParam(name="search", defaultValue = "", required = false) String search,
	  @RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
	  @RequestParam(name="user", defaultValue = "", required = false) String user) { 
  	PageVO pageVO = new PageVO();
  	List<BoardVO> vos = new ArrayList<BoardVO>();
  	if(search.equals("") && searchString.equals("")) {
  		pageVO = pageProcess.totRecCnt(pag,pageSize,"board","","","");
  		vos =  boardService.getBoardList(pageVO.getStartIndexNo(),pageSize,part);
  		model.addAttribute("part",part);
  	} else {
  		pageVO = pageProcess.totRecCnt(pag, pageSize, "board", search, searchString,"");
  		vos = boardService.getBoardSearchList(pageVO.getStartIndexNo(), pageSize, search, searchString);
  		model.addAttribute("search",search);
  		model.addAttribute("searchString",searchString);
  	}
  	
 // 공지사항
 		List<BoardVO> noticeVOS = boardService.getNoticeList();
 		
 		model.addAttribute("noticeVOS", noticeVOS);
  	
	  model.addAttribute("pageVO", pageVO);
	  model.addAttribute("vos",vos);
	  model.addAttribute("user",user);
	  
  	return "board/boardAllList";
  }
	 
	// 선택 게시물 창 띄우기
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContent(int idx, Model model, HttpSession session,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(name = "del", defaultValue = "", required = false) String del,
			@RequestParam(name = "admin", defaultValue = "", required = false) String admin,
			@RequestParam(name = "user", defaultValue = "", required = false) String user) {
		
		BoardVO complaintVO = boardService.getBoardContent(idx);
		
		if(complaintVO == null) {
			return "redirect:/message/boardDelOK";
		}else {
			String ContentIdx = (String) session.getAttribute("sContent" + idx);
			if (ContentIdx == null) {
				// 조회수 증가 불허를 위한 세션 저장
				session.setAttribute("sContent" + idx, "OK");
				boardService.setReadNumPlus(idx);
			}
			
			BoardVO vo = boardService.getBoardContent(idx);
			
			// 좋아요 여부
			String nickName = (String) session.getAttribute("sNickName");
			GoodcheckVO goodCheckVO = boardService.getBoardGoodCheck(idx, nickName);
			
			List<ReplyVO> replyVOS = boardService.getBoardReplyList(idx);
			model.addAttribute("replyVOS", replyVOS);
			
			model.addAttribute("vo", vo);
			model.addAttribute("pag", pag);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("goodCheckVO", goodCheckVO);
			model.addAttribute("mid", mid);
			model.addAttribute("del", del);
			model.addAttribute("admin", admin);
			model.addAttribute("user", user);
			
			return "board/boardContent";
		}
	}

	// 게시물 작성 창 띄우기
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet(Model model,
			@RequestParam(name = "user", defaultValue = "", required = false) String user,
			@RequestParam(name= "notice", defaultValue = "", required = false) String notice) {
		model.addAttribute("user", user);
		model.addAttribute("notice", notice);
		return "board/boardInput";
	}

	// 게시물 작성하기
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardinputPost(BoardVO vo) {
		System.out.println("vo : " + vo);
		if (vo.getPart() == "") {
			vo.setPart("기타");
		}

		if (vo.getContent().indexOf("src=\"/") != -1) {
			boardService.imgCheck(vo.getContent());
		}

		vo.setContent(vo.getContent().replace("/data/ckeditor", "/data/board/"));

		int res = boardService.setBoardInput(vo);

		if (res != 0) {
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
		if (complaintVO == null) {
			vo.setComplaintidx(idx);
			System.out.println(vo.getComplaintidx());
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
	public String boardContentDelPost(HttpSession session,
			@RequestParam(name = "idx", defaultValue = "0", required = false) int idx) {
		String mid = (String)session.getAttribute("sMid");
		
		System.out.println("idx : " + idx);
		
		BoardVO vo = boardService.getBoardContent(idx);
		
		System.out.println("vo : " + vo);
		
		int res = 0;
		if(vo.getDelCheck().equals("NO")){
			res = boardService.setBoardContentDel(mid,idx);
		} else if(vo.getDelCheck().equals("OK")) {
			res = boardService.setBoardContentPermanentDel(mid,idx);
		}
		return res + "";
	}

	// 공감 버튼
	@ResponseBody
	@RequestMapping(value = "/boardContentGoodCheck", method = RequestMethod.POST)
	public String boardContentGoodCheckPost(int idx, String goodCheck, HttpSession session) {
		String nickName = (String) session.getAttribute("sNickName");

		GoodcheckVO vo = boardService.getBoardGoodCheck(idx, nickName);

		int res = 0;
		if (vo == null && goodCheck.equals("OK")) {
			// board DB 저장
			boardService.setBoardContentGoodCheck(idx, goodCheck);
			// goodCheck DB 저장
			boardService.setContentGoodCheck(idx, nickName);
			res = 1;
		} else {
			boardService.setBoardContentGoodCheck(idx, goodCheck);
			// goodCheck DB 삭제
			boardService.setContentGoodCheckDel(idx, nickName);
			res = 1;
		}

		return res + "";
	}

	// 댓글 작성
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(ReplyVO replyVO, HttpSession session) {

		ReplyVO replyParentVO = boardService.getBoardParentReplyCheck(replyVO.getBoardIdx());

		if (replyParentVO == null) {
			replyVO.setRe_order(1);
		} else {
			replyVO.setRe_order(replyParentVO.getRe_order() + 1);
		}

		replyVO.setRe_step(0);

		int res = boardService.setBoardReplyInput(replyVO);

		return res + "";
	}

	// 답글 작성
	@ResponseBody
	@RequestMapping(value = "/boardReplyInputRe", method = RequestMethod.POST)
	public String boardReplyInputRePost(ReplyVO replyVO) {
		// 답글의 re_step을 부모의 re_step에 +1처리
		replyVO.setRe_step(replyVO.getRe_step() + 1);

		// 부모 이외의 댓글 re_order에 +1 처리
		boardService.setReplyOrderUpdate(replyVO.getBoardIdx(), replyVO.getRe_order());

		// 3. 답글의 re_order +1처리
		replyVO.setRe_order(replyVO.getRe_order() + 1);
		System.out.println("replyVO : " + replyVO.getRe_order());

		int res = boardService.setBoardReplyInput(replyVO);
		return res + "";
	}

	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/boardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(int idx, HttpSession session) {
		String nickName = (String) session.getAttribute("sNickName");

		int res = boardService.getBoardReplyDelete(idx, nickName);
		return res + "";
	}

	// 나의 게시물 폼 띄우기
	@RequestMapping(value = "/boardMyList", method = RequestMethod.GET)
	public String boardMyListGet(HttpSession session, Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		String mid = (String) session.getAttribute("sMid");
		List<BoardVO> vos = boardService.getboardMyList(mid);

		model.addAttribute("vos", vos);

		return "board/boardMyList";
	}

	// 나의 휴지통 폼 띄우기
	@RequestMapping(value = "/boardDelBox", method = RequestMethod.GET)
	public String boardDelBoxGet(HttpSession session, Model model) {
		String nickName = (String) session.getAttribute("sNickName");

		List<BoardVO> vos = boardService.getboardDelBox(nickName);
		
	// 글 삭제 휴지통 이동 후 7일 이상 됐을때 영구 삭제 처리
		List<BoardVO> delVOS = memberService.getMyBoardList(nickName);
		for(BoardVO delVO : delVOS) {
			if(delVO.getDate_diff() <= -7 && delVO.getHour_diff() >= 24) {
				memberService.setBoardDel(delVO.getIdx());
			}
		}

		model.addAttribute("vos", vos);
		return "board/boardDelBox";
	}
	
	// 공개 상태 변경하기
	@ResponseBody
	@RequestMapping(value = "/boardOpenSwChange", method = RequestMethod.POST)
	public String boardOpenSwChangePost(
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="openSw", defaultValue = "", required = false) String openSw) {
		
		int res = boardService.setBoardOpenSwChange(idx,openSw);
		
		return res + "";
	}

	// 삭제된 게시물 복구하기
	@ResponseBody
	@RequestMapping(value = "/boardContentDelNo", method = RequestMethod.POST)
	public String boardContentDelNoPost(int idx) {
		int res = boardService.setBoardContentDelNo(idx);
		return res + "";
	}
}
