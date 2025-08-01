package com.foursquare.nextrozi.signup.service;

import com.foursquare.nextrozi.signup.dao.SignupDAO;
import com.foursquare.nextrozi.signup.service.SignupService;
import com.foursquare.nextrozi.signup.vo.SignupVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class SignupServiceImpl implements SignupService {

    @Autowired
    private SignupDAO signupDAO;

    @Autowired
    private JavaMailSender mailSender;

    private static final Map<String, String> verificationCodes = new HashMap<>();

    @Override
    public boolean registerCompany(SignupVO signupVO) {
        signupVO.setCompany_pwd(signupVO.getCompany_pwd());
        signupVO.setCreated_date(new Date());
        signupVO.setCreated_id(signupVO.getCompany_email());

        try {
            if (signupDAO.countByEmail(signupVO.getCompany_email()) > 0) {
                return false;
            }
            int result = signupDAO.insertCompany(signupVO);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isEmailExists(String email) {
        return signupDAO.countByEmail(email) > 0;
    }

    @Override
    public String generateVerificationCode(String email) {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // 6-digit code
        String verificationCode = String.valueOf(code);
        verificationCodes.put(email, verificationCode);
        return verificationCode;
    }

    @Override
    public boolean verifyCode(String email, String code) {
        String storedCode = verificationCodes.get(email);
        if (storedCode != null && storedCode.equals(code)) {
            verificationCodes.remove(email);
            return true;
        }
        return false;
    }

    @Override
    public boolean sendVerificationEmail(String toEmail, String verificationCode) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(toEmail);
            message.setSubject("NEXtrozi 회원가입 이메일 인증");
            message.setText("안녕하세요,\n\nNEXtrozi 회원가입을 위한 인증번호는 " + verificationCode + " 입니다.\n\n감사합니다.");
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isValidCompanyCode(String companyCode) {
        return companyCode != null && !companyCode.trim().isEmpty();
    }
}