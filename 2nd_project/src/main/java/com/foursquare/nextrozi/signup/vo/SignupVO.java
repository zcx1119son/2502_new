package com.foursquare.nextrozi.signup.vo;

import lombok.Data;
import java.util.Date;

@Data
public class SignupVO {
    private String company_name;
    private String company_email;
    private String company_pwd;
    private String company_ownername;
    private String company_phone;

    private String company_code;

    private Date created_date;
    private String created_id;
    private Date updated_data;
    private String updated_id;
}