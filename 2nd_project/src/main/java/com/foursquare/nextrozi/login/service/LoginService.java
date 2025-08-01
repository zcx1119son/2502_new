package com.foursquare.nextrozi.login.service;

import com.foursquare.nextrozi.login.vo.LoginVO;

public interface LoginService {
    // Method for company login
    LoginVO companyLogin(LoginVO vo);

    // Method for member login
    LoginVO memberLogin(LoginVO vo);

    // New: Method for master (admin) login
    LoginVO masterLogin(LoginVO vo);
}