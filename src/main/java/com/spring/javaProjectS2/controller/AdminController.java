package com.spring.javaProjectS2.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.AdminService;
import com.spring.javaProjectS2.service.BoardService;
import com.spring.javaProjectS2.service.MemberService;
import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.InquiryVO;
import com.spring.javaProjectS2.vo.InterestVO;
import com.spring.javaProjectS2.vo.MemberVO;
import com.spring.javaProjectS2.vo.ModifyVO;
import com.spring.javaProjectS2.vo.VisitVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 관리자 페이지 폼 띄우기
	@RequestMapping(value = "/adminPage", method = RequestMethod.GET)
	public String adminPageGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		List<VisitVO> visitVOS = adminService.getTodayVisit();
		
		// 방문자 수 구하기
		int cnt = 0;
		for(VisitVO visitVO : visitVOS) {
			if(visitVO.getDate_diff() == 0) {
				if(visitVO.getMember().equals("회원")) {
					model.addAttribute("memberToday", visitVO.getVisit());
				} else {
					model.addAttribute("today", visitVO.getVisit());
				}
			}
		}
		
		// 문의 대기건 수 구하기
		List<InquiryVO> inquiryVO = adminService.getInquiryStandby();
		
		// 신고 대기건 수 구하기
		int complaintSize = adminService.getComplaintSize();
		
		// 수정 요청건 수 구하기
		int modifySize = adminService.getModifySize();
		
		// 차트 분석 구하기(인기 운동 순서)
		List<HealthVO> healthVOS = adminService.getHealthInterestList();
		String[] hName = new String[healthVOS.size()];
		int[] interest = new int[healthVOS.size()];
		
		cnt = 0;
		for(HealthVO healthVO : healthVOS) {
			hName[cnt] = healthVO.getHName();
			interest[cnt] = healthVO.getInterest();
			cnt++;
		}
		
		// 공지건 수 구하기
		int boardImportant = adminService.getBoardImportant();
		
		model.addAttribute("hName",hName);
		model.addAttribute("interest",interest);
		model.addAttribute("healthVOS",healthVOS);
		model.addAttribute("complaintSize",complaintSize);
		model.addAttribute("modifySize",modifySize);
		model.addAttribute("boardImportant",boardImportant);
		model.addAttribute("vo", vo);
		return "/admin/adminPage";
	}
	
	// 회원 전체 리스트 폼 띄우기
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="delCheck", defaultValue = "", required = false) String delCheck) {
		PageVO pageVO = new PageVO();
		List<MemberVO> vos = new ArrayList<MemberVO>();
		if(search.equals("") && searchString.equals("") && delCheck.equals("")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", "", "","");
			vos = memberService.getMemberList(pageVO.getStartIndexNo(),pageSize);
		} else if(search.equals("") && !searchString.equals("") || !search.equals("")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", search, searchString,"");
			vos = adminService.getMemberSearch(pageVO.getStartIndexNo(),pageSize,search,searchString);
			model.addAttribute("search",search);
			model.addAttribute("searchString",searchString);
		} else if(!delCheck.equals("")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", "", "", delCheck);
			System.out.println("delCheck : " + delCheck);
			vos = adminService.getDelCheckSearch(pageVO.getStartIndexNo(),pageSize,delCheck);
		}
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos", vos);
		return "admin/memberList";
	}
	
	// 탈퇴 회원 리스트 폼 띄우기
	@RequestMapping(value = "/memberDelList", method = RequestMethod.GET)
	public String memberDelListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "admin", "", "","");
		
		List<MemberVO> vos = memberService.getmemberDelList();
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos", vos);
		return "admin/memberDelList";
	}
	
	// 회원 상세 정보 폼 띄우기
	@RequestMapping(value = "/memberInfor", method = RequestMethod.GET)
	public String memberInforGet(Model model, String mid,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "admin/memberInfor";
	}
	
	// 신고 리스트 폼 띄우기
	@RequestMapping(value = "/complaintList", method = RequestMethod.GET)
	public String complaintListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "", required = false) String part,
			@RequestParam(name="type", defaultValue = "", required = false) String type,
			@RequestParam(name="state", defaultValue = "", required = false) String state,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="main", defaultValue = "", required = false) String main) {
		List<ComplaintVO> vos = new ArrayList<ComplaintVO>();
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "complaint", "", "","");
		if(part.equals("") && type.equals("") && state.equals("") && searchString.equals("") && main.equals("")) {
			vos = adminService.getComplaintList(pageVO.getStartIndexNo(),pageSize);
		} else if (!part.equals("") && main.equals("")) {
			vos = adminService.getComplaintPartList(part);
		} else if (!type.equals("") && main.equals("")) {
			vos = adminService.getComplaintTypeList(type);
		} else if (!state.equals("") && main.equals("")) {
			vos = adminService.getComplaintStateList(state);
		} else if (!searchString.equals("") && main.equals("")) {
			vos = adminService.getComplaintSearchList(search,searchString);
		} else if (!main.equals("")) {
			vos = adminService.getComplaintMainList();
		}
		
		List<BoardVO> boardVOS = adminService.getBoardList(); 

		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos", vos);
		model.addAttribute("boardVOS",boardVOS);
		return "admin/complaint/complaintList";
	}
	
	// 신고물 확인하기
	@RequestMapping(value = "/complaintCheck", method = RequestMethod.GET)
	public String complaintCheckGet(int complaintidx) {
		BoardVO vo = boardService.getBoardContent(complaintidx);
		
		if(vo != null) {
			return "redirect:/message/contentOK?idx="+complaintidx;
		} else {
			return "redirect:/message/contentNO";
		}
	}
	
	// 신고 게시물 삭제처리
	@RequestMapping(value = "/complaintContentDel", method = RequestMethod.GET)
	public String complaintContentDelGet(int idx) {
		int res = boardService.complaintContentDel(idx);
		
		if(res != 0) {
			// 게시물 삭제 완료되면 complaint 상태 변경하기
			res = adminService.setComplaintStateUpdate(idx,"OK");
			return "redirect:/message/complaintContentDelOK";
		} else {
			return "redirect:/message/complaintContentDelNO?idx="+idx;
		}
	}
	
	// 신고 게시물 보류처리
	@ResponseBody
	@RequestMapping(value = "/complaintNO", method = RequestMethod.POST)
	public String complaintNOPost(int idx) {
		int res = adminService.setComplaintStateUpdate(idx,"NO");
		
		return res + "";
	}
	
	// 문의 내역 폼 띄우기
	@RequestMapping(value = "/inquiryList", method = RequestMethod.GET)
	public String inquiryListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "inquiry", "", "","");
		
		List<InquiryVO> vos = adminService.getInquiryList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		return "admin/inquiryList";
	}
	
	// 문의 답변 폼 띄우기
	@RequestMapping(value = "/admininquiryContent", method = RequestMethod.GET)
	public String admininquiryContentGet(Model model, int idx, int pag, int pageSize) {
		
		InquiryVO vo = memberService.getMemberinquiryContent(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "admin/admininquiryContent";
	}
	
	// 문의 답변하기
	@RequestMapping(value = "/admininquiryContent", method = RequestMethod.POST)
	public String admininquiryContentPost(InquiryVO vo) {
		InquiryVO inquiryVO = memberService.getMemberinquiryContent(vo.getIdx());
		
		if(inquiryVO != null) {
			adminService.setAdmininquiryContent(vo);
			return "redirect:/message/admininquiryContentOK";
		} else {
			return "redirect:/message/admininquiryContentNO";
		}
	}
	
	// 신고 사유 확인하기
	@ResponseBody
	@RequestMapping(value = "/complaintText", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String complaintTextPost(int idx) {
		ComplaintVO vo = adminService.getComplaintText(idx);
		String text = vo.getComplaintText();
		return text;
	}
	
	// 운동 수정 리스트 폼 띄우기
	@RequestMapping(value = "/healthModifyList", method = RequestMethod.GET)
	public String healthModifyListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="state", defaultValue = "", required = false) String state,
			@RequestParam(name="main", defaultValue = "", required = false) String main) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "modify","","","");
		
		List<ModifyVO> vos = new ArrayList<ModifyVO>();
		
		if(state.equals("") && main.equals("")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "modify","","","");
			vos = adminService.getHealthModifyList(pageVO.getStartIndexNo(),pageSize);
		} else if(!state.equals("") && main.equals("")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "modifyState","","",state);
			vos = adminService.getHealthModifyStateList(pageVO.getStartIndexNo(),pageSize,state);
		} else if(!main.equals("")) {
			vos = adminService.getHealthModifyMainList();
		}
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("state",state);
		model.addAttribute("vos",vos);
		
		return "admin/healthModifyList";
	}
	
	// 공지 사항 리스트 폼 띄우기
	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
	public String noticeListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="state", defaultValue = "", required = false) String state,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="main", defaultValue = "", required = false) String main){
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", "", "", "");
		List<BoardVO> vos = new ArrayList<BoardVO>();
		if(state.equals("") && searchString.equals("") && main.equals("")) {
			vos = adminService.getNoticeList(pageVO.getStartIndexNo(),pageSize);
		} else if(!state.equals("") && searchString.equals("") && main.equals("")){
				vos = adminService.getNoticeStateList(pageVO.getStartIndexNo(),pageSize,state);
		} else if((search.equals("") || !search.equals("")) && !searchString.equals("") && main.equals("")){
			System.out.println("?");
			vos = adminService.getSearchNoticeList(search,searchString);
		} else if (!main.equals("")) {
			vos = adminService.getNoticeMainList();
		}
		
		model.addAttribute("vos",vos);
		model.addAttribute("state",state);
		model.addAttribute("search",search);
		model.addAttribute("searchString",searchString);
		model.addAttribute("main",main);
		
		return "admin/noticeList";
	}
	
	
	// 공지 사항 상태 변경
	@ResponseBody
	@RequestMapping(value = "/noticeStateChange", method = RequestMethod.POST)
	public String noticeStateChangePost(int idx, String state) {
		
		int res = adminService.setNoticeStateChange(state,idx);
		return res+"";
	}
}
