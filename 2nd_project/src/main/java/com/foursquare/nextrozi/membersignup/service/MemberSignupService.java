package com.foursquare.nextrozi.membersignup.service;

import com.foursquare.nextrozi.membersignup.vo.MemberSignupVO;

public interface MemberSignupService {
    int registerMember(MemberSignupVO vo);
    boolean isEmailTaken(String email);
    String generateVerificationCode(String email);
    boolean verifyCode(String email, String code);
    boolean sendVerificationEmail(String toEmail, String verificationCode);
    boolean isValidCompanyCode(String companyCode);
}