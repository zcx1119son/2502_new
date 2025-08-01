package com.foursquare.nextrozi.login.dao;

import com.foursquare.nextrozi.login.vo.LoginVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {
    // This method will check if the provided credentials match in tb_company
    LoginVO checkCompanyLogin(LoginVO vo);

    // This method will check if the provided credentials match in tb_member
    LoginVO checkMemberLogin(LoginVO vo);

    // New: This method will check if the provided credentials match in tb_master
    LoginVO checkMasterLogin(LoginVO vo);

    // Method for company registration (assuming this is still needed)
    int insertCompany(LoginVO vo);
}