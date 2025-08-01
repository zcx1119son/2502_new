package com.foursquare.nextrozi.membersignup.vo;

import lombok.Data;
import java.util.Date;

@Data
public class MemberSignupVO {
    private String member_email;
    private String member_pwd;
    private String member_phone;
    private String member_name;

    private String company_code;

    private Date created_date;
    private String created_id;
    private Date updated_data;
    private String updated_id;
}