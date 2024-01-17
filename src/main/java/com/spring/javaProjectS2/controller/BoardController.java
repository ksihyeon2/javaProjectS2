package com.spring.javaProjectS2.controller;

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
			@RequestParam(name="user", defaultValue = "", required = false) String user) {
		PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"board","","");
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos",vos);
		
		if(user.trim().equals("")) {
			return "board/boardList";
		} else {
			return "board/boardMyList";
		}
	}
	
	// 선택 게시물 창 띄우기
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContent(int idx, Model model,HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="del", defaultValue = "", required = false) String del,
			@RequestParam(name="admin", defaultValue = "", required = false) String admin) {
		
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
		
		// 좋아요 여부
		String nickName = (String)session.getAttribute("sNickName");
		GoodcheckVO goodCheckVO = boardService.getBoardGoodCheck(idx, nickName);
		
		List<ReplyVO> replyVOS = boardService.getBoardReplyList(idx);
		model.addAttribute("replyVOS",replyVOS);
		
		model.addAttribute("vo",vo);
		model.addAttribute("preVO",preVO);
		model.addAttribute("nextVO",nextVO);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("goodCheckVO",goodCheckVO);
		model.addAttribute("mid",mid);
		model.addAttribute("del",del);
		model.addAttribute("admin",admin);
		
		return "board/boardContent";
	}
	
	// 게시물 작성 창 띄우기
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet(Model model, 
			@RequestParam(name="user", defaultValue = "", required = false) String user) {
		model.addAttribute("user",user);
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
		System.out.println("vo : " + vo + " dix : " + idx);
		ComplaintVO complaintVO = boardService.getBoardComplanit(vo.getComplaintMid(), idx);
		System.out.println("complaintVO : " + complaintVO);
		int res = 0;
		if(complaintVO == null) {
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
	public String boardContentDelPost(String pwd, String mid,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="delidx", defaultValue = "", required = false) String delidx) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		System.out.println("pwd : " + pwd + " mid : " + mid);
		System.out.println("idx : " + idx + " delidx : " + delidx);
		int res = 0;
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			if(idx != 0) {
				res = boardService.setBoardContentDel(mid,idx);
			} else if(delidx != "") {
				res = boardService.setBoardMyContentDel(mid,delidx);
			}
		}
		
		return res + "";
	}
	
	// 공감 버튼
	@ResponseBody
	@RequestMapping(value = "/boardContentGoodCheck", method = RequestMethod.POST)
	public String boardContentGoodCheckPost(int idx, String goodCheck, HttpSession session) {
		String nickName = (String)session.getAttribute("sNickName");
		
		GoodcheckVO vo = boardService.getBoardGoodCheck(idx,nickName);
		
		int res = 0;
		if(vo == null && goodCheck.equals("OK")) {
			// board DB 저장
			boardService.setBoardContentGoodCheck(idx, goodCheck);
			// goodCheck DB 저장
			boardService.setContentGoodCheck(idx,nickName);
			res = 1;
		} else {
			boardService.setBoardContentGoodCheck(idx, goodCheck);
			// goodCheck DB 삭제
			boardService.setContentGoodCheckDel(idx,nickName);
			res = 1;
		}
		
		return res + "";
	}
	
	// 댓글 작성
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(ReplyVO replyVO,HttpSession session) {
		
		ReplyVO replyParentVO = boardService.getBoardParentReplyCheck(replyVO.getBoardIdx());
		
		if(replyParentVO == null) {
			replyVO.setRe_order(1);
		} else {
			replyVO.setRe_order(replyParentVO.getRe_order()+1);
		}
		
		replyVO.setRe_step(0);
		
		int res = boardService.setBoardReplyInput(replyVO);
		
		return res + "";
	}
	
	// 답글 작성
	@ResponseBody
	@RequestMapping(value = "/boardReplyInputRe", method = RequestMethod.POST)
	public String boardReplyInputRePost(ReplyVO replyVO) {
		System.out.println();
		// 답글의 re_step을 부모의 re_step에 +1처리
		replyVO.setRe_step(replyVO.getRe_step()+1);
		
		// 부모 이외의 댓글 re_order에 +1 처리
		boardService.setReplyOrderUpdate(replyVO.getBoardIdx(),replyVO.getRe_order());
		
		// 3. 답글의 re_order +1처리
		replyVO.setRe_order(replyVO.getRe_order()+1);
		System.out.println("replyVO : " + replyVO.getRe_order() );
		
		int res = boardService.setBoardReplyInput(replyVO);
		return res + "";
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/boardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(int idx, HttpSession session) {
		String nickName = (String)session.getAttribute("sNickName");
		
		int res = boardService.getBoardReplyDelete(idx,nickName);
		return res + "";
	}
	
	// 나의 게시물 폼 띄우기
	@RequestMapping(value = "/boardMyList", method = RequestMethod.GET)
	public String boardMyListGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		String mid = (String)session.getAttribute("sMid");
//		PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"board","","");
		
//		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(),pageSize);
		
//		model.addAttribute("pageVO", pageVO);
		
		List<BoardVO> vos = boardService.getboardMyList(mid);
		
		model.addAttribute("vos",vos);
		
		return "board/boardMyList";
	}
	
	// 나의 휴지통 폼 띄우기
	@RequestMapping(value = "/boardDelBox", method = RequestMethod.GET)
	public String boardDelBoxGet(HttpSession session, Model model) {
		String nickName = (String)session.getAttribute("sNickName");
		
		List<BoardVO> vos = boardService.getboardDelBox(nickName);
		
		model.addAttribute("vos",vos);
		return "board/boardDelBox";
	}
	
//	// 나의 게시물 수정 폼 띄우기
//	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
//	public String boardUpdateGet(Model model, int idx,
//			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
//			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
//		// 수정 할 원본 자료에 그림 파일이 존재하면, 그림 파일을 ckeditor 폴더로 복사 처리
//		BoardVO vo = boardService.getBoardContent(idx);
//		if(vo.getContent().indexOf("src=\"/") != -1) {
//			boardService.imgBackup(vo.getContent());
//		}
//		
//		model.addAttribute("vo",vo);
//		model.addAttribute("pag",pag);
//		model.addAttribute("pageSize",pageSize);
//		
//		return "board/boardUpdate";
//	}
}
