package com.foursquare.nextrozi.signup.dao;

import com.foursquare.nextrozi.signup.vo.SignupVO;
import org.apache.ibatis.annotations.Mapper;
// Removed @Insert, @Select, @Update annotations

@Mapper
public interface SignupDAO {

    // Method to insert a new company registration
    int insertCompany(SignupVO signupVO);

    // Method to check if an email already exists
    int countByEmail(String companyEmail);

    // Method to retrieve a company by email (for login/verification purposes)
    SignupVO selectCompanyByEmail(String companyEmail);

    // Method to check if a company code exists
    int countByCompanyCode(String companyCode);
}