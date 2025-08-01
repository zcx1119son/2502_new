package com.foursquare.nextrozi.signup.service;

import com.foursquare.nextrozi.signup.vo.SignupVO;

public interface SignupService {

    boolean registerCompany(SignupVO signupVO);

    boolean isEmailExists(String email);

    String generateVerificationCode(String email);
    boolean verifyCode(String email, String code);

    boolean sendVerificationEmail(String toEmail, String verificationCode);

    boolean isValidCompanyCode(String companyCode);
}