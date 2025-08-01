package com.foursquare.nextrozi.membersignup.contoller;

import com.foursquare.nextrozi.membersignup.service.MemberSignupService;
import com.foursquare.nextrozi.membersignup.vo.MemberSignupVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/membersignup")
public class MemberSignupController {

    @Autowired
    private MemberSignupService memberSignupService;

    @GetMapping("/loginfirst")
    public String showMemberSignupPage() {
        return "login/loginfirst";
    }

    @PostMapping("/registerMember")
    public String registerMember(
            @RequestParam("member_email") String email,
            @RequestParam("member_pwd") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            @RequestParam("member_name") String memberName,
            @RequestParam("company_code") String companyCode,
            @RequestParam("member_phone") String memberPhone
    ) {
        if (!password.equals(confirmPassword)) {
            return "redirect:/membersignup/registerMember?error=passwordMismatch";
        }

        MemberSignupVO memberSignupVO = new MemberSignupVO();
        memberSignupVO.setMember_email(email);
        memberSignupVO.setMember_pwd(password);
        memberSignupVO.setMember_name(memberName);
        memberSignupVO.setCompany_code(companyCode);
        memberSignupVO.setMember_phone(memberPhone);

        if (memberSignupService.isEmailTaken(email)) {
            return "redirect:/membersignup/registerMember?error=emailTaken";
        }

        if (!memberSignupService.isValidCompanyCode(companyCode)) {
            return "redirect:/membersignup/registerMember?error=invalidCompanyCode";
        }

        int registrationResult = memberSignupService.registerMember(memberSignupVO);

        if (registrationResult > 0) {
            return "redirect:/login/home";
        } else {
            return "redirect:/membersignup/registerMember?error=registrationFailed";
        }
    }

    @PostMapping("/checkEmail")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        boolean exists = memberSignupService.isEmailTaken(email);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/getVerificationCode")
    @ResponseBody
    public ResponseEntity<Map<String, String>> getVerificationCode(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        String verificationCode = memberSignupService.generateVerificationCode(email);
        boolean emailSent = memberSignupService.sendVerificationEmail(email, verificationCode);

        Map<String, String> response = new HashMap<>();
        if (emailSent) {
            response.put("status", "success");
            response.put("message", "인증번호가 이메일로 발송되었습니다.");
        } else {
            response.put("status", "error");
            response.put("message", "인증번호 발송에 실패했습니다.");
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/verifyCode")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> verifyCode(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        String code = payload.get("code");
        boolean verified = memberSignupService.verifyCode(email, code);
        Map<String, Boolean> response = new HashMap<>();
        response.put("verified", verified);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/confirmPassword")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> confirmPassword(@RequestBody Map<String, String> payload) {
        String password = payload.get("password");
        String confirmPassword = payload.get("confirmPassword");
        Map<String, Boolean> response = new HashMap<>();
        response.put("match", password.equals(confirmPassword));
        return ResponseEntity.ok(response);
    }

    @PostMapping("/validateCompanyCode")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> validateCompanyCode(@RequestBody Map<String, String> payload) {
        String companyCode = payload.get("companyCode");
        boolean isValid = memberSignupService.isValidCompanyCode(companyCode);
        Map<String, Boolean> response = new HashMap<>();
        response.put("isValid", isValid);
        return ResponseEntity.ok(response);
    }
}