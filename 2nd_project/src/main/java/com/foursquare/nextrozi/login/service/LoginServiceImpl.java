package com.foursquare.nextrozi.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foursquare.nextrozi.login.dao.LoginDAO;
import com.foursquare.nextrozi.login.vo.LoginVO;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginDAO loginDAO;

    @Override
    public LoginVO companyLogin(LoginVO vo) {
        // Delegate to DAO to check credentials for company
        return loginDAO.checkCompanyLogin(vo);
    }

    @Override
    public LoginVO memberLogin(LoginVO vo) {
        // Delegate to DAO to check credentials for member
        return loginDAO.checkMemberLogin(vo);
    }

    @Override
    public LoginVO masterLogin(LoginVO vo) {
        // Delegate to DAO to check credentials for master
        return loginDAO.checkMasterLogin(vo);
    }
}