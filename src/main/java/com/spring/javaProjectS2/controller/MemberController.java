package com.spring.javaProjectS2.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaProjectS2.pagination.PageProcess;
import com.spring.javaProjectS2.pagination.PageVO;
import com.spring.javaProjectS2.service.AdminService;
import com.spring.javaProjectS2.service.BoardService;
import com.spring.javaProjectS2.service.MemberService;
import com.spring.javaProjectS2.vo.BoardVO;
import com.spring.javaProjectS2.vo.ComplaintVO;
import com.spring.javaProjectS2.vo.HealthVO;
import com.spring.javaProjectS2.vo.HealthWriteVO;
import com.spring.javaProjectS2.vo.InquiryVO;
import com.spring.javaProjectS2.vo.MemberVO;
import com.spring.javaProjectS2.vo.ModifyVO;
import com.spring.javaProjectS2.vo.VisitVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 로그인 폼 띄우기
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	// 로그인
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required = false) String idSave) {
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())){
			// 세션 처리
			String strLevel = "";
			if(vo.getLevel() == 0) {
				strLevel = "관리자";
			} else if(vo.getLevel() == 1) {
				strLevel = "우수회원";
			} else if(vo.getLevel() == 2) {
				strLevel = "정회원";
			} else if(vo.getLevel() == 3) {
				strLevel = "준회원";
			}
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			// 쿠키저장/삭제
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setMaxAge(60*60*24*7);
				response.addCookie(cookieMid);
			}	else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			model.addAttribute("nickName", vo.getNickName());
			
			// 등업 기준 : 일자 방문횟수 10번 이상 등업, 포인트 1000포인트 누적
			if(vo.getLevel() > 0 && vo.getLevel() < 4) {
				if(vo.getTotalCnt() / 10 != 0 && vo.getTotalCnt() % 10 == 0) {
					vo.setLevel(vo.getLevel() - 1);
					vo.setPoint(vo.getPoint() + 1000);
				}
			}
			
			// 하루 방문 횟수 증가
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strToday = sdf.format(today);
			
			if(strToday.equals(vo.getLastDate().substring(0,10))) {
				// 오늘 재방문
				vo.setTodayCnt(vo.getTodayCnt()+1);
			}	else {
				// 처음 처음 방문
				vo.setTodayCnt(1);
			}
			
			// 일자별 방문 횟수 증가 : 하루 최초 한 번만 증가 가능
			if(!strToday.equals(vo.getLastDate().substring(0,10))) {
				vo.setTotalCnt(vo.getTotalCnt()+1);
			}
			
			// DB 저장
			memberService.setMemberUpdate(vo);
			
			// 홈페이지 방문 cnt 증가(관리자 화면에서 사용)
			int cnt = 0;
			VisitVO v = new VisitVO();
			List<VisitVO> visitVOS = adminService.getTodayVisit();
			for(VisitVO visitVO : visitVOS) {
				if(visitVO.getDate_diff() == 0 && visitVO.getMember().equals("회원")) {
					cnt = 1;
					v.setToday(visitVO.getToday());
				}
			}
			
			if(cnt != 1) {
				adminService.setTodayMember();
			} else if(cnt == 1) {
				adminService.setTodayVisitCntPlus(v.getToday().substring(0,19),"회원");
			}
			
			if(session.getAttribute("imsiPwd") != null) {
				return "redirect:/message/memberPwdChange";
			} else {
				return "redirect:/message/memberLoginOk";
			}
		} else {
			return "redirect:/message/memberLoginNo";
		}
		
	}
	
	// 로그아웃
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session, Model model,
			@RequestParam(name="del", defaultValue = "", required = false) String del) {
		String nickName = (String) session.getAttribute("sNickName");
		session.invalidate();
		
		model.addAttribute("nickName", nickName);
		
		if(del.equals("ok")) {
			return "redirect:/message/memberDel";
		} else {
			return "redirect:/message/memberLogout";
		}
	}
	
	// 회원가입 폼 띄우기
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	// 회원가입 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		System.out.println("vo : " + vo);
		int res;
		if(vo != null) {
			res = 1;  // 아이디 중복
		} else {
			res = 0;  // 아이디 가능
		}
		return res + "";
	}
	
	// 회원가입 닉네임 중복 체크
	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		MemberVO vo = memberService.getMemberNickCheck(nickName);
		int res;
		if(vo != null) {
			res = 1;  // 닉네임 중복
		} else {
			res = 0;  // 닉네임 가능
		}
		return res + "";
	}
	
	// 회원가입
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int photoIdx = (int)(Math.random()*5)+1;
		String photo = "noimage" + photoIdx + ".jpg";
		
		vo.setPhoto(photo);
		
		int res = memberService.setMemberInput(vo);
		
		if(res != 0) {
			return "redirect:/message/memberInputOk";
		} else {
			return "redirect:/message/memberInputNo";
		}
	}
	
	// 아이디, 비밀번호 찾기 폼
	@RequestMapping(value = "/memberFind", method = RequestMethod.GET)
	public String memberFindGet() {
		return "member/memberFind";
	}
	
	// 아이디 찾기
	@ResponseBody
	@RequestMapping(value = "/memberMidSearch", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String memberMidSearchPost(
			@RequestParam(name = "name", defaultValue = "", required = false) String name,
			@RequestParam(name = "email", defaultValue = "", required = false)String email) {
		
		MemberVO vo = memberService.memberMidSearch(email);
		
		String str = "";
		if(vo != null) {
			if(vo.getEmail().equals(email) && vo.getName().equals(name)) {
				str = vo.getMid() + "/" + vo.getStartDate();
			} 
		}
		return str;
	}
	
	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping(value = "/memberPwdSearch", method = RequestMethod.POST)
	public String memberPwdSearchPost(HttpSession session,
			@RequestParam(name = "name", defaultValue = "", required = false) String name,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(name = "email", defaultValue = "", required = false)String email) throws MessagingException {
		MemberVO vo = memberService.memberMidSearch(email);
		
		if(vo != null) {
			if(vo.getEmail().equals(email) && vo.getName().equals(name) && vo.getMid().equals(mid)) {
				// 메일로 임시 비밀번호 발급 후 DB저장 및 전송처리
				// 임시 비밀번호 6자리
				UUID uid = UUID.randomUUID();
				String pwd = uid.toString().substring(0,6);   
				
				// DB저장
				memberService.setMemberImsiPwd(mid, passwordEncoder.encode(pwd));
				
				// 임시 비밀번호 메일 주소로 전송처리
				String title = "임시 비밀번호";
				String mailFlag = "임시 비밀번호 : " + pwd;
				String res = mailSend(email,title,mailFlag);
				
				if(res == "1") {
					// 세션에 임시 비밀번호 발급 유무 설정
					session.setAttribute("imsiPwd", 1);
					return "1";
				}
			}
		}
		return "0";
	}
	
	// 메일 전송을 위한 메소드
	private String mailSend(String email, String title, String mailFlag) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String content = "";
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
		
		messageHelper.setTo(email);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		content = content.replace("\n", "<br />");
		content += "<br /><hr /><h3>임시 비밀번호가 발급되었습니다.해당 비밀번호로 가입 후 비밀번호 재설정을 해주세요.</h3>";
		content += "<br /><h3>"+mailFlag+"</h3><hr /><br />";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p><br />";
		content += "<p><h4>홈페이지 이동 : <a href='49.142.157.251:9090/cjgreen'>JavaProjectS2</a></h4></p>";
		content += "<hr />";
		messageHelper.setText(content,true);
		
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/data/main.jpg"));
		messageHelper.addInline("main.jpg", file);
		
		mailSender.send(message);
		
		return "1";
	}

	// 마이페이지 폼 띄우기
	@RequestMapping(value = "/memberPage", method = RequestMethod.GET)
	public String memberPageGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(session.getAttribute("pwdCheck") != null) {
			session.removeAttribute("pwdCheck");
		}
		
		// 월별 차트 분석
		LocalDate now = LocalDate.now();
		String year = now.getYear()+"";
		String month = now.getMonthValue()+"";
		if(month.length() == 1) {
			month = "0" + month;
		}
		
		List<HealthWriteVO> vos = memberService.getHealthWriteSearchList(mid);
		
		System.out.println("vos : " + vos);
		String[] date = new String[vos.size()];
		int[] weight = new int[vos.size()];
		
		int cnt = 0;
		for(HealthWriteVO v : vos) {
			System.out.println("v : " + v);
			if(v.getHealthDate().substring(0,4).equals(year) && v.getHealthDate().substring(5,7).equals(month)) {
				date[cnt] = v.getHealthDate().substring(8,10);
				weight[cnt] = v.getWeight();
				System.out.println("date : " + date[cnt]);
			}
			cnt++;
		}
				
		model.addAttribute("size",vos.size()-1);
		model.addAttribute("date",date);
		model.addAttribute("weight",weight);
		model.addAttribute("vo",vo);
		model.addAttribute("month",month);
		return "member/memberPage";
	}
	
	// 정보 수정 폼 띄우기위한 비밀번호 확인
	@RequestMapping(value = "/memberModify", method = RequestMethod.GET)
	public String memberModifyGet(Model model,HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		model.addAttribute("vo",vo);
		return "member/memberModify";
	}
	
	// 정보 수정하기
	@RequestMapping(value = "/memberModify", method = RequestMethod.POST)
	public String memberModifyPost(MemberVO vo) {
		if(vo.getPhoto().lastIndexOf(".") != -1) {
			memberService.imgCheck(vo.getPhoto());
		}
		return "member/memberModify";
	}
	
	// 비밀번호 수정 폼 띄우기
	@RequestMapping(value = "/memberPwdChange", method = RequestMethod.GET)
	public String memberPwdChangeGet(Model model,
			@RequestParam(name="sw", defaultValue = "", required = false) String sw ) {
		model.addAttribute("sw",sw);
		return "member/memberPwdChange";
	}
	
	// 비밀번호 수정을 위한 현재 비밀번호 체크
	@ResponseBody
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(String pwd, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		
		String res = "";
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("pwdCheck", "Ok");
			res = "1";
		} else {
			session.setAttribute("pwdCheck", "No");
		}
		return res;
	}
	
	// 비밀번호 수정
	@RequestMapping(value = "/memberPwdChangeOk", method = RequestMethod.GET)
	public String memberPwdChangeOkGet(HttpSession session, String pwd) {
		String mid = (String)session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		pwd = (passwordEncoder.encode(pwd));
		
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			return "redirect:/message/memberPwdChangeNo";
		} else {
			memberService.setMemberPwdChangeOk(mid,pwd);
			return "redirect:/message/memberPwdChangeOk";
		}
	}
	
	// 탈퇴하기 (userDel = OK로 변경)
	@ResponseBody
	@RequestMapping(value = "/memberDelOk", method = RequestMethod.POST)
	public String memberDelOkPost(String pwd, String mid) {
		System.out.println("pwd : " + pwd + ", mid : " + mid);
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		int res = 0;
		
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			res = memberService.setMemberDelOk(mid);
		}
		return res+"";
	}
	
	// 1:1 문의 폼 띄우기
	@RequestMapping(value = "/memberInquiryList", method = RequestMethod.GET)
	public String memberInquiryListGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag,pageSize,"inquiry","","","");
		String mid = (String)session.getAttribute("sMid");
		
		List<InquiryVO> vos = memberService.getMemberInquiryList(pageVO.getStartIndexNo(),pageSize,mid);
		System.out.println("vos : " + vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		return "member/memberInquiryList";
	}
	
	// 1:1 문의 작성 폼 띄우기
	@RequestMapping(value = "/memberinquiryInput", method = RequestMethod.GET)
	public String memberInquiryInputGet() {
		
		return "member/memberinquiryInput";
	}
	
	// 1:1 문의 작성하기
	@RequestMapping(value = "/memberinquiryInput", method = RequestMethod.POST)
	public String memberinquiryInputPost(InquiryVO vo) {
		int res = memberService.setMemberinquiryInput(vo);
		
		if(res != 0) {
			return "redirect:/message/memberInquiryInputOK";
		} else {
			return "redirect:/message/memberInquiryInputNO";
		}
	}
	
	// 작성자가 1:1 문의 내용 보기
	@RequestMapping(value = "/memberinquiryContent", method = RequestMethod.GET)
	public String memberinquiryContentGet(int idx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="admin", defaultValue = "", required = false) String admin) {
		InquiryVO vo = memberService.getMemberinquiryContent(idx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("admin",admin);
		
		return "member/memberinquiryContent";
	}
	
	// 문의건 삭제하기
	@RequestMapping(value = "/memberinquiryDel", method = RequestMethod.GET)
	public String memberinquiryDelGet(int idx) {
		
		int res = memberService.setmemberinquiryDel(idx);
		
		if(res != 0) {
			return "redirect:/message/memberinquiryDelOK";
		} else {
			return "redirect:/message/memberinquiryDelNO?idx="+idx;
		}
		
	}
	
	// 운동 수정 요청하기
	@ResponseBody
	@RequestMapping(value = "/healthModify", method = RequestMethod.POST)
	public String healthModifyPost(HttpSession session, ModifyVO vo) {
		int res = 0;
		vo.setRequestMid((String)session.getAttribute("sMid"));
		
		ModifyVO modifyVO = memberService.getHealthModify(vo.getHName(),vo.getRequestMid(),vo.getModifyPart());
		
		if(modifyVO == null) {
			res = memberService.setHealthModify(vo);
		} else {
			res = -1;
		}
		
		return res + "";
	}
	
	// 운동 기록 폼 띄우기
	@RequestMapping(value = "/healthWrite", method = RequestMethod.GET)
	public String healthWriteGet() {
		return "member/healthWrite";
	}
	
	// 운동 기록하기
	@RequestMapping(value = "/healthWrite", method = RequestMethod.POST)
	public String healthWritePost(HttpSession session ,HealthWriteVO vo, int HH, int MM) {
		String mid = (String)session.getAttribute("sMid");
		int today = 0;
		int healthTime = (HH *60) + MM;
		vo.setHealthTime(healthTime);
		vo.setMid(mid);
		
		List<HealthWriteVO> todayVOS = memberService.getHealthWriteList(mid);
		for(HealthWriteVO v : todayVOS) {
			if(v.getDate_diff() == 0) {
				today = 1;
			}
		}
		
		if(today != 1) {
			int res = memberService.setHealthWrite(vo);
			if(res != 0) {
				return "redirect://message/HealthWriteOK";
			} else {
				return "redirect://message/HealthWriteInputNO";
			}
		} else {
			return "redirect://message/HealthWriteNO";
		}
	}
	
	// 운동 기록 리스트 폼 띄우기
	@RequestMapping(value = "/healthWriteList", method = RequestMethod.GET)
	public String healthWriteListGet(HttpSession session ,Model model) {
		String mid = (String)session.getAttribute("sMid");
		List<HealthWriteVO> vos = memberService.getHealthWriteList(mid);
		model.addAttribute("vos",vos);
		return "member/healthWriteList";
	}
	
	// 운동 수정건 재수정
	@ResponseBody
	@RequestMapping(value = "/healthModifyChange", method = RequestMethod.POST)
	public String healthModifyChangePost(ModifyVO vo) {
		
		ModifyVO modifyVO = memberService.getHealthModify(vo.getHName(), vo.getRequestMid(), vo.getModifyPart());
		
		int res = 0;
		
		if(modifyVO != null) {
			res = memberService.setHealthModifyChange(vo.getModifyText(),vo.getRequestMid());
		}
		
		return res + "";
	}
	
	// 자신의 신고 목록 폼 띄우기
	@RequestMapping(value = "/memberComplaintList", method = RequestMethod.GET)
	public String memberComplaintListGet(HttpSession session,  Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		List<ComplaintVO> vos = memberService.getComplaintList(mid);
		System.out.println("vos : " + vos);
		model.addAttribute("vos", vos);
		
		return "member/memberComplaintList";
	}
}
