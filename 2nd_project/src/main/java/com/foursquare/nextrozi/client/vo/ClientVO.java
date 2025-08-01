package com.foursquare.nextrozi.client.vo;

import lombok.Data;

import java.sql.Date;

@Data
public class ClientVO {
    private long client_id;
    private String client_name;
    private String client_address;
    private String client_phone;
    private long member_id;
    private String member_name;
    private String client_note;
    private Date created_date;
    private String created_id;
    private Date updated_data;
    private String updated_id;
}
