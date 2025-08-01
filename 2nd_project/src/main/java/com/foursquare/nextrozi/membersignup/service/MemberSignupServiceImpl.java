package com.foursquare.nextrozi.membersignup.service;

import com.foursquare.nextrozi.membersignup.dao.MemberSignupDAO;
import com.foursquare.nextrozi.membersignup.vo.MemberSignupVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class MemberSignupServiceImpl implements MemberSignupService {

    @Autowired
    private MemberSignupDAO memberSignupDAO;

    @Autowired(required = false)
    private JavaMailSender mailSender;

    private static final Map<String, String> verificationCodes = new HashMap<>();

    @Override
    public int registerMember(MemberSignupVO vo) {
        vo.setCreated_date(new Date());
        vo.setCreated_id(vo.getMember_email());
        vo.setUpdated_data(new Date()); // updated_data 필드 추가
        vo.setUpdated_id(vo.getMember_email()); // updated_id 필드 추가

        try {
            if (memberSignupDAO.checkEmailExists(vo.getMember_email()) > 0) {
                return 0; // 이미 존재하는 이메일
            }
            return memberSignupDAO.insertMember(vo);
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // 에러 발생 시
        }
    }

    @Override
    public boolean isEmailTaken(String email) {
        return memberSignupDAO.checkEmailExists(email) > 0;
    }

    @Override
    public String generateVerificationCode(String email) {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
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
        if (mailSender == null) {
            System.err.println("JavaMailSender is not configured. Email cannot be sent.");
            return false;
        }
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