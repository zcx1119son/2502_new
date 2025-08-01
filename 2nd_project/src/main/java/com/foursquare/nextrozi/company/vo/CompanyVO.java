package com.foursquare.nextrozi.company.vo;

import lombok.Data;

@Data
public class CompanyVO {
    private long member_id;
    private long department_id;
    private String member_name;
    private String member_email;
    private String department_name;
    private String job_title;
}