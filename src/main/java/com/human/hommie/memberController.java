package com.human.hommie;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.DTO.MemberDTO;
import com.human.service.IF_memberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class memberController {

	@Inject
	private IF_memberService msvc;

	// 로그인 화면으로 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpServletRequest h) throws Exception {
		// 로그인 화면으로 이동하면서 세션 비우기
		HttpSession session = h.getSession();
		session.invalidate();

		return "login/login";
	}

	// 비동기식 로그인 검사
	@ResponseBody
	@RequestMapping(value = "/login_chk", method = RequestMethod.POST)
	public int loginChk(@RequestBody MemberDTO m) throws Exception {
		int num = 0;
		System.out.println(m.getId() + "/" + m.getPw());
		if (m != null) {
			num = msvc.loginChk(m);
			System.out.println(num);
		}
		return num;
	}

	// 로그인 성공
	@RequestMapping(value = "/submit_login", method = RequestMethod.GET)
	public String submitLogin(@RequestParam String id, HttpServletRequest h) throws Exception {

		if (id != null) {
			HttpSession session = h.getSession();
			session.setAttribute("logID", id);
		}
		return "redirect:home";
	}

	// 로그아웃(홈으로 이동)
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest h) {
		HttpSession session = h.getSession();
		session.invalidate();

		return "redirect:home";
	}

	// 회원가입 화면으로 이동
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup() {
		return "login/signup";
	}

	// 아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "/signup_dupChk", method = RequestMethod.POST)
	public int dup(@RequestBody String memberid) {
		int count = 0;
		System.out.println(memberid);
		if (memberid != null) {
			count = msvc.dupChk(memberid);
			System.out.println(count);
		}
		return count;
	}

	// 회원가입 성공
	@RequestMapping(value = "/signup_submit", method = RequestMethod.GET)
	public String submitSignup(MemberDTO tempM, HttpServletRequest h) {
		int suc = msvc.signUp(tempM);

		if (suc == 1) {
			// 세션 등록
			HttpSession session = h.getSession();
			session.setAttribute("logID", tempM.getId());
			return "redirect:home";
		} else {
			return "login/signup";
		}
	}
}
