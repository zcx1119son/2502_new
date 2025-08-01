package com.foursquare.nextrozi.home.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class HomeVO {

    private Long eventId;
    private String eventTitle;
    private String memberName;
    private String eventContent;
    private String companyName;
    private String clientNote;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm", timezone = "Asia/Seoul")
    private Date eventStartDate;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm", timezone = "Asia/Seoul")
    private Date eventEndDate;

    private Long productId;
    private String productName;
    private Date createdDate;
    private String createdId;
    private Date updatedDate;
    private String updatedId;
    private String priority;
}
