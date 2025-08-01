package com.foursquare.nextrozi.login.vo;

import lombok.Data;

@Data
public class LoginVO {
    // Common fields for login request
    private String email; // Used for company_email or member_email or master_id
    private String password; // Used for company_pwd or member_pwd or master_pwd
    private String companyCode; // Used for company_code in both tables

    // Fields for company registration (if applicable, currently from insertCompany in XML)
    private String confirmPassword;
    private String authCode;
    private String phone;
    private String companyName;
    private String companyOwnerName;

    // Fields for successful Company Login response
    // These will be populated from tb_company for company login
    private String company_email;
    private String company_pwd;
    private String company_ownername;


    // Fields for successful Member Login response
    // These will be populated from tb_member for member login
    private long member_id;
    private String member_email;
    private String member_pwd;
    private String member_name;

    // New: Fields for successful Master (Admin) Login response
    private String master_id;
    private String master_pwd;
}