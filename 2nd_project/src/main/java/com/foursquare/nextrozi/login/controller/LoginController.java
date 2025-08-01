package com.foursquare.nextrozi.login.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.foursquare.nextrozi.login.service.LoginService;
import com.foursquare.nextrozi.login.vo.LoginVO;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private LoginService loginService;

    // Redirect to the common login page (we can make this a choice page or default to company)
    @GetMapping("/login.do")
    public String showLoginPage() {
        return "/login/login"; // This could be a landing page to choose login type
    }

    // New: Show Master Login Page
    @GetMapping("/masterLogin.do")
    public String showMasterLoginPage() {
        return "/login/masterLogin"; // Path to the new master login JSP
    }

    // Handles company login requests (AJAX POST)
    @PostMapping("/doCompanyLogin") // Changed to doCompanyLogin
    @ResponseBody
    public ResponseEntity<Map<String, Object>> doCompanyLogin(
            @RequestBody LoginVO loginVO,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();
        try {
            LoginVO loggedInCompany = loginService.companyLogin(loginVO);

            if (loggedInCompany != null) {
                // Company login successful
                session.setAttribute("loggedInCompany", loggedInCompany);
                session.setAttribute("loginId", loggedInCompany.getCompany_email()); // Store company email
                session.setAttribute("companyCode", loggedInCompany.getCompanyCode()); // Store company code
                session.setAttribute("companyName", loggedInCompany.getCompanyName()); // Store company name
                session.setAttribute("companyOwnerName", loggedInCompany.getCompany_ownername()); // Store owner name

                response.put("success", true);
                response.put("message", "Company login successful!");
                response.put("redirectUrl", "/home"); // Example redirect for companies
                return new ResponseEntity<>(response, HttpStatus.OK);

            } else {
                // Company login failed
                response.put("success", false);
                response.put("message", "회사 로그인 정보가 올바르지 않습니다.");
                return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "회사 로그인 처리 중 오류가 발생했습니다: " + e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Handles member login requests (AJAX POST)
    @PostMapping("/doMemberLogin") // Changed to doMemberLogin
    @ResponseBody
    public ResponseEntity<Map<String, Object>> doMemberLogin(
            @RequestBody LoginVO loginVO,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();
        try {
            LoginVO loggedInMember = loginService.memberLogin(loginVO);

            if (loggedInMember != null) {
                // Member login successful
                session.setAttribute("loggedInMember", loggedInMember);
                session.setAttribute("memberId", loggedInMember.getMember_id()); // Store member ID
                session.setAttribute("memberEmail", loggedInMember.getMember_email()); // Store member email
                session.setAttribute("memberName", loggedInMember.getMember_name()); // Store member name
                session.setAttribute("companyCode", loggedInMember.getCompanyCode()); // Member's company code

                response.put("success", true);
                response.put("message", "멤버 로그인 성공!");
                response.put("redirectUrl", "/home"); // Example redirect for members
                return new ResponseEntity<>(response, HttpStatus.OK);
            } else {
                // Member login failed
                response.put("success", false);
                response.put("message", "멤버 로그인 정보가 올바르지 않습니다.");
                return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "멤버 로그인 처리 중 오류가 발생했습니다: " + e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // New: Handles master (admin) login requests (AJAX POST)
    @PostMapping("/doMasterLogin")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> doMasterLogin(
            @RequestBody LoginVO loginVO,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();
        try {
            LoginVO loggedInMaster = loginService.masterLogin(loginVO);

            if (loggedInMaster != null) {
                // Master login successful
                session.setAttribute("loggedInMaster", loggedInMaster);
                session.setAttribute("masterId", loggedInMaster.getMaster_id()); // Store master ID

                response.put("success", true);
                response.put("message", "관리자 로그인 성공!");
                response.put("redirectUrl", "/master/request_list.do"); // Example redirect for admin dashboard
                return new ResponseEntity<>(response, HttpStatus.OK);
            } else {
                // Master login failed
                response.put("success", false);
                response.put("message", "관리자 로그인 정보가 올바르지 않습니다.");
                return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "관리자 로그인 처리 중 오류가 발생했습니다: " + e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Handles logout for both company and member
    @GetMapping("/logout.do")
    public String logout(HttpSession session) {
        session.invalidate(); // Invalidate the current session
        return "redirect:/login/login.do"; // Redirect to login page
    }

    @GetMapping("/loginpass")
    public String showpassRegisterPage() {
        return "/login/loginpass";
    }
}