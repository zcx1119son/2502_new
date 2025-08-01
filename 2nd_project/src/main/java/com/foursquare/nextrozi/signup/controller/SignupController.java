package com.foursquare.nextrozi.signup.controller;

import com.foursquare.nextrozi.signup.service.SignupService;
import com.foursquare.nextrozi.signup.vo.SignupVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/login")
public class SignupController {

    @Autowired
    private SignupService signupService;

    @GetMapping("/logincompany")
    public String showCompanySignupPage() {
        return "login/logincompany";
    }

    @GetMapping("/loginfirst")
    public String showMemberSignupPage() {
        return "login/loginfirst";
    }

    @PostMapping("/registerCompany")
    public String registerCompany(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            @RequestParam("ownerName") String ownerName,
            @RequestParam("companyCode") String companyCode,
            @RequestParam("companyPhone") String companyPhone
    ) {
        if (!password.equals(confirmPassword)) {
            return "redirect:/login/logincompany?error=passwordMismatch";
        }

        SignupVO signupVO = new SignupVO();
        signupVO.setCompany_email(email);
        signupVO.setCompany_pwd(password);
        signupVO.setCompany_ownername(ownerName);
        signupVO.setCompany_code(companyCode);
        signupVO.setCompany_name(ownerName);
        signupVO.setCompany_phone(companyPhone);

        boolean registrationSuccess = signupService.registerCompany(signupVO);

        if (registrationSuccess) {
            return "redirect:/login/registrationSuccess";
        } else {
            return "redirect:/login/logincompany?error=registrationFailed";
        }
    }

    @GetMapping("/registrationSuccess")
    public String registrationSuccessPage() {
        return "login/home";
    }

    @PostMapping("/checkEmail")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        boolean exists = signupService.isEmailExists(email);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/getVerificationCode")
    @ResponseBody
    public ResponseEntity<Map<String, String>> getVerificationCode(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        String verificationCode = signupService.generateVerificationCode(email);
        boolean emailSent = signupService.sendVerificationEmail(email, verificationCode);

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
        boolean verified = signupService.verifyCode(email, code);
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
    // ** 수정된 부분: @RequestBody Map<String, Boolean> -> @RequestBody Map<String, String> **
    public ResponseEntity<Map<String, Boolean>> validateCompanyCode(@RequestBody Map<String, String> payload) {
        String companyCode = payload.get("companyCode");
        boolean isValid = signupService.isValidCompanyCode(companyCode);
        Map<String, Boolean> response = new HashMap<>();
        response.put("isValid", isValid);
        return ResponseEntity.ok(response);
    }
}