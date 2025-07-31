package com.myspring.pro301.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myspring.pro301.member.service.MemberService;
import com.myspring.pro301.member.vo.MemberVO;

@RestController
@RequestMapping("/member/api")
public class MemberRestController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> login(
			@ModelAttribute("member") MemberVO member, 
			HttpServletRequest request){
		
		System.out.println("--------------------1");
		Map<String, Object> resMap = new HashMap<String, Object>();
		try {
			System.out.println("--------------------2");
			MemberVO memberVO = memberService.login(member);
			
			if(memberVO != null) {
				System.out.println("memberVO.getName() : "+memberVO.getName() );
				
				HttpSession session =request.getSession();
				session.setAttribute("member", memberVO);
				session.setAttribute("isLogOn", true);
				
				resMap.put("success", true);
				resMap.put("message", "로그인 성공");
				resMap.put("member", memberVO);
				
				return ResponseEntity.ok(resMap);
			}else {
				resMap.put("success", false);
				resMap.put("message", "아이디나 비밀번호가 틀립니다");
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(resMap);
			}
		}catch(Exception e) {
			System.out.println("에러~~~~~~");
			resMap.put("success", false);
			resMap.put("message", "로그인 처리 중 오류가 발생했습니다");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(resMap);
		}
	}
	
}
